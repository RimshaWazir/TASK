import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/Messages/States/chat_state.dart';
import 'package:dummy/Data/DataSource/Resources/imports.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUser user;
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _subscription;

  ChatCubit(this.user) : super(ChatInitial());

  Future<void> init() async {
    emit(ChatLoading());

    try {
      final messageData = APIs().getUserInfo(user);
      _subscription = messageData.listen((snapshot) {
        final messages =
            snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
        emit(ChatLoaded(messages));
      });
    } catch (e) {
      emit(ChatError('Failed to load messages: $e'));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
