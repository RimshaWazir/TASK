import 'dart:developer';
import 'dart:io';

import 'package:dummy/Application/Services/Auth/auth_services.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/date_utils.dart';

import 'package:dummy/Data/DataSource/Resources/text_styles.dart';

import 'package:dummy/Domain/Model/chat_model.dart';
import 'package:dummy/Domain/Model/chat_user.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/dashboard.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessagesScreen extends StatefulWidget {
  bool _showEmoji = false;
  bool _isUploading = false;
  ChatUser user;
  MessagesScreen({required this.user, super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Message> list = [];
  final _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late FocusNode messageFocusNode;
  bool isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    messageFocusNode = FocusNode();
    messageFocusNode.addListener(_onFocusChange);
    APIs().getUserInfo(widget.user);
  }

  @override
  void dispose() {
    _textController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isTextFieldFocused = messageFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (widget._showEmoji) {
            setState(() => widget._showEmoji = !widget._showEmoji);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
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
                    title: StreamBuilder(
                      stream: APIs().getUserInfo(widget.user),
                      builder: (context, snapshot) {
                        final data = snapshot.data?.docs;

                        final list = data
                                ?.map((e) => ChatUser.fromJson(e.data()))
                                .toList() ??
                            [];

                        log(list.toString());

                        return Column(
                          children: [
                            Text(
                              list.isNotEmpty ? list[0].name : widget.user.name,
                            ),
                            Text(
                                list.isNotEmpty
                                    ? list[0].isOnline
                                        ? "Online"
                                        : MyDateUtil.getLastActiveTime(
                                            context: context,
                                            lastActive: list[0].lastActive)
                                    : MyDateUtil.getLastActiveTime(
                                        context: context,
                                        lastActive: widget.user.lastActive),
                                style: TextStyles.urbanist(context))
                          ],
                        );
                      },
                    ),
                  ),
                ];
              },
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: APIs().getAllMessages(widget.user),
                      // stream: APIs.getAllUsers(
                      //     snapshot.data?.docs.map((e) => e.id).toList() ?? []),

                      //get only those user, who's ids are provided
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          //if data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();

                          //if some or all data is loaded then show it
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (list.isNotEmpty) {
                              return ListView.builder(
                                  controller: _scrollController,
                                  reverse: true,
                                  itemCount: list.length,
                                  padding: const EdgeInsets.only(top: 10),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(
                                      currentUserUid: auth.currentUser!.uid,
                                      message: list[index],
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text('Say Hii! 👋',
                                    style: TextStyle(fontSize: 20)),
                              );
                            }
                        }
                      },
                    ),
                  ),
                  if (widget._isUploading)
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(children: [
                      Container(
                        height: 50,
                        width: 280,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();

                                setState(() {
                                  widget._showEmoji = !widget._showEmoji;
                                });
                              },
                              icon: Icon(
                                  widget._showEmoji
                                      ? Icons.keyboard
                                      : Icons.emoji_emotions,
                                  color: Colors.grey,
                                  size: 25),
                            ),
                            SizedBox(
                              height: 50,
                              width: 130,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _textController,
                                scrollController: _scrollController,
                                focusNode: messageFocusNode,
                                onTap: () {
                                  if (widget._showEmoji) {
                                    setState(() {
                                      widget._showEmoji = !widget._showEmoji;
                                      isTextFieldFocused = true;
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: "Message...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();

                                  final List<XFile> images = await picker
                                      .pickMultiImage(imageQuality: 70);

                                  for (var i in images) {
                                    log('Image Path: ${i.path}');
                                    setState(() => widget._isUploading = true);
                                    await APIs().sendChatImage(
                                        widget.user, File(i.path));
                                    setState(() => widget._isUploading = false);
                                  }
                                },
                                icon: const Icon(Icons.image,
                                    color: Colors.grey, size: 26)),
                            IconButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();

                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.camera,
                                      imageQuality: 70);
                                  if (image != null) {
                                    log('Image Path: ${image.path}');
                                    setState(() => widget._isUploading = true);

                                    await APIs().sendChatImage(
                                        widget.user, File(image.path));
                                    setState(() => widget._isUploading = false);
                                  }
                                },
                                icon: const Icon(Icons.camera_alt,
                                    color: Colors.grey, size: 26)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            shape: const CircleBorder(),
                            backgroundColor: Colors.blue,
                          ),
                          child: isTextFieldFocused
                              ? const Icon(
                                  Icons.send,
                                  size: 24,
                                  color: Colors.white,
                                )
                              : widget._showEmoji
                                  ? const Icon(
                                      Icons.send,
                                      size: 24,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.mic,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              APIs().sendMessage(
                                  widget.user, _textController.text, Type.text);
                              _textController.text = "";
                            }
                          },
                        ),
                      )
                    ]),
                  ),
                  if (widget._showEmoji)
                    Offstage(
                      offstage: !widget._showEmoji,
                      child: SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          textEditingController: _textController,
                          scrollController: _scrollController,
                          config: const Config(
                            height: 256,
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              emojiSizeMax: 28 * (1.0),
                            ),
                            swapCategoryAndBottomBar: false,
                            skinToneConfig: SkinToneConfig(),
                            categoryViewConfig: CategoryViewConfig(),
                            bottomActionBarConfig: BottomActionBarConfig(),
                            searchViewConfig: SearchViewConfig(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.currentUserUid,
  });

  final Message message;
  final String currentUserUid;

  @override
  Widget build(BuildContext context) {
    final bool isCurrentUser = message.fromId == currentUserUid;

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 10,
        left: isCurrentUser
            ? message.type == Type.image
                ? 200
                : 100
            : 10,
        right: isCurrentUser ? 10 : 100,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? message.type == Type.text
                ? const Color(0xff246BFD)
                : Colors.white
            : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isCurrentUser ? 16 : 8),
          topRight: Radius.circular(isCurrentUser ? 8 : 16),
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          message.type == Type.text
              ? Text(
                  message.msg,
                  style: TextStyles.urbanist(
                    context,
                    fontWeight: FontWeight.w400,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                )
              :
              //show image
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    message.msg,
                    height: 150,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
          const SizedBox(height: 4),
          Text(
            MyDateUtil.getFormattedTime(context: context, time: message.sent),
            style: TextStyle(
              color: isCurrentUser
                  ? message.type == Type.image
                      ? Colors.black
                      : Colors.white
                  : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
