// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/customerlistscreen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  Widget build(BuildContext context) {
     var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add a New User",style: Fonts.boldFont,),
              SizedBox(height: 20,),
              Center(
                child: CircleAvatar(
                  child: Icon(Icons.camera_alt_outlined,size: 30,),
                  maxRadius: 60,
                  backgroundColor: const Color.fromARGB(255, 236, 227, 227),
                ),
              ),SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: Fonts.lightFont,
                  focusColor: ColorConstants.customBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                 ),
                ),SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: Fonts.lightFont,
                  focusColor: ColorConstants.customBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                 ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Center(child: Text("Cancel")),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Center(child: Text("Save",style: TextStyle(color: Colors.white),)),
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      height: size.height,
      width: size.width,
      ),
    );
  }
}