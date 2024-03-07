import 'dart:developer';
import 'package:dummy/Data/DataSource/Resources/gap.dart';
import 'package:dummy/Data/DataSource/Resources/strings.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Commons/button_column.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/State/login.state.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/Controllers/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
                Text(AppStrings.loginWithGoogle,
                    textAlign: TextAlign.center,
                    style: TextStyles.urbanist(context,
                        fontSize: 28, color: const Color(0xFF246BFD))),
                Text(AppStrings.welcome,
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
                    if (state is AuthError) {
                      Text(state.errorMessage);
                    }
                  },
                  builder: (context, state) {
                    log(state.toString());
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const ButtonColumn();
                  },
                ),
                Gap.verticalSpace(100),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyles.urbanistMed(context,
                        fontSize: 13, color: const Color(0xFF7B7B7B)),
                    children: <TextSpan>[
                      TextSpan(text: AppStrings.creatingAccount),
                      TextSpan(
                        text: AppStrings.privacyPolicy,
                        style: TextStyles.urbanist(
                          context,
                          fontSize: 13,
                          color: const Color(0xFF246BFD),
                        ),
                      ),
                      TextSpan(
                        text: AppStrings.and,
                      ),
                      TextSpan(
                        text: AppStrings.termOfUse,
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
