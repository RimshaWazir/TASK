import 'package:dummy/Domain/Model/message_model.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Message> messages;

  MessagesLoaded(this.messages);
}

class MessagesError extends MessagesState {
  final String errorMessage;

  MessagesError(this.errorMessage);
}
