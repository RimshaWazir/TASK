import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBi1rpQ_w1mmbY17ktLSokJzl9D-6WpC84',
    appId: '1:695365792023:web:410754d8f9d76ffe03c752',
    messagingSenderId: '695365792023',
    projectId: 'deep-linking-b60f9',
    authDomain: 'deep-linking-b60f9.firebaseapp.com',
    storageBucket: 'deep-linking-b60f9.appspot.com',
    measurementId: 'G-YBBK9DETZ0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBT8vOmML_acFoa34vSnVBS1QzDlOu2USs',
    appId: '1:695365792023:android:0909a18b91c1fa5103c752',
    messagingSenderId: '695365792023',
    projectId: 'deep-linking-b60f9',
    storageBucket: 'deep-linking-b60f9.appspot.com',
  );
}
