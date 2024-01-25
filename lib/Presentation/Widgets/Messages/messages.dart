import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Presentation/Widgets/Messages/Components/bottomchat_inputfield.dart';
import 'package:dummy/Presentation/Widgets/Messages/Components/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

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
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                children: [
                  Gap.verticalSpace(40),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff757575).withOpacity(0.1),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6)),
                      height: 20.h,
                      width: 60.w,
                      child: const Text("Today")),
                  Gap.verticalSpace(24),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: false,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: true,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: false,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: true,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: false,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: true,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: false,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: false,
                    timestamp: "10:00",
                  ),
                  const ChatBubble(
                    text: "Hi, morning too Andrew!",
                    isCurrentUser: true,
                    timestamp: "10:00",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomChatInputField(),
    );
  }
}
