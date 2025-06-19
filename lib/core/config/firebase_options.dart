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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Configuration par défaut pour le développement
  // En production, remplacez par vos vraies clés Firebase
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    appId: '1:123456789012:web:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'my-flutter-cursor-app',
    authDomain: 'my-flutter-cursor-app.firebaseapp.com',
    storageBucket: 'my-flutter-cursor-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArK5uxxrfEnnEaYM1BMmpJpV-xSt2Ef4c',
    appId: '1:755257917664:android:41cb29d3c46bb8a9b75085',
    messagingSenderId: '755257917664',
    projectId: 'my-flutter-cursor-app',
    storageBucket: 'my-flutter-cursor-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    appId: '1:123456789012:ios:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'my-flutter-cursor-app',
    storageBucket: 'my-flutter-cursor-app.appspot.com',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    appId: '1:123456789012:ios:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'my-flutter-cursor-app',
    storageBucket: 'my-flutter-cursor-app.appspot.com',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    appId: '1:123456789012:windows:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'my-flutter-cursor-app',
    storageBucket: 'my-flutter-cursor-app.appspot.com',
  );
}
