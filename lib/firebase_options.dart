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
        return macos;
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
    apiKey: 'AIzaSyAzu1kSeLggLm4gjvwh1CAsCeXTzF_oOpU',
    appId: '1:1009487601323:web:729d7112f9c78c93e4e1ee',
    messagingSenderId: '1009487601323',
    projectId: 'amongusgdsc',
    authDomain: 'amongusgdsc.firebaseapp.com',
    storageBucket: 'amongusgdsc.appspot.com',
    measurementId: 'G-N8NYKD3KSB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEltUwA4_OujoKlajRjt30v8ZUnxpsmKA',
    appId: '1:1009487601323:android:1fe67d7a3bda2d35e4e1ee',
    messagingSenderId: '1009487601323',
    projectId: 'amongusgdsc',
    storageBucket: 'amongusgdsc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCDDmOrL01zZCBUehQH1ABy62lAAjym-g',
    appId: '1:1009487601323:ios:9b2ac2ad6ff55d9fe4e1ee',
    messagingSenderId: '1009487601323',
    projectId: 'amongusgdsc',
    storageBucket: 'amongusgdsc.appspot.com',
    iosBundleId: 'com.example.amongUs2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCDDmOrL01zZCBUehQH1ABy62lAAjym-g',
    appId: '1:1009487601323:ios:efeb8d438832408ae4e1ee',
    messagingSenderId: '1009487601323',
    projectId: 'amongusgdsc',
    storageBucket: 'amongusgdsc.appspot.com',
    iosBundleId: 'com.example.amongUs2.RunnerTests',
  );
}