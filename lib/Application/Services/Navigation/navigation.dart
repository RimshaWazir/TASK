import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navigate {
  Navigate._();

  static to(BuildContext context, Widget child, {Duration? duration}) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            child: child,
            duration: duration ?? const Duration(milliseconds: 200)));
  }

  static toReplace(BuildContext context, Widget child) {
    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.topToBottom, child: child));
  }

  static toReplaceAll(BuildContext context, Widget child) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => child),
      (route) => false,
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
