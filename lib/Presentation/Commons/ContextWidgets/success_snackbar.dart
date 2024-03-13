import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:flutter/material.dart';

SnackBar successSnackBar(
    {required String? text,
    required BuildContext context,
    required Color? bgColor,
    TextStyle? textStyle}) {
  return SnackBar(
    content: Text(text!, style: textStyle ?? TextStyles.urbanistMed(context)),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    duration: const Duration(milliseconds: 1100),
    backgroundColor: bgColor ?? Theme.of(context).snackBarTheme.backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: Theme.of(context).snackBarTheme.shape,
  );
}
