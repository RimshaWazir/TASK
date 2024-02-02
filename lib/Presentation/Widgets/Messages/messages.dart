import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Presentation/Widgets/Messages/Components/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool isTextFieldFocused = false;

  final CollectionReference<Map<String, dynamic>> messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
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
            title: const Text("Rimsha"),
          ),
          SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: messagesCollection.orderBy('timestamp').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<ChatBubble> chatBubbles =
                        snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data = doc.data();
                      return ChatBubble(
                        text: data['text'],
                        isCurrentUser: data['isCurrentUser'],
                        timestamp: (data['timestamp'] as Timestamp)
                            .toDate()
                            .toString(),
                      );
                    }).toList();

                    return Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
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
                          Gap.verticalSpace(24),
                          ...chatBubbles,
                        ],
                      ),
                    );
                  })),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                height: 0.07.sh,
                width: 0.75.sw,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/smile.svg",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextField(
                          onTap: () {
                            setState(() {
                              isTextFieldFocused = true;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              isTextFieldFocused = false;
                            });
                          },
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
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        String messageText = _messageController.text.trim();
                        if (messageText.isNotEmpty) {
                          messagesCollection.add({
                            'text': messageText,
                            'isCurrentUser': true,
                            'timestamp': DateTime.now().toString(),
                          });
                          _messageController.clear();
                        }
                      });
                    },
                    icon: Icon(
                        isTextFieldFocused ? Icons.send : Icons.attachment),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
