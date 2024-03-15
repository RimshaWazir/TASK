import 'dart:developer';
import 'package:dummy/Presentation/Widgets/Dashboard/Messages/Controllers/message_cubit.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/Messages/States/chat_state.dart';
import 'package:flutter/rendering.dart';
import '../../../../Data/DataSource/Resources/imports.dart';
import 'Controllers/notifiers.dart';

class UserDataNotifier extends ValueNotifier<List<ChatUser>> {
  UserDataNotifier(super.value);
}

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];

  final _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _showEmoji = false, _isUploading = false;

  UserDataNotifier _userDataNotifier = UserDataNotifier([]);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (Notifiers.scrollDownNotifier.value != true) {
          Notifiers.scrollDownNotifier.value = true;
        }
      } else {
        if (Notifiers.scrollDownNotifier.value != false) {
          Notifiers.scrollDownNotifier.value = false;
        }
      }
    });
    _userDataNotifier = UserDataNotifier([]);
    context.read<ChatCubit>().init();
  }

  @override
  void dispose() {
    context.read<ChatCubit>().close();
    Notifiers.scrollDownNotifier.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              title: ValueListenableBuilder<List<ChatUser>>(
                valueListenable: _userDataNotifier,
                builder: (context, users, child) {
                  final user = users.isNotEmpty ? users[0] : widget.user;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.isOnline!
                            ? 'Online'
                            : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: user.lastActive!,
                              ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            backgroundColor: const Color.fromARGB(255, 234, 248, 255),

            //body
            body: BlocBuilder<ChatCubit, ChatState>(
                bloc: context.read<ChatCubit>(),
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: APIs().getAllMessages(widget.user),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return const SizedBox();

                              case ConnectionState.active:
                              case ConnectionState.done:
                                final data = snapshot.data?.docs;
                                _list = data
                                        ?.map((e) => Message.fromJson(e.data()))
                                        .toList() ??
                                    [];

                                if (_list.isNotEmpty) {
                                  return ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 5.sp,
                                        );
                                      },
                                      reverse: true,
                                      controller: _scrollController,
                                      itemCount: _list.length,
                                      padding: const EdgeInsets.only(top: 1),
                                      itemBuilder: (context, index) {
                                        return MessageCard(
                                            message: _list[index]);
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

                      //progress indicator for showing uploading
                      if (_isUploading)
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))),
                      _chatInput(),
                      if (_showEmoji)
                        Offstage(
                          offstage: !_showEmoji,
                          child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              textEditingController: _textController,
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
                        )
                    ],
                  );
                }),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 65),
              child: ValueListenableBuilder(
                builder: (context, scrollData, ss) {
                  return scrollData == true
                      ? GestureDetector(
                          onTap: () {
                            _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.bounceInOut);
                          },
                          child: Card(
                            elevation: 4,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Center(
                                  child: Icon(
                                Icons.keyboard_double_arrow_down_outlined,
                                color: Colors.black,
                              )),
                            ),
                          ),
                        )
                      : const Stack();
                },
                valueListenable: Notifiers.scrollDownNotifier,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 400,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut);
    }
  }

  // app bar widget
  Widget _appBar() {
    return StreamBuilder(
        stream: APIs().getUserInfo(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //user name
              Text(list.isNotEmpty ? list[0].name! : widget.user.name!,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),

              //for adding some space
              const SizedBox(height: 2),

              //last seen time of user
              Text(
                  list.isNotEmpty
                      ? list[0].isOnline!
                          ? 'Online'
                          : MyDateUtil.getLastActiveTime(
                              context: context, lastActive: list[0].lastActive!)
                      : MyDateUtil.getLastActiveTime(
                          context: context,
                          lastActive: widget.user.lastActive!),
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          );
        });
  }

  // bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //pick image from gallery button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(() => _isUploading = true);
                          await APIs().sendChatImage(widget.user, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),

                  //take image from camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() => _isUploading = true);

                          await APIs()
                              .sendChatImage(widget.user, File(image.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),

                  const SizedBox(width: 2),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              try {
                if (_textController.text.isNotEmpty) {
                  if (_list.isEmpty) {
                    APIs().sendFirstMessage(
                        widget.user, _textController.text, Type.text);
                  } else {
                    APIs().sendMessage(
                        widget.user, _textController.text, Type.text);
                  }
                  _textController.text = '';
                  _scrollToBottom();
                }
              } catch (e, stackTrace) {
                print('Error occurred: $e');
                print('Stack trace: $stackTrace');
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.blue,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}
