import 'package:dummy/Data/DataSource/Repository/category_repo.dart';
import 'package:dummy/Screens/category_screen.dart';
import 'package:dummy/cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appProviders = [
  BlocProvider(
    create: (context) => CategoryCubit(CategoryRepository()),
    child: const CategoryListView(),
  ),
];