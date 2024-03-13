import 'package:dummy/Presentation/Widgets/Auth/SignUp/signup.dart';

import '../DataSource/Resources/imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            title: AppStrings.messageApp,
            theme: ThemeData(
                primaryColor: Colors.blue,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.shifting)),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
