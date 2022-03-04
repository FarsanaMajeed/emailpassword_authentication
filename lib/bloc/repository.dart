import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  registerWithEmailPassword(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  loginWithEmailPassword(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }
}
