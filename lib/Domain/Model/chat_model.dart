class ChatMessage {
  final String text;
  final bool isCurrentUser;
  final String timestamp;

  ChatMessage({
    required this.text,
    required this.isCurrentUser,
    required this.timestamp,
  });
}
