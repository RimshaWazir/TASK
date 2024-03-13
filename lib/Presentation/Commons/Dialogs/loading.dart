import 'package:dummy/Data/DataSource/Resources/imports.dart';

class Loading {
  static Future<void> showLoading(BuildContext context,
      {Widget? child, bool? barrierDismissible}) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return loadingWidget(child: child);
      },
    );
  }

  static Widget loadingWidget({Widget? child}) {
    return Dialog(
        insetPadding: const EdgeInsets.all(15).r,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10).r,
        ),
        child: Center(child: child ?? const CircularProgressIndicator()));
  }
}
