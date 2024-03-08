import 'dart:developer';
import '../../Resources/imports.dart';

class AuthRepository {
  final APIs _authService;
  AuthRepository(this._authService);
  signInWithGoogle(BuildContext context) {
    const CircularProgressIndicator();
    APIs().signInWithGoogle().then((user) async {
      Navigate.pop(context);
      if (user != null) {
        Navigate.toReplace(context, const BottomNavigationScreen());
      } else {
        log("error");
      }
    });
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
