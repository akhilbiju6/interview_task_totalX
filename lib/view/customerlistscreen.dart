// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/addauserscreen.dart';







class CityService {
  static List cities = [
    (name: "New York", country: "USA"),
    (name: "Los Angeles", country: "USA"),
    (name: "Chicago", country: "USA"),
   (name: "Houston", country: "USA"),
    (name: "Phoenix", country: "USA"),
  (name: "Philadelphia", country: "USA"),
    (name: "San Antonio", country: "USA"),
  (name: "San Diego", country: "USA"),
    (name: "Dallas", country: "USA"),
    (name: "San Jose", country: "USA"),
    // Add more cities as needed
  ];
  
  static find(String search) {}}

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}
    




    
class _CustomerListScreenState extends State<CustomerListScreen> {
   var db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection("customerdata").snapshots();






      
  @override
  Widget build(BuildContext context) {
     var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
         shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
  ),
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserScreen(),));
      },),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffEBEBEB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.search,size: 30,),
                              SizedBox(width: 20,),
                             TypeAheadField(
            suggestionsCallback: (search) => CityService.find(search),
               builder: (context, controller, focusNode) {
               return SizedBox(width: 150,
                 child: TextField(
                               controller: controller,
                 focusNode: focusNode,
                  autofocus: true,
                 decoration: InputDecoration(
                    border: OutlineInputBorder(),
                   labelText: 'City',
                   )
                  ),
               );
                },
  
       itemBuilder: (context, city) {
          return ListTile(
            title: Text(city.toString()),
           subtitle: Text(city.toString()),
          );
        }          ,
      onSelected: (city) {
      
  },
)
    
                            ],
                          ),
                        ),
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white

                        ),
                      ),
                      SizedBox(width: 10,),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child:Icon(Icons.format_list_numbered_sharp,size: 50,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("User's List",style: Fonts.boldFont,),
                SizedBox(height: 10,),
                Expanded(
                  child: StreamBuilder(
                    stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
                   return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                       final DocumentSnapshot customerdata=snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 45,
                                ),
                                SizedBox(width: 50,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                        Text("Name: ${customerdata["name"]}"),  
                                        SizedBox(height: 10,),          
                                        Text("Age: ${customerdata["age"]}"),            
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                             color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      );
                    },);
   } ),
                )
              ],
            ),
          ),
          
         height: size.height,
         width: size.width,
        ),
      ),
    );
  }
}