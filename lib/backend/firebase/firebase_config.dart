import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAIPTnX4ftlw9ce0FfXU18KDSVVtVt0GeM",
            authDomain: "myglooco-19xlbg.firebaseapp.com",
            projectId: "myglooco-19xlbg",
            storageBucket: "myglooco-19xlbg.appspot.com",
            messagingSenderId: "561890260849",
            appId: "1:561890260849:web:a2e42b7cedcca220f028d0"));
  } else {
    await Firebase.initializeApp();
  }
}
