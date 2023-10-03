import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/product_details_screen.dart';

import '../const/SecColors.dart';
import 'test.dart';

class ChanelScreen extends StatefulWidget {
  const ChanelScreen({super.key});

  @override
  State<ChanelScreen> createState() => _ChanelScreenState();
}

class _ChanelScreenState extends State<ChanelScreen> {
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("pd-chanel").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
          "product-sizes": (qn.docs[i]["product-sizes"] as List)
            .map((size) => size.toString())
            .toList(),
        });
      }
    });
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CHANEL')),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetails(_products[index]))),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            AspectRatio(
                                aspectRatio: 1.5,
                                child: Container(
                                    color: SecColors.seccolors,
                                    child: Image.network(
                                      _products[index]["product-img"][0],
                                      fit: BoxFit.fitWidth,)
                                      )),
                            SizedBox(height: 10),
                            Text("${_products[index]["product-name"]}"),
                            Text(
                                "\฿ ${_products[index]["product-price"].toString()}"),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
