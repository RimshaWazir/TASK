// import 'dart:developer';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:dummy/Application/Services/ApiServices/Apis.dart';
// import 'package:dummy/Data/DataSource/Resources/date_utils.dart';
// import 'package:dummy/Data/DataSource/Resources/strings.dart';
// import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
// import 'package:dummy/Domain/Model/chat_user_model.dart';
// import 'package:dummy/Domain/Model/message_model.dart';
// import 'package:dummy/Presentation/Widgets/Dashboard/Messages/States/message_state.dart';
 
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MessagesCubit extends Cubit<MessagesState> {
//   final ChatUser user;
//   final APIs apiService;
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   List<Message> messages = [];
//   bool showEmoji = false;
//   bool isUploading = false;
//   final TextEditingController textController = TextEditingController();
//   final ScrollController scrollController = ScrollController();
//   late FocusNode messageFocusNode;
//   bool isTextFieldFocused = false;

//   MessagesCubit({required this.user, required this.apiService})
//       : super(MessagesInitial()) {
//     messageFocusNode = FocusNode();
//     messageFocusNode.addListener(_onFocusChange);
//     loadMessages();
//   }

//   void _onFocusChange() {
//     isTextFieldFocused = messageFocusNode.hasFocus;
//   }

// void loadMessages() async {
//   emit(MessagesLoading());
//   try {
//     final data = apiService.getAllMessages(user); // await here
//     messages = apiService.getAllMessages(user)?.map((e) => Message.fromJson(e.data())).toList();
//     emit(MessagesLoaded(messages));
//   } catch (e) {
//     emit(MessagesError(e.toString()));
//   }
// }

//   void sendMessage(String messageText) async {
//     if (messageText.isNotEmpty) {
//       if (messages.isEmpty) {
//         await apiService.sendFirstMessage(user, messageText, Type.text);
//       } else {
//         await apiService.sendMessage(user, messageText, Type.text);
//       }
//       textController.text = '';
//     }
//   }

//   void sendImage(File imageFile) async {
//     log('Image Path: ${imageFile.path}');
//     isUploading = true;
//     emit(MessagesLoading());
//     await apiService.sendChatImage(user, imageFile);
//     isUploading = false;
//     emit(MessagesLoaded(messages));
//   }

//   @override
//   Future<void> close() {
//     textController.dispose();
//     messageFocusNode.dispose();
//     scrollController.dispose();
//     return super.close();
//   }
// }
 
//   final MessagesCubit messagesCubit;

//   const MessagesScreen({Key? key, required this.messagesCubit})
//       : super(key = key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<MessagesCubit, MessagesState>(
//         bloc: messagesCubit,
//         listener: (context, state) {
//           // Handle state changes if needed
//           if (state == MessagesState.error) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Error occurred'),
//               ),
//             );
//           }
//         },
//         child: BlocBuilder<MessagesCubit, MessagesState>(
//           bloc: messagesCubit,
//           builder: (context, state) {
//             // Build UI based on state
//             switch (state) {
//               case MessagesState.loading:
//                 return const Center(child: CircularProgressIndicator());
//               case MessagesState.loaded:
//                 return buildMessagesListView(context); // Implement this method
//               default:
//                 return const SizedBox(); // Handle other states if needed
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildMessagesListView(BuildContext context) {
//     final mess
