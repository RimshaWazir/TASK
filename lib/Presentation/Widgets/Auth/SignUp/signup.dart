import 'package:dummy/Data/DataSource/Resources/imports.dart';
import 'package:dummy/Data/DataSource/Resources/validator.dart';
import 'package:dummy/Presentation/Commons/Dialogs/loading.dart';
import 'package:dummy/Presentation/Commons/custom_textfield.dart';
import 'package:dummy/Presentation/Commons/widgets.dart';
import 'package:dummy/Presentation/Widgets/Auth/SignUp/Controller/hide_show_password.dart';
import 'package:dummy/Presentation/Widgets/Auth/SignUp/Controller/sign_up_cubit.dart';

import 'State/sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final email = TextEditingController();

  final password = TextEditingController();

  final firstName = TextEditingController();

  bool checked = false;

  bool onTapField = false;

  final formKey = GlobalKey<FormState>();
  void _signUp() {
    if (formKey.currentState!.validate()) {
      var user = ChatUser(
        email: email.text.trim(),
        name: firstName.text.trim(),
      );
      context
          .read<SignUpCubit>()
          .signUp(email.text.trim(), password.text.trim(), user);
    }
  }

  // final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 100.sp),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                      contentPadding: EdgeInsets.symmetric(vertical: 13.sp),
                      prefixIcon: const Icon(Icons.person),
                      controller: firstName,
                      hintText: "firstname",
                      textInputType: TextInputType.text,
                      validator: Validate.name,
                      borderRadius: 25.sp),
                  CustomTextField(
                      contentPadding: EdgeInsets.symmetric(vertical: 13.sp),
                      prefixIcon: const Icon(Icons.email),
                      controller: email,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      validator: Validate.email,
                      borderRadius: 25.sp),
                  ValueListenableBuilder(
                    valueListenable: SignUpControllers.passwordShowHide,
                    builder: (context, value, child) {
                      return CustomTextField(
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: value,
                          suffixIcon: InkWell(
                              onTap: () {
                                SignUpControllers.passwordShowHide.value =
                                    !value;
                              },
                              child: value == false
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye)),
                          contentPadding: EdgeInsets.symmetric(vertical: 13.sp),
                          controller: password,
                          validator: Validate.password,
                          hintText: "password",
                          textInputType: TextInputType.text,
                          borderRadius: 25.sp);
                    },
                  ),
                  BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpLoading) {
                        Loading.showLoading(context);
                      }
                      if (state is SignUpError) {
                        Navigator.of(context).pop(true);
                        Widgets.instance.snackBar(
                          context,
                          text: state.error,
                          bgColor: Colors.blue,
                          textStyle: TextStyles.urbanistMed(context,
                              color: Colors.white),
                        );
                      }
                      if (state is SignUpLoaded) {
                        Navigator.pop(context);
                        BottomNotifier.bottomNavigationNotifier.value = 0;
                        Navigate.toReplace(
                            context, const BottomNavigationScreen());
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => _signUp(),
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
                          child: Text(
                            state is SignUpLoading ? "Loading..." : "SignUp",
                            style: TextStyles.urbanist(
                              context,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigate.to(context, LoginScreen());
                    },
                    child: Text(
                      "Login",
                      style:
                          TextStyles.urbanistMed(context, color: Colors.black),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
