import 'dart:developer';
import 'package:dummy/Application/Services/ApiServices/Apis.dart';
import 'package:dummy/Data/DataSource/Repository/Auth/auth_repo.dart';
import 'package:dummy/Data/DataSource/Resources/strings.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/login.dart';
import 'package:dummy/Presentation/Widgets/Auth/Login/Controllers/login_cubit.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/Controller/dashboard_cubit.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/dashboard.dart';
import 'package:dummy/Presentation/Widgets/Onboarding/splash_screen.dart';
import 'package:dummy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    await initializeFirebase();

    runApp(MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(AuthRepository(APIs())),
        ),
        BlocProvider<DashboardCubit>(
          create: (BuildContext context) => DashboardCubit(auth),
        ),
      ],
      child: const MyApp(),
    ));
  });
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  log('\nNotification Channel Result: $result');
}

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
            routes: {
              "/bottom_navigation": (context) => const BottomNavigationScreen(),
              "/dashboard": (context) => const DashboardScreen(),
              "/login": (context) => LoginScreen(),
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
