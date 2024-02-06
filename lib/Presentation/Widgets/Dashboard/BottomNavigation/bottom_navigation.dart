import 'package:dummy/Data/DataSource/Resources/text_styles.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/dashboard.dart';
import 'package:dummy/Presentation/Widgets/Messages/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
    return Scaffold(
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
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.white,
          height: 70,
          elevation: 9,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: ValueListenableBuilder(
            builder: (context, state, ss) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (state != 0) {
                        BottomNotifier.bottomPageController!.jumpToPage(0);
                        BottomNotifier.bottomNavigationNotifier.value = 0;
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/home.svg",
                          color: state == 0 ? Colors.blue : Colors.black,
                        ),
                        Text("Home",
                            style: TextStyles.selectedAndUnseletedStyle(
                              context,
                              color: state == 0 ? Colors.blue : Colors.black,
                            )),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      if (state != 1) {
                        BottomNotifier.bottomPageController!.jumpToPage(1);
                        BottomNotifier.bottomNavigationNotifier.value = 1;
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/project.svg",
                          color: state == 1 ? Colors.blue : Colors.black,
                        ),
                        Text("Projects",
                            style: TextStyles.selectedAndUnseletedStyle(
                              context,
                              color: state == 1 ? Colors.blue : Colors.black,
                            )),
                      ],
                    ),
                  ),

                  ///Chat
                  GestureDetector(
                    onTap: () {
                      if (state != 2) {
                        BottomNotifier.bottomPageController!.jumpToPage(2);
                        BottomNotifier.bottomNavigationNotifier.value = 2;
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/calendar.svg",
                          color: state == 2 ? Colors.blue : Colors.black,
                        ),
                        Text("Calender",
                            style: TextStyles.selectedAndUnseletedStyle(
                              context,
                              color: state == 2 ? Colors.blue : Colors.black,
                            )),
                      ],
                    ),
                  ),

                  ///Profile
                  GestureDetector(
                    onTap: () {
                      if (state != 3) {
                        BottomNotifier.bottomPageController!.jumpToPage(3);
                        BottomNotifier.bottomNavigationNotifier.value = 3;
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/message.svg",
                          color: state == 3 ? Colors.blue : Colors.black,
                        ),
                        Text("Messages",
                            style: TextStyles.selectedAndUnseletedStyle(
                              context,
                              color: state == 3 ? Colors.blue : Colors.black,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state != 4) {
                        BottomNotifier.bottomPageController!.jumpToPage(4);
                        BottomNotifier.bottomNavigationNotifier.value = 4;
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/task.svg",
                          color: state == 4 ? Colors.blue : Colors.black,
                        ),
                        Text("Tasks",
                            style: TextStyles.selectedAndUnseletedStyle(
                              context,
                              color: state == 4 ? Colors.blue : Colors.black,
                            )),
                      ],
                    ),
                  )
                ],
              );
            },
            valueListenable: BottomNotifier.bottomNavigationNotifier,
          ),
        ));
  }
}
