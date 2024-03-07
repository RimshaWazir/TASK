import 'dart:developer';
import 'package:dummy/Data/DataSource/Resources/assets.dart';
import 'package:dummy/Data/DataSource/Resources/gap.dart';
import 'package:dummy/Data/DataSource/Resources/strings.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/State/login.state.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/Controllers/login_cubit.dart';
import 'package:dummy/Presentation/Widgets/Auth/Phone/Controllers/phone_cubit.dart';
import 'package:dummy/Presentation/Widgets/Auth/Phone/State/phone_state.dart';
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
      body: BlocConsumer<PhoneCubit, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthError) {
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
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: AppStrings.phone),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<PhoneCubit>().signInWithPhoneNumber(
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
                            Assets.call,
                          ),
                          Gap.horizontalSpace(5.w),
                          Text(
                            AppStrings.continueWithMobile,
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
                          decoration: InputDecoration(
                            labelText: AppStrings.verificationCode,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          child: Text(AppStrings.verifyCode),
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
