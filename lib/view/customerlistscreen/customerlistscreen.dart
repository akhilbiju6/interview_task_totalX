// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx_interview_project/control/controller.dart';
import 'package:totalx_interview_project/utils.dart';
import 'package:totalx_interview_project/view/addauserscreen/addauserscreen.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection("customerdata").snapshots();
  final TextEditingController _searchController = TextEditingController();
  bool showSearchField = false;
  List<DocumentSnapshot> _customerList = [];
  List<DocumentSnapshot> _filteredCustomerList = [];
  String _selectedOption = 'All';
void initState() {
     Provider.of<HomeScreenController>(context,listen: false).getimageurl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserScreen(),
            ),
          );
        },
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Color(0xffEBEBEB),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading"));
              }

              _customerList = snapshot.data!.docs;

              // Apply filters
              _filteredCustomerList = _applyFilters(_customerList);

              return Column(
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showSearchField = !showSearchField;
                                      if (!showSearchField) {
                                        _searchController.clear();
                                        _filteredCustomerList = _applyFilters(_customerList);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.search,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: TextFormField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        _filteredCustomerList = _applyFilters(_customerList);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setDialogState) {
                                    return AlertDialog(
                                      actions: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: 'All',
                                                  groupValue: _selectedOption,
                                                  onChanged: (String? value) {
                                                    setDialogState(() {
                                                      _selectedOption = value!;
                                                      _filteredCustomerList = _applyFilters(_customerList);
                                                    });
                                                    Navigator.of(context).pop(); // Close the dialog
                                                    setState(() {}); // Ensure UI updates
                                                  },
                                                ),
                                                SizedBox(width: 10),
                                                Text("All")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: 'Elder',
                                                  groupValue: _selectedOption,
                                                  onChanged: (String? value) {
                                                    setDialogState(() {
                                                      _selectedOption = value!;
                                                      _filteredCustomerList = _applyFilters(_customerList);
                                                    });
                                                    Navigator.of(context).pop(); // Close the dialog
                                                    setState(() {}); // Ensure UI updates
                                                  },
                                                ),
                                                SizedBox(width: 10),
                                                Text("Age: Elder")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: 'Younger',
                                                  groupValue: _selectedOption,
                                                  onChanged: (String? value) {
                                                    setDialogState(() {
                                                      _selectedOption = value!;
                                                      _filteredCustomerList = _applyFilters(_customerList);
                                                    });
                                                    Navigator.of(context).pop(); // Close the dialog
                                                    setState(() {}); // Ensure UI updates
                                                  },
                                                ),
                                                SizedBox(width: 10),
                                                Text("Age: Younger")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.format_list_numbered_sharp,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "User's List",
                    style: Fonts.boldFont,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredCustomerList.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot customerData = _filteredCustomerList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipOval(
                                 child: SizedBox(
                                  width: 90, // Adjust the width
                                     height: 90, // Adjust the height
                                         child: Image.network(
                                          customerData['imageUrl']??"noimages",
                                          // Provider.of<HomeScreenController>(context).newimageurl.toString(),
                                        fit: BoxFit.cover, // Ensures the image covers the entire area
                                            ),
                                        ),
                                      ),
                                  SizedBox(width: 50),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("Name: ${customerData['name'] ?? 'Unknown'}"),
                                        SizedBox(height: 10),
                                        Text("Age: ${customerData['age'] ?? 'Unknown'}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Method to apply filters based on search and selected option
  List<DocumentSnapshot> _applyFilters(List<DocumentSnapshot> customerList) {
    // Apply search filter
    List<DocumentSnapshot> filteredList = customerList.where((doc) {
      String name = doc['name'] ?? '';
      return name.toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();

    // Apply age filter
    if (_selectedOption == 'Elder') {
      filteredList = filteredList.where((doc) {
        var age = doc['age'];
        int ageInt = (age is String) ? int.tryParse(age) ?? 0 : age as int;
        return ageInt > 60;
      }).toList();
    } else if (_selectedOption == 'Younger') {
      filteredList = filteredList.where((doc) {
        var age = doc['age'];
        int ageInt = (age is String) ? int.tryParse(age) ?? 0 : age as int;
        return ageInt <= 60;
      }).toList();
    }

    return filteredList;
  }
}
