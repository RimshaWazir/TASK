import 'package:dummy/Domain/Model/message_model.dart';
import 'package:flutter/material.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded(this.messages);
}

class ChatError extends ChatState {
  final String errorMessage;

  ChatError(this.errorMessage);
}
