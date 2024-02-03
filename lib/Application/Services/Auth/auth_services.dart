import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await auth.signOut();
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        firestore.collection("users").doc(userCredential.user!.uid).set({
          'uuid': user!.uid,
          'email': user.email,
          'displayName': user.displayName ?? '',
          'photoURL': user.photoURL,
        }, SetOptions(merge: true));
        log('user$user');
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          log('Error');
        } else if (e.code == 'invalid-credential') {
          log('Invalid Cred error');
        }
      }
    }
    return null;
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
