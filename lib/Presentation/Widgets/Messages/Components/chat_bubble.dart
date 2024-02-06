// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
// import 'package:flutter/material.dart';

// class ChatBubble extends StatelessWidget {
//   String name;
//   final String senderId;
//   final String recieverId;
//   final String message;
//   final Timestamp timestamp;

//   ChatBubble({
//     super.key,
//     required this.senderId,
//     required this.name,
//     required this.recieverId,
//     required this.message,
//     required this.timestamp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//       decoration: BoxDecoration(
//         color: senderId ? Colors.blue : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             text,
//             style: TextStyles.urbanist(
//               context,
//               fontWeight: FontWeight.w400,
//               color: isCurrentUser ? Colors.white : Colors.black,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             timestamp,
//             style: TextStyle(
//               color: isCurrentUser ? Colors.white70 : Colors.black,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
