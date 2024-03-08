import 'dart:developer';
import '../../../Data/DataSource/Resources/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    checkAuthState();
  }

  Future<void> checkAuthState() async {
    await Future.delayed(const Duration(seconds: 2));
    log(auth.currentUser.toString());

    if (auth.currentUser != null) {
      Navigate.toReplace(context, const BottomNavigationScreen());
    } else {
      Navigate.toReplace(context, LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
