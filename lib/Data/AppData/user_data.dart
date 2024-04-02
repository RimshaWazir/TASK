import 'package:dummy/Domain/AuthModel/chat_user.dart';

mixin UserData {
  static String? userToken;

  static ChatUser? userData;

  set token(String? token) => userToken = token;

  set user(ChatUser? userModel) => userData = userModel;

  ChatUser? get user => userData;

  String? get token => userToken;
}
