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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAWWgQ8hyvN0TNveYGhJyhJBeqSoEcrnJU',
    appId: '1:71036710855:web:e87b57f295f2ada38133e2',
    messagingSenderId: '71036710855',
    projectId: 'shetech-d61dd',
    authDomain: 'shetech-d61dd.firebaseapp.com',
    storageBucket: 'shetech-d61dd.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwSzM9soHeOVNwWd5aUizJmwEHmngqjdw',
    appId: '1:71036710855:android:c626b7da52b9e3188133e2',
    messagingSenderId: '71036710855',
    projectId: 'shetech-d61dd',
    storageBucket: 'shetech-d61dd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9l7q6iyOZ-zK05uSOiAUbj9XEIND1Mmg',
    appId: '1:71036710855:ios:712d1bead9f51aba8133e2',
    messagingSenderId: '71036710855',
    projectId: 'shetech-d61dd',
    storageBucket: 'shetech-d61dd.firebasestorage.app',
    androidClientId: '71036710855-t0v0tpt0mpl782mv3eit5bgjfguegh1a.apps.googleusercontent.com',
    iosClientId: '71036710855-dvtesc5n8mdlu8o4m18nvp3o5vnt7if6.apps.googleusercontent.com',
    iosBundleId: 'com.example.shetechApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWWgQ8hyvN0TNveYGhJyhJBeqSoEcrnJU',
    appId: '1:71036710855:web:996ba5d82375c6278133e2',
    messagingSenderId: '71036710855',
    projectId: 'shetech-d61dd',
    authDomain: 'shetech-d61dd.firebaseapp.com',
    storageBucket: 'shetech-d61dd.firebasestorage.app',
  );
}
