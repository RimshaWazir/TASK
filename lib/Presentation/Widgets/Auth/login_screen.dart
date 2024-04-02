import 'dart:developer';
import 'dart:io';

import 'package:dummy/Application/Services/ApiServices/apis.dart';
import 'package:dummy/Data/DataSource/Resources/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Data/DataSource/Dialogs/dialogs.dart';

import '../Dashboard/home_screen.dart';

//login screen -- implements google sign in or sign up feature for app
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();

    //for auto triggering animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isAnimate = true);
    });
  }

  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIsService.userExists())) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()));
        } else {
          await APIsService.createUser().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIsService.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //body
        body: Center(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const StadiumBorder(),
              elevation: 1),
          onPressed: () {
            _handleGoogleBtnClick();
          },

          //google icon
          icon: SvgPicture.asset(Assets.google),

          //login with google label
          label: const Text("Login with Google "),
        ),
      ),
    ));
  }
}
