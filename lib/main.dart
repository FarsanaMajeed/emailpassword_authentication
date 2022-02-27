import 'package:flutter/material.dart';
import 'package:loginform_new/app.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  await Firebase.initializeApp(); // this method is used to initialize the firebase
  runApp(const MyApp());
}


