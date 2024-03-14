import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Data/DataSource/Resources/imports.dart';

class ChatCard extends StatelessWidget {
  Message? message;
  ChatCard({
    super.key,
    required this.user,
  });

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    log(user.name!);
    return StreamBuilder(
      stream: APIs().getLastMessage(user),
      builder: (context, snapshot) {
        final data = snapshot.data?.docs;

        final list =
            data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

        if (list.isNotEmpty) {
          message = list[0];
        }
        log(list.toString());
        return ListTile(
          onTap: () {
            Navigate.to(
                context,
                ChatScreen(
                  user: user,
                ));
          },
          contentPadding: const EdgeInsets.all(3),
          leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: user.image != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50.h,
                      width: 50.h,
                      imageUrl: user.image!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : ClipOval(
                    child: CachedNetworkImage(
                      height: 50.h,
                      width: 50.h,
                      imageUrl:
                          "https://unsplash.com/photos/woman-with-dslr-camera-e616t35Vbeg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
          ),
          title: Text(
            user.name!,
            style: TextStyles.urbanist(context, fontSize: 18),
          ),
          subtitle: Row(
            children: [
              if (message != null && message!.type == Type.image)
                const Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  message != null
                      ? message!.type == Type.image
                          ? ""
                          : message!.msg!
                      : AppStrings.usingThisApp,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.urbanistMed(
                    context,
                    color: const Color(0xff272727),
                  ),
                ),
              ),
            ],
          ),
          trailing: message == null
              ? null
              : message!.read!.isEmpty && message!.fromId != APIs.user.uid
                  ? Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                    )
                  : Text(
                      MyDateUtil.getLastMessageTime(
                          context: context, time: message!.sent!),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
        );
      },
    );
  }
}
