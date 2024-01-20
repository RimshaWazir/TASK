import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatelessWidget {
  String? path;
  String? id;

  ProductDetailScreen({
    Key? key,
    this.path,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(path.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Center(
        child: Text('Product : $id'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (id != null) {
            Share.share('$id');
          } else {
            print("null path");
          }
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}
