import 'package:dummy/Application/Services/ApiServices/Apis.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/assets.dart';
import 'package:dummy/Data/DataSource/Resources/strings.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      pinned: false,
      floating: false,
      expandedHeight: 40.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12)),
          height: 56,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.search,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: AppStrings.search,
                      hintStyle: TextStyles.urbanistMed(context,
                          color: const Color(0xff757575),
                          fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.all(9.sp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // Update active status
                    APIs.updateActiveStatus(false);

                    // Sign out the user
                    try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      Navigate.toReplace(context, LoginScreen());
                    } catch (e) {
                      print('Error signing out: $e');
                      // Handle error
                    }
                  },
                  child: SvgPicture.asset(
                    Assets.filter,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
