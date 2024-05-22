// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyD0ymtUqGBpfvh1QSIE0OjWdhoh-O4g5a0',
    appId: '1:466904755184:web:c4d752bb0ce9acc7bc8b35',
    messagingSenderId: '466904755184',
    projectId: 'fraudsense-f6aee',
    authDomain: 'fraudsense-f6aee.firebaseapp.com',
    storageBucket: 'fraudsense-f6aee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDD2aOiUNTWCBnjpkutLojGW667Zpu9GOo',
    appId: '1:466904755184:android:8b516921a091c0acbc8b35',
    messagingSenderId: '466904755184',
    projectId: 'fraudsense-f6aee',
    storageBucket: 'fraudsense-f6aee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCauD1s1_QnBbEul0X1KcqWosgVFCqOZC0',
    appId: '1:466904755184:ios:b2c5ce43ec33b151bc8b35',
    messagingSenderId: '466904755184',
    projectId: 'fraudsense-f6aee',
    storageBucket: 'fraudsense-f6aee.appspot.com',
    iosBundleId: 'com.example.fraudsense',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCauD1s1_QnBbEul0X1KcqWosgVFCqOZC0',
    appId: '1:466904755184:ios:b2c5ce43ec33b151bc8b35',
    messagingSenderId: '466904755184',
    projectId: 'fraudsense-f6aee',
    storageBucket: 'fraudsense-f6aee.appspot.com',
    iosBundleId: 'com.example.fraudsense',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0ymtUqGBpfvh1QSIE0OjWdhoh-O4g5a0',
    appId: '1:466904755184:web:1dc4d94e5cd661d6bc8b35',
    messagingSenderId: '466904755184',
    projectId: 'fraudsense-f6aee',
    authDomain: 'fraudsense-f6aee.firebaseapp.com',
    storageBucket: 'fraudsense-f6aee.appspot.com',
  );
}
