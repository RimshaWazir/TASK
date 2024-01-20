import 'dart:developer';

import 'package:dummy/Model/dummy_model.dart';
import 'package:dummy/Screens/product_detail.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinks {
  ///DYNAMIC LINKS CREATION
  static Future<String> createDynamicLink(DummyModel item) async {
    final parameters = DynamicLinkParameters(
      uriPrefix: "https://itecexpert.page.link",
      link: Uri.parse(
          'https://itecexpert.page.link/product_detail?id=${item.id}'),
      androidParameters: const AndroidParameters(
          packageName: 'com.example.dummy', minimumVersion: 1),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(parameters);
    Uri url = dynamicLink;
    print('Dynamic Link created: $url');
    return url.toString();
  }

  ///DYNAMIC LINKS INITIALIZATION
  static Future<void> initDynamicLink(BuildContext context) async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    print("start   ${initialLink.toString()}");
    if (initialLink != null) {
      // ignore: use_build_context_synchronously

      log(initialLink.toString());
      linkDynamicRouting(context, uri: initialLink.link);
      return;
    }
    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        print(pendingDynamicLinkData.link.toString());
        linkDynamicRouting(context, uri: pendingDynamicLinkData.link);
      },
    );
  }

  static Future<void> linkDynamicRouting(BuildContext context,
      {required Uri uri}) async {
    String? screen = uri.queryParameters.values.first;

    if (screen == 'category_screen') {
      Navigator.of(context).pushReplacementNamed('/category_screen');
    } else if (screen == 'product_detail') {
      String? productId = uri.queryParameters.values.first;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            id: productId,
          ),
        ),
      );
    }
  }
}
