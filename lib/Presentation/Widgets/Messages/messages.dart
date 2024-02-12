import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Application/Services/Chat/chat_service.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
  final ScrollController _scrollController = ScrollController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final StreamController<bool> _scrollDownStreamController =
      StreamController<bool>();
  void sendMessages() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.uuid, messageController.text);
      messageController.clear();
      _scrollDownStreamController.add(true);
    }
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // @override
  // void initState() {
  //   messageController.addListener(() {
  //     setState(() {});
  //   });

  //   super.initState();
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollDownStreamController.close();
    super.dispose();
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
                stream:
                    chatService.getMessage(widget.uuid, auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollToBottom();
                    });
                    return SizedBox(
                      height: 1.sh,
                      width: 1.sw,
                      child: Stack(children: [
                        Container(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 5,
                          ),
                          child: Column(
                            children: [
                              Gap.verticalSpace(40),
                              Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff757575)
                                          .withOpacity(0.1),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(6)),
                                  height: 20.h,
                                  width: 60.w,
                                  child: const Text("Today")),
                              Expanded(
                                child: ListView.builder(
                                  reverse: false,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildMessageItem(
                                        snapshot.data!.docs[index]);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black12)),
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
                                                    controller:
                                                        messageController,
                                                    onChanged: (value) {},
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintText: "Message...",
                                                      contentPadding:
                                                          EdgeInsets.all(9.sp),
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
                                              onPressed: sendMessages,
                                              icon: messageController
                                                      .text.isEmpty
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .microphone,
                                                      size: 24,
                                                      color: Colors.white,
                                                    )
                                                  : const Icon(
                                                      FontAwesomeIcons.share,
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
                })));
  }

  Widget buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    var timestamp = data["timestamp"] as Timestamp;
    var formattedTime = DateFormat('HH:mm').format(timestamp.toDate());
    log(data.toString());
    var isCurrentUser = (data["senderId"] == auth.currentUser!.uid);

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: isCurrentUser
          ? const EdgeInsets.only(top: 10, left: 100, bottom: 10)
          : const EdgeInsets.only(top: 10, right: 100, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser ? const Color(0xff246BFD) : Colors.white,
        borderRadius: isCurrentUser
            ? const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              data["message"],
              style: TextStyles.urbanist(
                context,
                fontWeight: FontWeight.w400,
                color: isCurrentUser ? Colors.white : Colors.black,
              ),
            ),
          ),
          Text(
            formattedTime,
            style: TextStyle(
              color: isCurrentUser ? Colors.white70 : Colors.black,
              fontSize: 12,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
