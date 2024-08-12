// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/verificationscreen.dart';

class PhoneNumberVerificationScreen extends StatefulWidget {
  const PhoneNumberVerificationScreen({super.key});

  @override
  State<PhoneNumberVerificationScreen> createState() => _PhoneNumberVerificationScreenState();
}

class _PhoneNumberVerificationScreenState extends State<PhoneNumberVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset("assets/WhatsApp Image 2024-08-12 at 20.44.38_32a39082.jpg",
                  fit: BoxFit.fill,),
                ),SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text("Enter Phone Number",style: Fonts.boldFont,),
                    SizedBox(height: 30,),
                TextFormField(
                 decoration: InputDecoration(
                  hintText: "Enter Phone Number*",
                  hintStyle: Fonts.lightFont,
                  focusColor: ColorConstants.customBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                 ),
                ),SizedBox(height: 30,),
                RichText(
                          text: TextSpan(
                            text: 'By Continuing, I agree to TotalX\'s ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                text: 'Terms and conditions & Privacy Policy',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),)
                ],
                              ),
                            ),SizedBox(height: 30,),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen()));
                              },
                              child: Container(
                                child: Center(
                                  child: Text("Get OTP",style: TextStyle(
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
                              ),
                            )
                          ],
                        ),
                 ] ),
                ),
              ),
        )  ) );
  }
}