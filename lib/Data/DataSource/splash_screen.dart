import 'dart:developer';

import 'package:dummy/Application/Services/ApiServices/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../main.dart';

import '../../Presentation/Widgets/Auth/login_screen.dart';
import '../../Presentation/Widgets/Dashboard/home_screen.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      if (APIsService.auth.currentUser != null) {
        log('\nUser: ${APIsService.auth.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return const Scaffold(
        body: Center(
      child: Text("Splash Screen"),
    ));
  }
}
