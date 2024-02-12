import 'dart:developer';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.state.dart';
import 'package:dummy/Presentation/Widgets/Auth/login_cubit.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginAuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            log(state.errorMessage);
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "+9203127282936"),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().signInWithPhoneNumber(
                              _phoneNumberController.text,
                            );
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
                  if (state is AuthCodeSent)
                    Column(
                      children: [
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _verificationCodeController,
                          decoration: const InputDecoration(
                            labelText: "Verification code",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          child: const Text("Verify code"),
                          onPressed: () async {
                            final state = context.read<LoginCubit>().state;
                            final credential = PhoneAuthProvider.credential(
                              verificationId:
                                  (state as AuthCodeSent).verificationId,
                              smsCode: _verificationCodeController.text,
                            );
                            FirebaseAuth.instance
                                .signInWithCredential(credential)
                                .then((value) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      const BottomNavigationScreen()),
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
