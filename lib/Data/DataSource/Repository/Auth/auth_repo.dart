import 'dart:developer';
import '../../Resources/imports.dart';

class AuthRepository {
  final APIs _authService;
  AuthRepository(this._authService);
  signInWithGoogle(BuildContext context) {
    const CircularProgressIndicator();
    APIs().signInWithGoogle();
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

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> signUpUser(
      {required ChatUser user, required String password}) async {
    try {
      UserCredential credential =
          await _authService.signUpWithEmailAndPassword(user.email!, password);
      user.id = credential.user!.uid;
      await _firestoreService.signUpUser(user: user, uid: user.id!);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
