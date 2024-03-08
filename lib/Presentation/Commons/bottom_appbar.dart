import '../../Data/DataSource/Resources/imports.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      surfaceTintColor: Colors.white,
      height: 70,
      elevation: 9,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: ValueListenableBuilder(
        builder: (context, state, _) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Home
              BottomIcon(
                ontap: () {
                  if (state != 0) {
                    BottomNotifier.bottomPageController!.jumpToPage(0);
                    BottomNotifier.bottomNavigationNotifier.value = 0;
                  }
                },
                text: AppStrings.home,
                image: Assets.home,
                state: 0,
              ),
              // Projects
              BottomIcon(
                ontap: () {
                  if (state != 1) {
                    BottomNotifier.bottomPageController!.jumpToPage(1);
                    BottomNotifier.bottomNavigationNotifier.value = 1;
                  }
                },
                text: AppStrings.projects,
                image: Assets.project,
                state: 1,
              ),

              //Calender
              BottomIcon(
                ontap: () {
                  if (state != 2) {
                    BottomNotifier.bottomPageController!.jumpToPage(2);
                    BottomNotifier.bottomNavigationNotifier.value = 2;
                  }
                },
                text: AppStrings.calender,
                image: Assets.calendar,
                state: 2,
              ),
              //Messages
              BottomIcon(
                ontap: () {
                  if (state != 3) {
                    BottomNotifier.bottomPageController!.jumpToPage(3);
                    BottomNotifier.bottomNavigationNotifier.value = 3;
                  }
                },
                text: AppStrings.messages,
                image: Assets.message,
                state: 3,
              ),
              //Task
              BottomIcon(
                ontap: () {
                  if (state != 4) {
                    BottomNotifier.bottomPageController!.jumpToPage(4);
                    BottomNotifier.bottomNavigationNotifier.value = 4;
                  }
                },
                text: AppStrings.task,
                image: Assets.task,
                state: 4,
              ),
            ],
          );
        },
        valueListenable: BottomNotifier.bottomNavigationNotifier,
      ),
    );
  }
}
