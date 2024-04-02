import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummy/Application/Services/ApiServices/apis.dart';
import 'package:dummy/Data/DataSource/Resources/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Data/DataSource/Resources/my_date_util.dart';
import '../../main.dart';
import '../../Domain/AuthModel/chat_user.dart';
import '../../Domain/ChatModel/message.dart';
import '../Widgets/Chat/screens/chat_screen.dart';

//card to represent a single user in home screen
class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    APIsService.fetchNotificationCount().then((count) {
      setState(() {
        notificationCount = count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          //for navigating to chat screen
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
        },
        child: StreamBuilder(
          stream: APIsService.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) _message = list[0];

            return ListTile(
              contentPadding: const EdgeInsets.all(10),
              //user profile picture
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .03),
                child: CachedNetworkImage(
                  width: mq.height * .06,
                  height: mq.height * .06,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
              //user name
              title: Text(
                widget.user.name,
                style: MyTextStyles.urbanist20(context).copyWith(fontSize: 18),
              ),

              //last message
              subtitle: Text(
                _message != null
                    ? _message!.type == Type.image
                        ? 'image'
                        : _message!.msg
                    : widget.user.about,
                maxLines: 1,
                style: MyTextStyles.urbanist14(context)
                    .copyWith(fontWeight: FontWeight.w500),
              ),

              //last message time
              trailing: _message == null
                  ? null //show nothing when no message is sent
                  : _message!.read.isEmpty &&
                          _message!.fromId != APIsService.user.uid
                      ?
                      //show for unread message
                      Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(notificationCount.toString()),
                        )
                      :
                      //message sent time
                      Text(
                          MyDateUtil.getLastMessageTime(
                              context: context, time: _message!.sent),
                          style: MyTextStyles.urbanist14(context)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
            );
          },
        ));
  }
}
