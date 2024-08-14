// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/customerlistscreen/customerlistscreen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Image.asset(
                  "assets/WhatsApp Image 2024-08-12 at 21.38.55_69ee6ac4.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "OTP Verification",
                style: Fonts.boldFont,
              ),
              SizedBox(height: 10),
              Text(
                "Enter the verification code we just sent to your number 81291041699",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Pinput(
                length: 6,
                controller: otpController,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(height: 20),
              Text(
                "59 secs",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Didn't get the OTP? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Retry",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  try {
                    final cred = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: otpController.text,
                    );
                    await FirebaseAuth.instance.signInWithCredential(cred);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerListScreen(),
                      ),
                    );
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.customBlack,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
