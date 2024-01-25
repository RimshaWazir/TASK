import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              Gap.verticalSpace(244.h),
              ElevatedButton(
                onPressed: () {
                  Navigate.toReplace(context, const BottomNavigationScreen());
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Color.fromARGB(66, 234, 234, 234)),
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
              Gap.verticalSpace(140.h),
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
}
