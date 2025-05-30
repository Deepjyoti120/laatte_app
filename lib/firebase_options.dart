// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBN5mNy1ZIeE05upM8ur6hCEPKeqCTsN5U',
    appId: '1:479035682627:web:b7f1aaff5d68e96917c9f6',
    messagingSenderId: '479035682627',
    projectId: 'relate-5a0f9',
    authDomain: 'relate-5a0f9.firebaseapp.com',
    storageBucket: 'relate-5a0f9.firebasestorage.app',
    measurementId: 'G-5X8C7N0FBV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-1MELhsXKM6xFlYpQk7ghmd6BiGkkVlg',
    appId: '1:479035682627:android:444a439c1094d93717c9f6',
    messagingSenderId: '479035682627',
    projectId: 'relate-5a0f9',
    storageBucket: 'relate-5a0f9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDC_jg3gDOOMIsg0qFlCqOY6Ovn_q0uVx4',
    appId: '1:479035682627:ios:8588d9cc835c639617c9f6',
    messagingSenderId: '479035682627',
    projectId: 'relate-5a0f9',
    storageBucket: 'relate-5a0f9.firebasestorage.app',
    androidClientId: '479035682627-8e02mh17j7gdqaer046es9qbm2atadkm.apps.googleusercontent.com',
    iosClientId: '479035682627-7f5bk9vl99gmrrdentkqe1pebo94nld1.apps.googleusercontent.com',
    iosBundleId: 'com.relate.laatte',
  );

}