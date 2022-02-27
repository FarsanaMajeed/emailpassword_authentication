import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{
  registerWithEmailPassword(String email,String password) async{
   UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   return userCredential;
  }
  loginWithEmailPassword(String email,String password)async{
    UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   //there is no a valid user there nothing return if a user is available the data return in the form of usercredential
    return userCredential;


  }
}