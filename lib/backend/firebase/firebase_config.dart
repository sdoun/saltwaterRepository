import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCrp5NNNopOmshwmb1UuINa8F0hxMh4Tfo",
            authDomain: "salt-water-beta-ver1-4dujup.firebaseapp.com",
            projectId: "salt-water-beta-ver1-4dujup",
            storageBucket: "salt-water-beta-ver1-4dujup.appspot.com",
            messagingSenderId: "333207855339",
            appId: "1:333207855339:web:ba15b51a4f350af4aedeae"));
  } else {
    await Firebase.initializeApp();
  }
}
