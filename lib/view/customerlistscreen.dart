// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/addauserscreen.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
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
        child: SizedBox(
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
                              Text("Search By Name")
                            ],
                          ),
                        ),
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(202, 194, 194, 1)
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
                  child: ListView.builder(itemBuilder: (context, index) {
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
                                      Text("Name: Name"),  
                                      SizedBox(height: 10,),          
                                      Text("Age: 34"),            
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                           color: Colors.red,
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                    );
                  },),
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