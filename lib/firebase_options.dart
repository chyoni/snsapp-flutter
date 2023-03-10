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
    apiKey: 'AIzaSyA9vQ1LuZaR8AbIbyo-8w88Q--P6ralpkM',
    appId: '1:70460671611:web:92fe6901da0ff2b937c4de',
    messagingSenderId: '70460671611',
    projectId: 'chiwon99881tiktok',
    authDomain: 'chiwon99881tiktok.firebaseapp.com',
    storageBucket: 'chiwon99881tiktok.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANhZl0D81PmPNTOOcak9xBu7Ix4ZO9PMQ',
    appId: '1:70460671611:android:02581e5fb1cbfe7e37c4de',
    messagingSenderId: '70460671611',
    projectId: 'chiwon99881tiktok',
    storageBucket: 'chiwon99881tiktok.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_KIe4o8CgKTPDUJlY-SY0YQCvWezdmn0',
    appId: '1:70460671611:ios:48a3e4dae5ee0eb837c4de',
    messagingSenderId: '70460671611',
    projectId: 'chiwon99881tiktok',
    storageBucket: 'chiwon99881tiktok.appspot.com',
    iosClientId: '70460671611-br42tiidv17nmip2vdgg533o93fiajip.apps.googleusercontent.com',
    iosBundleId: 'chyonee.clone.tiktok',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_KIe4o8CgKTPDUJlY-SY0YQCvWezdmn0',
    appId: '1:70460671611:ios:4afedbdb70a75a9d37c4de',
    messagingSenderId: '70460671611',
    projectId: 'chiwon99881tiktok',
    storageBucket: 'chiwon99881tiktok.appspot.com',
    iosClientId: '70460671611-boeqtkk788hrn4hgoafpibuf4nrkbrav.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktok',
  );
}
