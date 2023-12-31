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
    apiKey: 'AIzaSyDyMi0QJx9833TwpcAlpF4SU90HyG8XW_I',
    appId: '1:1014832088894:web:8572e42e225df48475ce6f',
    messagingSenderId: '1014832088894',
    projectId: 'chat-11942',
    authDomain: 'chat-11942.firebaseapp.com',
    storageBucket: 'chat-11942.appspot.com',
    measurementId: 'G-MV781LFN6M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDce9jBxSLSRg0Kyl9qxZYHoh4XpfTb1w0',
    appId: '1:1014832088894:android:19d212b9598ead5475ce6f',
    messagingSenderId: '1014832088894',
    projectId: 'chat-11942',
    storageBucket: 'chat-11942.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5l3I75hCGdA8fKCad9XVL6Bh9ETXtTkk',
    appId: '1:1014832088894:ios:2444d2148e9bbcba75ce6f',
    messagingSenderId: '1014832088894',
    projectId: 'chat-11942',
    storageBucket: 'chat-11942.appspot.com',
    iosClientId: '1014832088894-7i2hh91f3ck7t0k0qel6606h2m1dsisj.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5l3I75hCGdA8fKCad9XVL6Bh9ETXtTkk',
    appId: '1:1014832088894:ios:967f0413c81cfcf675ce6f',
    messagingSenderId: '1014832088894',
    projectId: 'chat-11942',
    storageBucket: 'chat-11942.appspot.com',
    iosClientId: '1014832088894-8tstaq2cljodlubotv3hgben27h4brmp.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat.RunnerTests',
  );
}
