import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String name;
  final String senderId;
  final String recieverId;
  final String message;
  final Timestamp timestamp;

  ChatMessage({
    required this.senderId,
    required this.name,
    required this.recieverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'name': name,
      'message': message,
      'recieverId': recieverId,
      'timestamp': timestamp,
    };
  }
}
