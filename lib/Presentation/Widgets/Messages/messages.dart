import 'package:dummy/Application/Services/Chat/chat_service.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Presentation/Widgets/Messages/Components/bottomchat_inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({required this.name, required this.uuid, super.key});
  final String name;
  final String uuid;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController messageController = TextEditingController();
  ChatService chatService = ChatService();
  FirebaseAuth auth = FirebaseAuth.instance;
  void sendMessages() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.uuid, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigate.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(widget.name),
            ),
          ];
        },
        body: StreamBuilder(
            stream: chatService.getMessage(widget.uuid, auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Stack(children: [
                    Container(
                      color: const Color.fromARGB(255, 245, 245, 245),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Gap.verticalSpace(40),
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff757575).withOpacity(0.1),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(6)),
                              height: 20.h,
                              width: 60.w,
                              child: const Text("Today")),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs
                                  .map((document) =>
                                      buildMessageItem(document, context))
                                  .toList(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ChatInputField(
                                messageController: messageController),
                          )
                        ],
                      ),
                    ),
                  ]),
                );
              }
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.messageController,
  });

  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                height: 66,
                width: 270,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/smile.svg",
                        height: 20,
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Message...",
                            contentPadding: EdgeInsets.all(9.sp),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/image.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        "assets/images/camera.svg",
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap.horizontalSpace(5),
            Expanded(
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      // isTyping
                      //     ? Icons.send
                      FontAwesomeIcons.microphone,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
