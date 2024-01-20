import 'package:dummy/Model/dummy_model.dart';
import 'package:dummy/Screens/product_detail.dart';
import 'package:dummy/cubit/dummy_cubit.dart';
import 'package:dummy/cubit/dummy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  void initState() {
    context.read<DummyCubit>().fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Categories Task'),
      ),
      body: BlocConsumer<DummyCubit, DummyState>(listener: (context, state) {
        if (state is CategoryLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: CircularProgressIndicator(),
              );
            },
          );
        }

        if (state is CategoryError) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred'),
              );
            },
          );
        } else {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      }, builder: (context, state) {
        return BlocSelector<DummyCubit, DummyState, List<DummyModel>>(
          selector: (state) {
            if (state is CategoryLoaded) {
              return state.categories;
            }
            return [];
          },
          builder: (context, categories) {
            return SizedBox(
              height: 700,
              width: 300,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(
                                            id: product.productId!,
                                          ),
                                        ),
                                      );
                                    },
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
              ),
            );
          },
        );
      }),
    );
  }
}
