import 'package:flutter/material.dart';

void snackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.blue.withOpacity(0.8),
    behavior: SnackBarBehavior.floating,
  ));
}
