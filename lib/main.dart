import 'package:dummy/Data/AppData/app_providers.dart';
import 'package:dummy/Data/DataSource/Repository/category_repo.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.dart';
import 'package:dummy/Presentation/Widgets/Dashboard/dashboard.dart';
import 'package:dummy/Screens/category_screen.dart';
import 'package:dummy/Screens/product_detail.dart';
import 'package:dummy/cubit/category_cubit.dart';
import 'package:dummy/dynamic_links.dart';

import 'package:dummy/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(providers: appProviders, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DynamicLinks.initDynamicLink(context);
    });
    super.initState();
  }

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
              "/product_detail": (context) => const ProductDetailScreen(),
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
