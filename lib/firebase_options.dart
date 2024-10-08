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
    apiKey: 'AIzaSyAwL8Kx9usG0MaGBCzSGa_OLxvqcX80TGA',
    appId: '1:888379392327:web:6a52e674739ac25b440c62',
    messagingSenderId: '888379392327',
    projectId: 'sokoni-3f47e',
    authDomain: 'sokoni-3f47e.firebaseapp.com',
    storageBucket: 'sokoni-3f47e.appspot.com',
    measurementId: 'G-0VWJ0N12CR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9qIlj6E1bhfMAbXvR1sp6yrgHeGTJyVs',
    appId: '1:888379392327:android:6f43d3dc029326ca440c62',
    messagingSenderId: '888379392327',
    projectId: 'sokoni-3f47e',
    storageBucket: 'sokoni-3f47e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmpFcXLeo8prh9IK5l7_TYmFUDrkGsSbU',
    appId: '1:888379392327:ios:953d9be7767377f6440c62',
    messagingSenderId: '888379392327',
    projectId: 'sokoni-3f47e',
    storageBucket: 'sokoni-3f47e.appspot.com',
    androidClientId: '888379392327-6h3r9gl8mk2tauh3f5g2vqsprdkednro.apps.googleusercontent.com',
    iosClientId: '888379392327-ieg2177qa76a0732o3pehfi3fel4hopm.apps.googleusercontent.com',
    iosBundleId: 'com.example.portugalgo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmpFcXLeo8prh9IK5l7_TYmFUDrkGsSbU',
    appId: '1:888379392327:ios:953d9be7767377f6440c62',
    messagingSenderId: '888379392327',
    projectId: 'sokoni-3f47e',
    storageBucket: 'sokoni-3f47e.appspot.com',
    androidClientId: '888379392327-6h3r9gl8mk2tauh3f5g2vqsprdkednro.apps.googleusercontent.com',
    iosClientId: '888379392327-ieg2177qa76a0732o3pehfi3fel4hopm.apps.googleusercontent.com',
    iosBundleId: 'com.example.portugalgo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAwL8Kx9usG0MaGBCzSGa_OLxvqcX80TGA',
    appId: '1:888379392327:web:4111792f4ab91337440c62',
    messagingSenderId: '888379392327',
    projectId: 'sokoni-3f47e',
    authDomain: 'sokoni-3f47e.firebaseapp.com',
    storageBucket: 'sokoni-3f47e.appspot.com',
    measurementId: 'G-THY5FP4NN1',
  );
}
