import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(googleAuthProvider);

      User? user = userCredential.user;

      if (user != null) {
        print("User is not null");
        Future.delayed(Duration.zero, () {
          // Navigate.toReplace(context, const BottomNavigationScreen());
        });
      } else {
        print("User is null");
      }
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
