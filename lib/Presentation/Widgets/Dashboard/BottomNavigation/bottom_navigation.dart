import 'package:dummy/Presentation/Commons/bottom_appbar.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Controller/BottomNavigationNotifier/bottom_navigation_notifier.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int? initialPage;

  const BottomNavigationScreen({
    super.key,
    this.initialPage,
  });

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BottomNotifier.bottomNavigationNotifier.value = 0;
    });

    BottomNotifier.bottomPageController =
        PageController(initialPage: widget.initialPage ?? 0);
    BottomNotifier.checkExitTimes.value = 2;
    BottomNotifier.bottomNavigationNotifier.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: PageView(
              controller: BottomNotifier.bottomPageController,
              onPageChanged: (x) {
                BottomNotifier.bottomNavigationNotifier.value = x;
              },
              children: const [
                DashboardScreen(),
                DashboardScreen(),
                DashboardScreen(),
                DashboardScreen(),
                DashboardScreen(),
              ],
            ),
          ),
          bottomNavigationBar: const BottomAppbar()),
    );
  }
}
