import 'dart:developer';
import 'package:dummy/Application/Services/Auth/auth_services.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/date_utils.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Domain/Model/chat_model.dart';

import 'package:dummy/Domain/Model/chat_user.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.dart';

import 'package:dummy/Presentation/Widgets/Messages/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _DashboardScreenState extends State<DashboardScreen> {
  ChatUser? user;
  final List<String> names = [
    "Taif",
    "Nisma",
    "Kamal",
    "Hina",
    "Rehman",
    "Rimsha",
    "Ayesha"
  ];

  final List<String> images = [
    'assets/images/6.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/1.png',
    'assets/images/7.png',
  ];
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    APIs.updateActiveStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resumed')) {
          APIs.updateActiveStatus(true);
        } else if ((message.toString().contains('inactive'))) {
          APIs.updateActiveStatus(false);
        } else if ((message.toString().contains('hidden'))) {
          APIs.updateActiveStatus(false);
        } else if ((message.toString().contains('paused'))) {
          APIs.updateActiveStatus(false);
        } else if ((message.toString().contains('detached'))) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    log(auth.toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  pinned: false,
                  floating: false,
                  expandedHeight: 40.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.zero,
                    title: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)),
                      height: 56,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/search.svg",
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Search",
                                  hintStyle: TextStyles.urbanistMed(context,
                                      color: const Color(0xff757575),
                                      fontWeight: FontWeight.w400),
                                  contentPadding: EdgeInsets.all(9.sp),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                APIs.updateActiveStatus(false);
                                APIs.auth = FirebaseAuth.instance;
                                APIs.auth.signOut().then((value) {
                                  Navigator.pop(context);
                                  Navigate.toReplace(
                                      context, const LoginScreen());
                                });
                              },
                              child: SvgPicture.asset(
                                "assets/images/filter.svg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.verticalSpace(24),
                Text(
                  "Recently",
                  style: TextStyles.urbanistLar(
                    context,
                  ),
                ),
                Gap.verticalSpace(24),
                SizedBox(
                  height: 0.16.sh,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.sp),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 60.h,
                              height: 60.w,
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Gap.verticalSpace(5),
                            Text(
                              names[index],
                              style: TextStyles.urbanistLar(context,
                                  color: const Color(0xff171717), fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Messages",
                  style: TextStyles.urbanistLar(
                    context,
                  ),
                ),
                StreamBuilder(
                    stream: APIs().getAllUsers(),
                    builder: (context, snapshot) {
                      log("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                      switch (snapshot.connectionState) {
                        // If data loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(
                              child: CircularProgressIndicator());
                        // If data load
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          list = data
                                  ?.map((e) => ChatUser.fromJson(e.data()))
                                  .toList() ??
                              [];
                          list.removeWhere(
                              (user) => user.id == auth.currentUser!.uid);

                          log(list.toString());
                          if (list.isNotEmpty) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return ChatCard(user: list[index]);
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("No Data found"),
                            );
                          }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildUserListItem(DocumentSnapshot document) {
  //   Map<String, dynamic> userData = document.data() as Map<String, dynamic>;

  //   // Check if the current user is not the same as the user in the list
  //   if (auth.currentUser!.email != userData['email']) {
  //     // Access the last message data from the Firestore collection
  //     FirebaseFirestore.instance
  //         .collection('messages')
  //         .doc('your_document_id')
  //         .collection('messages')
  //         .orderBy('timestamp', descending: true)
  //         .limit(1)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       if (querySnapshot.docs.isNotEmpty) {
  //         DocumentSnapshot lastMessage = querySnapshot.docs.first;

  //         Map<String, dynamic> lastMessageData =
  //             lastMessage.data() as Map<String, dynamic>;

  //         // Create a ListTile widget to display user information and last message
  //         return Expanded(
  //             child: ListTile(
  //           onTap: () {
  //             Navigate.to(
  //               context,
  //               MessagesScreen(
  //                 name: userData["displayName"],
  //                 uuid: userData["uuid"],
  //               ),
  //             );
  //           },
  //           contentPadding: const EdgeInsets.all(0),
  //           leading: Container(
  //             decoration: const BoxDecoration(shape: BoxShape.circle),
  //             child: ClipOval(
  //               child: Image.network(
  //                 userData['photoURL'],
  //                 height: 50,
  //                 width: 50,
  //               ),
  //             ),
  //           ),
  //           title: Text(
  //             userData['displayName'],
  //             style: TextStyles.urbanist(context, fontSize: 18),
  //           ),
  //           subtitle: Text(
  //             lastMessageData['message'], // Display last message
  //             style: TextStyles.urbanistMed(
  //               context,
  //               color: const Color(0xff272727),
  //             ),
  //           ),
  //           trailing: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Optionally, you can display message timestamp here
  //               Text(
  //                 lastMessageData['timestamp'],
  //                 style: TextStyles.urbanistMed(context),
  //               ),
  //             ],
  //           ),
  //         ));
  //       } else {
  //         return const Center(child: Text("no data "));
  //       }
  //     });
  //   }
  //   return const Center(child: Text("no data found  "));
  // }
}

class ChatCard extends StatelessWidget {
  Message? message;
  ChatCard({
    super.key,
    required this.user,
  });

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    log(user.name);
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
                MessagesScreen(
                  user: user,
                ));
          },
          contentPadding: const EdgeInsets.all(3),
          leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.network(
                user.image.toString(),
                height: 50,
                width: 50,
              ),
            ),
          ),
          title: Text(
            user.name,
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
                          : message!.msg
                      : "Hy! There I am using this App",
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
              : message!.read.isEmpty && message!.fromId != APIs.user.uid
                  ? Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    )
                  : Text(
                      MyDateUtil.getLastMessageTime(
                          context: context, time: message!.sent),
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
