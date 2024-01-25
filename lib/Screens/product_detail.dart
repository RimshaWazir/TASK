import 'package:dummy/Domain/Model/category_model.dart';
import 'package:dummy/dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatelessWidget {
  final String? id;

  const ProductDetailScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Center(
        child: Text('Product : $id'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DynamicLinks.createDynamicLink(CategoryModel(id: id)).then((value) {
            Share.share(value);
          });
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}
