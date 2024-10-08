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
    apiKey: 'AIzaSyAow6xmpvfVshTv8np9FTrvuiPSBwhAXBM',
    appId: '1:755114547112:web:f6baca89d5d8b843f8ef9d',
    messagingSenderId: '755114547112',
    projectId: 'lokalektinger',
    authDomain: 'lokalektinger.firebaseapp.com',
    storageBucket: 'lokalektinger.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIXKUNaUC1K-NeU22qTLvVAPXu28p49pY',
    appId: '1:755114547112:android:c7b1a52b3731706cf8ef9d',
    messagingSenderId: '755114547112',
    projectId: 'lokalektinger',
    storageBucket: 'lokalektinger.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeIGYAHyLu0f7-G2ALRn4_35Y8YUnQJt8',
    appId: '1:755114547112:ios:1aaad682225d76dbf8ef9d',
    messagingSenderId: '755114547112',
    projectId: 'lokalektinger',
    storageBucket: 'lokalektinger.appspot.com',
    iosBundleId: 'at.lokalektinger.lokalektinger',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeIGYAHyLu0f7-G2ALRn4_35Y8YUnQJt8',
    appId: '1:755114547112:ios:1aaad682225d76dbf8ef9d',
    messagingSenderId: '755114547112',
    projectId: 'lokalektinger',
    storageBucket: 'lokalektinger.appspot.com',
    iosBundleId: 'at.lokalektinger.lokalektinger',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAow6xmpvfVshTv8np9FTrvuiPSBwhAXBM',
    appId: '1:755114547112:web:517f48b66629007ff8ef9d',
    messagingSenderId: '755114547112',
    projectId: 'lokalektinger',
    authDomain: 'lokalektinger.firebaseapp.com',
    storageBucket: 'lokalektinger.appspot.com',
  );
}
