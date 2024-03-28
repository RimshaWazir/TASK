import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Scale on BuildContext {
  double get textScale => MediaQuery.of(this).textScaleFactor;
}

class MyTextStyles {
  static double _textScale(
    BuildContext context,
  ) {
    return MediaQuery.of(context).textScaleFactor > 1.0
        ? 0.9
        : MediaQuery.of(context).textScaleFactor;
  }

  static TextStyle urbanist20(BuildContext context,
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
        fontSize: (fontSize ?? 20.0) * _textScale(context),
        letterSpacing: letterSpacing ?? 0,
        color: color ?? Colors.black,
        fontFamily: "Urbanist",
        fontWeight: fontWeight ?? FontWeight.w700);
  }

  static TextStyle urbanist14(BuildContext context,
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
        fontSize: (fontSize ?? 14.0) * _textScale(context),
        letterSpacing: letterSpacing ?? 0,
        color: color ?? Colors.black,
        fontFamily: "Urbanist",
        fontWeight: fontWeight ?? FontWeight.w600);
  }
  // static TextStyle plusJakartaSansLight(BuildContext context,
  //     {double? fontSize, Color? color}) {
  //   return TextStyle(
  //     fontSize: (fontSize ?? 14.0.sp) * _textScale(context),
  //     color: color ?? AppColors.blackColor,
  //     fontFamily: "PlusJakartaSans Light",
  //   );
  // }

  static TextStyle sfprotext(BuildContext context,
      {double? fontSize,
      Color? color,
      double height = 1.4,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
        letterSpacing: letterSpacing ?? -0.17,
        fontSize: (fontSize ?? 10.0.sp) * _textScale(context),
        color: color ?? Colors.black,
        fontFamily: "CircularStd Regular",
        height: height,
        fontWeight: fontWeight ?? FontWeight.w500);
  }

  static TextStyle circularStdMedium(BuildContext context,
      {double? fontSize, Color? color}) {
    return TextStyle(
        fontSize: (fontSize ?? 14.0.sp) * _textScale(context),
        color: color ?? Colors.black,
        fontFamily: "CircularStd Medium",
        fontWeight: FontWeight.w400);
  }
}
