import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController smsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 67, bottom: 40),
          child: Column(
            children: [
              Text('LogIn with google',
                  textAlign: TextAlign.center,
                  style: TextStyles.urbanist(context,
                      fontSize: 28, color: const Color(0xFF246BFD))),
              Text(
                  'Hello welcome again, please enter your \ncredentials so that we will log you in',
                  textAlign: TextAlign.center,
                  style: TextStyles.urbanistMed(
                    context,
                    fontSize: 16,
                    color: const Color(0xFF7B7B7B),
                  ).copyWith(
                    height: 25.09 / 16.0,
                    letterSpacing: 0.01,
                  )),
              Gap.verticalSpace(244),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _handleGoogleSigin,
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          style: BorderStyle.solid, color: Color(0xffE3E3E3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/google.svg",
                      ),
                      Gap.horizontalSpace(5.w),
                      Text(
                        'Login with Google',
                        style: TextStyles.urbanist(
                          context,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap.verticalSpace(200),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: phoneSigIn,
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          style: BorderStyle.solid, color: Color(0xffE3E3E3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/google.svg",
                      ),
                      Gap.horizontalSpace(5.w),
                      Text(
                        'Login with Phone Number',
                        style: TextStyles.urbanist(
                          context,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap.verticalSpace(200),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyles.urbanistMed(context,
                      fontSize: 13, color: const Color(0xFF7B7B7B)),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'By creating an account, you agree to our\n'),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyles.urbanist(
                        context,
                        fontSize: 13,
                        color: const Color(0xFF246BFD),
                      ),
                    ),
                    const TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyles.urbanist(
                        context,
                        fontSize: 13,
                        color: const Color(0xFF246BFD),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleGoogleSigin() async {
    try {
      GoogleAuthProvider gooleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(gooleAuthProvider);

      User? user = userCredential.user;

      if (user != null) {
        print("User is not null");
        Future.delayed(Duration.zero, () {
          Navigate.toReplace(context, const BottomNavigationScreen());
        });
      } else {
        print("User is null");
      }
    } catch (error) {
      print(error);
    }
  }

  void phoneSigIn() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        String smsCode = smsController.text;

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
