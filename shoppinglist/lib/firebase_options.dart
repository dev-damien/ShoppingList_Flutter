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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGbA5McOd_gLvkwbCAbAFlUfjUK5pNvVM',
    appId: '1:1040426825708:android:d4f9cab4ce84158001f2c9',
    messagingSenderId: '1040426825708',
    projectId: 'minimalist-8b40c',
    storageBucket: 'minimalist-8b40c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDQZLQzXB6t2kU-RLkdJhM1JLeMNsduHE',
    appId: '1:1040426825708:ios:9556762c524da7d101f2c9',
    messagingSenderId: '1040426825708',
    projectId: 'minimalist-8b40c',
    storageBucket: 'minimalist-8b40c.appspot.com',
    androidClientId: '1040426825708-0hfm11fbno7f2k6ai4bakm6uvep76i9s.apps.googleusercontent.com',
    iosClientId: '1040426825708-igolvuen04jrjijuapl8pf5uov2i8dmn.apps.googleusercontent.com',
    iosBundleId: 'com.example.shoppinglist',
  );
}
