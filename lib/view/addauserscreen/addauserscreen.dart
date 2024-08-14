// ignore_for_file: sort_child_properties_last

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/customerlistscreen/customerlistscreen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  var db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          actions: [
            TextButton(
              onPressed: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Camera"),
            ),
            TextButton(
              onPressed: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Gallery"),
            ),
          ],
        );
      },
    );
  }
Future<void> _uploadImageAndSaveData() async {
  if (namecontroller.text.isEmpty || agecontroller.text.isEmpty) {
    print("Name or Age cannot be empty");
    return;
  }

  final userData = <String, dynamic>{
    "name": namecontroller.text,
    "age": agecontroller.text,
  };

  if (_image != null) {
    // Upload image to Firebase Storage
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child("customerdata/$fileName");
    final uploadTask = ref.putFile(_image!);

    try {
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Add image URL to user data
      userData["imageUrl"] = imageUrl;
    } catch (error) {
      print("Failed to upload image: $error");
      // Continue to save user data even if image upload fails
    }
  }

  try {
    // Save user data to Firestore
    await db.collection("customerdata").add(userData);
    print("User added successfully");
  } catch (error) {
    print("Failed to add user: $error");
  }
}




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              Text("Add a New User", style: Fonts.boldFont),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.camera_alt_outlined, size: 30)
                        : null,
                    maxRadius: 60,
                    backgroundColor: const Color.fromARGB(255, 236, 227, 227),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: Fonts.lightFont,
                  focusColor: ColorConstants.customBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: agecontroller,
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: Fonts.lightFont,
                  focusColor: ColorConstants.customBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        _uploadImageAndSaveData();
                        agecontroller.clear();
                        namecontroller.clear();
                        
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
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
