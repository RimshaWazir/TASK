import 'package:dummy/Data/DataSource/Resources/imports.dart';

class Widgets {
  Widgets._private();
  static final instance = Widgets._private();
  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> snackBar(
      BuildContext context,
      {String? text,
      Color? bgColor,
      TextStyle? textStyle}) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text!,
        style:
            textStyle ?? TextStyles.urbanistMed(context, color: Colors.white),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      duration: const Duration(seconds: 2),
      backgroundColor: bgColor ?? Colors.blue,
      behavior: SnackBarBehavior.floating,
      shape: Theme.of(context).snackBarTheme.shape,
    ));
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> toast(
      BuildContext context, SnackBar snackBar) async {
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  dialog(BuildContext context,
      {required Widget child,
      double radius = 12,
      double elevation = 4,
      Color? bgColor,
      bool clickOutSideClose = true,
      AlignmentGeometry? alignment,
      EdgeInsets? insetsPadding,
      Curve curve = Curves.decelerate,

      /// [insetAnimationDuration] count unit is Milli Seconds
      int insetAnimationDuration = 100}) {
    Dialog dialog = Dialog(
      backgroundColor: bgColor ?? Theme.of(context).cardColor,
      elevation: elevation,
      alignment: alignment,
      insetPadding: insetsPadding,
      insetAnimationCurve: curve,
      insetAnimationDuration: Duration(milliseconds: insetAnimationDuration),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      //this right here
      child: child,
    );
    showDialog(
        context: context,
        barrierDismissible: clickOutSideClose,
        builder: (BuildContext context) => dialog);
  }
}
