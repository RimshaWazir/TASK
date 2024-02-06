import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildMessageItem(
    DocumentSnapshot documentSnapshot, BuildContext context) {
  Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  var timestamp = data["timestamp"] as Timestamp;
  var formattedTime = DateFormat('HH:mm').format(timestamp.toDate());
  log(data.toString());
  var isCurrentUser = (data["senderId"] == auth.currentUser!.uid);

  return Container(
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    margin: isCurrentUser
        ? const EdgeInsets.only(top: 10, left: 100, bottom: 10)
        : const EdgeInsets.only(top: 10, right: 100, bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: isCurrentUser ? const Color(0xff246BFD) : Colors.white,
      borderRadius: isCurrentUser
          ? const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )
          : const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            data["message"],
            style: TextStyles.urbanist(
              context,
              fontWeight: FontWeight.w400,
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        ),
        Text(
          formattedTime,
          style: TextStyle(
            color: isCurrentUser ? Colors.white70 : Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.end,
        ),
      ],
    ),
  );
}
