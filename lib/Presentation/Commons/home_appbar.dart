import 'dart:developer';

import 'package:dummy/Presentation/Commons/custom_textfield.dart';

import '../../Data/DataSource/Resources/imports.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
  });
  final textfield = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      pinned: false,
      floating: false,
      expandedHeight: 40.0,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(top: 35),
          title: CustomTextField(
              onTap: () async {
                APIs.updateActiveStatus(false);
                Navigate.toReplace(context, LoginScreen());
              },
              suffixIcon: SvgPicture.asset(
                Assets.filter,
                width: 20,
                height: 20,
              ),
              prefixIcon: SvgPicture.asset(
                Assets.search,
                width: 20,
                height: 20,
              ),
              controller: textfield,
              hintText: AppStrings.search,
              textInputType: TextInputType.name)),
    );
  }
}
