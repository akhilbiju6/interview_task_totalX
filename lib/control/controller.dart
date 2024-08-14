import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';



class HomeScreenController with ChangeNotifier {
    var newimageurl;
 Future<void>getimageurl() async {
      final storageRef = FirebaseStorage.instance.ref();
      var uniquename=0;
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imageUrl =
    await storageRef.child("customerdata").getDownloadURL();
    newimageurl=imageUrl;
     print(imageUrl);
     uniquename++;
     notifyListeners();
    }


}