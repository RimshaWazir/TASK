import 'package:dummy/Application/Services/Auth/auth_services.dart';
import 'package:dummy/Data/DataSource/Repository/Auth/login_repo.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.dart';
import 'package:dummy/Presentation/Widgets/Auth/login_cubit.dart';

import 'package:dummy/Presentation/Widgets/Dashboard/BottomNavigation/bottom_navigation.dart';
import 'package:dummy/Screens/category_screen.dart';

import 'package:dummy/dynamic_links.dart';

import 'package:dummy/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginCubit>(
      create: (BuildContext context) =>
          LoginCubit(AuthRepository(AuthService())),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     DynamicLinks.initDynamicLink(context);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Message App',
            routes: {
              "/login": (context) => const LoginScreen(),
              "/bottom_navigation": (context) => const BottomNavigationScreen(),
              "/category_screen": (context) => const CategoryListView(),
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const LoginScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
