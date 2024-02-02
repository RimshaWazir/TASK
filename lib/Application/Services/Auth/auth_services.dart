import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(googleAuthProvider);

      return userCredential.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(AuthCredential) onVerificationCompleted,
    required Function(String, int) onCodeSent,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        onVerificationCompleted(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (id, resendToken) {
        onCodeSent(id, resendToken!);
      },
      codeAutoRetrievalTimeout: (id) {},
    );
  }
}
