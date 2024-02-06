import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Domain/Model/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ////Send Message

  Future<void> sendMessage(String recieverId, String message) async {
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserName = auth.currentUser!.displayName!;
    final Timestamp timestamp = Timestamp.now();

    ChatMessage chatMessage = ChatMessage(
      senderId: currentUserId,
      name: currentUserName,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> id = [currentUserId, recieverId];
    id.sort();
    String conversationId = id.join("_");

    await firestore
        .collection("conversation")
        .doc(conversationId)
        .collection("messages")
        .add(chatMessage.toMap());
  }

  ///Get Messages
  Stream<QuerySnapshot> getMessage(String userId, String anotherUserId) {
    List<String> id = [userId, anotherUserId];
    id.sort();
    String conversationId = id.join("_");

    return firestore
        .collection("conversation")
        .doc(conversationId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
