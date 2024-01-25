import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomChatInputField extends StatelessWidget {
  const BottomChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12)),
              height: 0.07.sh,
              width: 0.75.sw,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/smile.svg",
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Message...",
                          contentPadding: EdgeInsets.all(9.sp),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/image.png",
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      "assets/images/camera.svg",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.microphone,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
