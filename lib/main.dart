import 'dart:ffi';

import 'package:dummy/Repository/dummy_repo.dart';
import 'package:dummy/Screens/category_screen.dart';
import 'package:dummy/Screens/product_detail.dart';
import 'package:dummy/cubit/dummy_cubit.dart';
import 'package:dummy/dynamic_links.dart';

import 'package:dummy/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
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
    return MaterialApp(
        title: 'Task',
        routes: {
          "/product_detail": (context) => ProductDetailScreen(),
          "/category_screen": (context) => const CategoryListView(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => DummyCubit(DummyRepository()),
          child: const CategoryListView(),
        ));
  }
}
