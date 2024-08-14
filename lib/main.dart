// ignore_for_file: prefer_const_constructors

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:totalx_interview_project/view/phonenumberscreen.dart';

Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBNgBEtWjCAveEEqb110HiXnTycM0_w5w4"
    , appId: "1:816719558929:android:834027e00c2abd754334b0"
    , messagingSenderId:""
     , projectId:"interviewtasktotalx",
     storageBucket: "interviewtasktotalx.appspot.com",
      )
   );
   
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneNumberVerificationScreen(),
    );
  }
}