import 'package:dummy/Data/DataSource/Resources/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomIcon extends StatelessWidget {
  Function() ontap;
  String image;
  int? state;
  String text;
  BottomIcon({
    this.state,
    required this.ontap,
    required this.image,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            color: state == state ? Colors.blue : Colors.black,
          ),
          Text(text,
              style: MyTextStyles.sfprotext(
                context,
                color: state == state ? Colors.blue : Colors.black,
              )),
        ],
      ),
    );
  }
}
