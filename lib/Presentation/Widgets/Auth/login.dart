import 'dart:developer';

import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.state.dart';
import 'package:dummy/Presentation/Widgets/Auth/login_cubit.dart';
import 'package:dummy/Presentation/Widgets/Auth/phone.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                BlocConsumer<LoginCubit, LoginAuthState>(
                  listener: (context, state) {
                    // if (state is AuthError) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return const Dialog(
                    //         child: Text("errors"),
                    //       );
                    //     },
                    //   );
                  },
                  builder: (context, state) {
                    log(state.toString());
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap.verticalSpace(24),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                context
                                    .read<LoginCubit>()
                                    .signInWithGoogle(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: Color(0xffE3E3E3)),
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
                        Gap.verticalSpace(24),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigate.toReplace(context, const PhoneScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: Color(0xffE3E3E3)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/call.svg",
                                ),
                                Gap.horizontalSpace(5.w),
                                Text(
                                  'Continue with Mobile Number',
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
                      ],
                    );
                  },
                ),
                Gap.verticalSpace(100),
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
                ),
              ],
            ),
          ),
        ));
  }
}
