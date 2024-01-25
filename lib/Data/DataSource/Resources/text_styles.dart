import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle urbanist(BuildContext context,
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
      fontSize: (fontSize ?? 16.0.sp),
      letterSpacing: letterSpacing ?? 0,
      color: color ?? Colors.black,
      fontFamily: "Urbanist",
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  static TextStyle urbanistMed(BuildContext context,
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
      fontSize: (fontSize ?? 14.0.sp),
      letterSpacing: letterSpacing ?? 0,
      color: color ?? Colors.black,
      fontFamily: "Urbanist",
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }

  static TextStyle urbanistLar(BuildContext context,
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
      fontSize: (fontSize ?? 20.0.sp),
      letterSpacing: letterSpacing ?? 0,
      color: color ?? Colors.black,
      fontFamily: "Urbanist",
      fontWeight: fontWeight ?? FontWeight.w600,
    );
  }

  static TextStyle selectedAndUnseletedStyle(BuildContext context,
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return TextStyle(
      fontSize: (fontSize ?? 10.0.sp),
      letterSpacing: letterSpacing ?? 0,
      color: color ?? Colors.blue,
      fontFamily: "Urbanist",
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }
}
