import 'package:dummy/Application/Services/Auth/auth_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthService _authService;
  AuthRepository(this._authService);
  Future<User?> signInWithGoogle() async {
    User? user = await AuthService.signInWithGoogle();

    if (user != null) {
      await saveUserDataInPreferences("user_id", user.uid);
    }
    return user;
  }

  Future<void> saveUserDataInPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getUserDataFromPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(AuthCredential) onVerificationCompleted,
    required Function(String, int) onCodeSent,
  }) async {
    await _authService.signInWithPhoneNumber(
      phoneNumber,
      onVerificationCompleted: onVerificationCompleted,
      onCodeSent: onCodeSent,
    );
  }
}
