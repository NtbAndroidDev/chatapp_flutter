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
    apiKey: 'AIzaSyBGN-x3bOUG2ymsEBRb_kVZB023hTdkFa0',
    appId: '1:1080598752488:web:16079386b74a75be962d5d',
    messagingSenderId: '1080598752488',
    projectId: 'chat-app-flutter-ba1e8',
    authDomain: 'chat-app-flutter-ba1e8.firebaseapp.com',
    storageBucket: 'chat-app-flutter-ba1e8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD639XTgsrLnEG0U4W7ITBcJ2eb_P7klG4',
    appId: '1:1080598752488:android:0edf5c3c41df4306962d5d',
    messagingSenderId: '1080598752488',
    projectId: 'chat-app-flutter-ba1e8',
    storageBucket: 'chat-app-flutter-ba1e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGJiM9zMCo2i7Zuo-dpxv4YfP9nyLvbjI',
    appId: '1:1080598752488:ios:fb6b755b6e4c7cc7962d5d',
    messagingSenderId: '1080598752488',
    projectId: 'chat-app-flutter-ba1e8',
    storageBucket: 'chat-app-flutter-ba1e8.appspot.com',
    iosClientId: '1080598752488-pm2a51knk49d80k7b0l99n7icu3kgf8p.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGJiM9zMCo2i7Zuo-dpxv4YfP9nyLvbjI',
    appId: '1:1080598752488:ios:e1ad99b80467ee75962d5d',
    messagingSenderId: '1080598752488',
    projectId: 'chat-app-flutter-ba1e8',
    storageBucket: 'chat-app-flutter-ba1e8.appspot.com',
    iosClientId: '1080598752488-h3ombhh47kre2pk91apj6p5ti4314luo.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp.RunnerTests',
  );
}