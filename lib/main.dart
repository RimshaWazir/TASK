import 'dart:developer';

import 'package:dummy/Model/dummy_model.dart';
import 'package:dummy/Repository/dummy_repo.dart';
import 'package:dummy/cubit/dummy_cubit.dart';
import 'package:dummy/cubit/dummy_event.dart';
import 'package:dummy/cubit/dummy_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => CategoryBloc(DummyRepository()),
          child: const CategoryListView(),
        ));
  }
}

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Categories Task'),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          log(state.toString());
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryError) {
            return const Center(child: Text('Error'));
          } else if (state is CategoryLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                var category = state.categories[index];
                return ExpansionTile(
                  title: Text(category.title!),
                  children: category.subCategories!.map((subCategory) {
                    return ExpansionTile(
                      title: Text(subCategory.title!),
                      children: subCategory.childSubCategories!
                          .map((childSubCategory) {
                        return ExpansionTile(
                          title: Text(childSubCategory.title!),
                          children: childSubCategory.deepChildSubCategory!
                              .map((deepChild) {
                            return ExpansionTile(
                              title: Text(deepChild.title!),
                              children: deepChild.products!.map((product) {
                                return ListTile(
                                  title: Text(product.productName!),
                                  subtitle: Text('Price: ${product.price}'),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
