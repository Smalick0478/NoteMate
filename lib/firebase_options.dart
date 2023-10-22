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
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      // case TargetPlatform.linux:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for linux - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyD9kDC3gaFblLccLLJZD4Va2RrvYqAhofc",
      authDomain: "notemate-c31c1.firebaseapp.com",
      projectId: "notemate-c31c1",
      storageBucket: "notemate-c31c1.appspot.com",
      messagingSenderId: "1099211678131",
      appId: "1:1099211678131:web:dd7c40735c1c1cd93babc6",
      measurementId: "G-CY433B4QBY");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyD9kDC3gaFblLccLLJZD4Va2RrvYqAhofc",
    appId: "1:1099211678131:web:dd7c40735c1c1cd93babc6",
    messagingSenderId: "1099211678131",
    projectId: "notemate-c31c1",
    storageBucket: "notemate-c31c1.appspot.com",
  );

  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyCtpmB8ucWFal1ncO-jpMUXpah5D0K9XLQ',
  //   appId: '1:751499857535:ios:53223607f77bb5514cf94a',
  //   messagingSenderId: '751499857535',
  //   projectId: 'tts-tasking-for-smuct',
  //   storageBucket: 'tts-tasking-for-smuct.appspot.com',
  //   iosClientId: '751499857535-1404q69t5jok4rcnl7u51sno4ntffqbd.apps.googleusercontent.com',
  //   iosBundleId: 'com.example.tasking',
  // );

  // static const FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyCtpmB8ucWFal1ncO-jpMUXpah5D0K9XLQ',
  //   appId: '1:751499857535:ios:53223607f77bb5514cf94a',
  //   messagingSenderId: '751499857535',
  //   projectId: 'tts-tasking-for-smuct',
  //   storageBucket: 'tts-tasking-for-smuct.appspot.com',
  //   iosClientId: '751499857535-1404q69t5jok4rcnl7u51sno4ntffqbd.apps.googleusercontent.com',
  //   iosBundleId: 'com.example.tasking',
  // );
}
