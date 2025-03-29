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
    apiKey: 'AIzaSyCsZSoE-_PmltNzZq1G8-BxtTL9MYfy_9w',
    appId: '1:363779277826:web:4dd2bde0adf6cbea74d31b',
    messagingSenderId: '363779277826',
    projectId: 'quizz-64122',
    authDomain: 'quizz-64122.firebaseapp.com',
    storageBucket: 'quizz-64122.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8l3lNwJ1BEs7VElDllCsMnFyBfJvEM4o',
    appId: '1:363779277826:android:95c96b3404076dbb74d31b',
    messagingSenderId: '363779277826',
    projectId: 'quizz-64122',
    storageBucket: 'quizz-64122.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvTK7PxDa_jMoAqQda4XPpHwn1-wr0h0A',
    appId: '1:363779277826:ios:be6972fa93968d2d74d31b',
    messagingSenderId: '363779277826',
    projectId: 'quizz-64122',
    storageBucket: 'quizz-64122.firebasestorage.app',
    iosBundleId: 'com.example.quizz',
  );
}
