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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Configuration par défaut pour le développement
  // En production, remplacez par vos vraies clés Firebase
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: 'demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'demo-project',
    authDomain: 'demo-project.firebaseapp.com',
    storageBucket: 'demo-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: 'demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'demo-project',
    storageBucket: 'demo-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: 'demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'demo-project',
    storageBucket: 'demo-project.appspot.com',
    iosClientId: 'demo-ios-client-id',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: 'demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'demo-project',
    storageBucket: 'demo-project.appspot.com',
    iosClientId: 'demo-ios-client-id',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: 'demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'demo-project',
    storageBucket: 'demo-project.appspot.com',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: 'demo-app-id',
    messagingSenderId: '123456789',
    projectId: 'demo-project',
    storageBucket: 'demo-project.appspot.com',
  );
} 