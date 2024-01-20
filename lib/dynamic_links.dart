// import 'dart:developer';

// import 'package:dummy/Model/dummy_model.dart';
// import 'package:dummy/Screens/product_detail.dart';
// import 'package:dummy/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';

// class DynamicLinks {
//   ///DYNAMIC LINKS CREATION
//   static Future<String> createDynamicLink(DummyModel item) async {
//     DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: "https://itecexperts.page.link",
//       link: Uri.parse('product_detail/${item.id}'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.example.dummy',
//         minimumVersion: 1,
//       ),
//     );

//     final ShortDynamicLink shortLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//     Uri url = shortLink.shortUrl;
//     log(url.toString());

//     return url.toString();
//   }

//   ///DYNAMIC LINKS INITIALIZATION
//   static Future<void> initDynamicLink(BuildContext context) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//     final PendingDynamicLinkData? initialLink =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     log(initialLink.toString());

//     if (initialLink != null) {
//       // ignore: use_build_context_synchronously
//       log(initialLink.link.toString());
//       return linkDynamicRouting(context, uri: initialLink.link);
//     } else {
//       log("link not set");
//     }
//     FirebaseDynamicLinks.instance.onLink.listen(
//       (pendingDynamicLinkData) {
//         linkDynamicRouting(context, uri: pendingDynamicLinkData.link);
//       },
//     );
//   }

//   ///DYNAMIC LINKS ROUTING
//   static Future<void> linkDynamicRouting(BuildContext context,
//       {required Uri uri}) async {
//     String? screen = uri.queryParameters.values.first;

//     if (screen == 'category_screen') {
//       Navigator.of(context).pushReplacementNamed('/category_screen');
//     } else if (screen == 'product_detail') {
//       String? path = uri.queryParameters.values.first;
//       print(uri.queryParameters.values.first);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductDetailScreen(
//             path: path,
//           ),
//         ),
//       );
//     }
//   }
// }

import 'dart:developer';

import 'package:dummy/Screens/product_detail.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinks {
  void initDynamicsLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLink) {
        final Uri? deepLink = dynamicLink?.link;

        if (deepLink != null) {
          linkDynamicRouting(context, deepLink: deepLink);
        }
      },
    );
  }

  static Future<void> linkDynamicRouting(BuildContext context,
      {required Uri deepLink}) async {
    String? screen = deepLink.queryParameters.values.first;

    log(deepLink.toString());
    if (screen == 'category_screen') {
      Navigator.of(context).pushReplacementNamed('/category_screen');
    } else if (screen == 'product_detail') {
      String? id = deepLink.queryParameters['id'];
      if (id != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                id: id,
                path: deepLink.toString(),
              ),
            ));
      } else {
        print('Product ID is null');
      }
    }
  }
}
