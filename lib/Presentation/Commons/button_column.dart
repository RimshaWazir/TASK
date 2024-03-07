import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/assets.dart';
import 'package:dummy/Data/DataSource/Resources/gap.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/Controllers/login_cubit.dart';
import 'package:dummy/Presentation/Widgets/Auth/Phone/phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ButtonColumn extends StatelessWidget {
  const ButtonColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap.verticalSpace(24),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                context.read<LoginCubit>().signInWithGoogle(context);
              });
            },
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
                SvgPicture.asset(Assets.google),
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
                    style: BorderStyle.solid, color: Color(0xffE3E3E3)),
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
  }
}
