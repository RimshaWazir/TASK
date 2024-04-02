import 'dart:convert';

import 'package:dummy/Data/AppData/data.dart';
import 'package:dummy/Domain/AuthModel/chat_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setUserLoginData({required ChatUser userRawData}) async =>
      await _preferences?.setString("user", jsonEncode(userRawData));

  static Future setLoginToken(String token) async =>
      await _preferences!.setString('token', token);

  //

  static String? getUserToken() {
    String? token;
    token = _preferences!.getString("token");

    if (token != null) {
      Data.app.token = token;
    }
    return token;
  }

  //
  static Future<ChatUser>? getUserLoginData() async {
    String? userJson;
    if (_preferences!.containsKey('user')) {
      userJson = _preferences!.getString("user");

      print(userJson.toString());

      if (userJson != null) {
        Map<String, dynamic> userData = jsonDecode(userJson);
        Data.app.user = ChatUser.fromJson(userData);
      }
    }
    return Future.value(Data.app.user);
  }

  static clearUserData() async {
    _preferences!.clear();
  }
}
