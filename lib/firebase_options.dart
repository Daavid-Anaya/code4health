import 'package:code4health/core/constants/env.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: Env.apiKeyAndroid,
    appId: '1:457972502709:android:396e6f0e2f7a37a29e6efc',
    messagingSenderId: '457972502709',
    projectId: 'code4health-891a4',
    storageBucket: 'code4health-891a4.firebasestorage.app',
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: Env.apiKeyIOS,
    appId: '1:457972502709:ios:fc6be2799be87af39e6efc',
    messagingSenderId: '457972502709',
    projectId: 'code4health-891a4',
    storageBucket: 'code4health-891a4.firebasestorage.app',
    iosBundleId: 'com.david.code4health',
  );

}