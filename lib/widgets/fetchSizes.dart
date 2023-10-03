import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SizeDropdownFromFirestore extends StatefulWidget {
  @override
  _SizeDropdownFromFirestoreState createState() =>
      _SizeDropdownFromFirestoreState();
}

class _SizeDropdownFromFirestoreState extends State<SizeDropdownFromFirestore> {
  List<String> sizeItems = ['S', 'M', 'L', 'XL']; // Default sizes
  late String selectedSize;

  @override
  void initState() {
    super.initState();
    // Fetch size data from Firestore and populate the dropdown items
    fetchSizeDataFromFirestore();
  }

  void fetchSizeDataFromFirestore() async {
    // Replace "sizes" with the actual field name storing sizes in your Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sizes')
        .get();

    setState(() {
      sizeItems = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc['size'].toString())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Size Dropdown from Firestore'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              DropdownButtonFormField(
                value: selectedSize,
                items: sizeItems.map((String size) {
                  return DropdownMenuItem(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSize = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select a size',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Selected size: ${selectedSize ?? 'Select a size'}',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SizeDropdownFromFirestore()));
}
