// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/customerlistscreen.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
             Center(
               child: Pinput(
                   onCompleted: (pin) => print(pin),
                 ),
             ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "59 secs",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Didn\'t get the OTP? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Retry',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),SizedBox(height: 20,),
               InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerListScreen()));
                              },
                              child: Container(
                                child: Center(
                                  child: Text("Verify",style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                  ),),
                                ),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConstants.customBlack,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                              ),)
              ],
             )
            ],
          ),
        ),
      ),
    );
  }
}



