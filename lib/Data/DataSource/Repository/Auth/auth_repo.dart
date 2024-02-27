import 'package:dummy/Application/Services/Auth/auth_services.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/dialogs.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final APIs _authService;
  AuthRepository(this._authService);
  signInWithGoogle(BuildContext context) {
    Dialogs.showProgressBar(context);
    APIs().signInWithGoogle().then((user) async {
      Navigate.pop(context);
      if (user != null) {
        Navigate.toReplace(context, const BottomNavigationScreen());
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
