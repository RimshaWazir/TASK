import 'package:flutter/material.dart';

class Notifiers {
  static ValueNotifier<bool> scrollDownNotifier = ValueNotifier(false);
  static const GlobalObjectKey scrollGroupedKey = GlobalObjectKey("ScrollKey");
}
