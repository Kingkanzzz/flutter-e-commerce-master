import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/MainColors.dart';
import 'chanel_screen.dart';
import 'nike_screen.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  String _selectedSize = '';
  int quantityCount = 1;
  final Map<String, dynamic> _products;

  ProductDetails(this._products);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<DocumentSnapshot> sellerData = [];
  List<String> productPrices = [];
  int quantityCount = 1;

  void selectSize(String size) {
    setState(() {
      widget._selectedSize = size;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (widget.quantityCount > 1) {
        widget.quantityCount--;
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      widget.quantityCount++;
    });
  }

  Future addToCart() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart-items");
  
  double totalPrice = calculateTotalPrice();
  String formattedTotalPrice = NumberFormat('#,###.##').format(totalPrice); // คำนวณราคารวมตามที่คุณต้องการ

  return _collectionRef
      .doc(currentUser!.email)
      .collection("items")
      .doc()
      .set({
    "name": widget._products["product-name"],
    "price": widget._products["product-price"],
    "images": widget._products["product-img"],
    "sizes": [widget._selectedSize],
    "total": "฿ $formattedTotalPrice", // Update total calculation
  }).then((value) => print("Added to cart"));
}

double calculateTotalPrice() {
  // Check if the product price is not null and is a valid double value
  double productPrice = double.tryParse(widget._products["product-price"] ?? '0') ?? 0;
  
  int quantityCount = widget.quantityCount;
  return productPrice * quantityCount;
}


  

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._products["product-name"],
      "price": widget._products["product-price"],
      "images": widget._products["product-img"],
      "sizes": [widget._selectedSize],
    }).then((value) => print("Added to favourite"));
  }

  @override
  void initState() {
    super.initState();
    fetchSellerData();
  }

  Future<void> fetchSellerData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('register-seller').get();
    setState(() {
      sellerData = snapshot.docs;
    });
  }

  // Rest of your methods (addToCart, addToFavourite, etc.)

  @override
  Widget build(BuildContext context) {

    double productPrice =
        double.parse(widget._products['product-price'].replaceAll(',', ''));
    double productPortage =
        double.parse(widget._products['product-portage'].replaceAll(',', ''));

    double totalPrice =
      (productPrice * widget.quantityCount) + productPortage;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget._products['product-name'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: CarouselSlider(
                    items: widget._products['product-img']
                        .map<Widget>((item) => Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.6,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Text(
                  "\฿ ${widget._products['product-price'].toString()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'คนรับหิ้ว',
                  style: TextStyle(fontSize: 17, color: Colors.black45),
                ),
                SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  children: sellerData.map((DocumentSnapshot document) {
                    final id = document.id;
                    String imageUrl = document['image'];
                    final name = document['name'] as String;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red,
                                // blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ]),
                        child: Center(
                          child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageUrl,
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              // contentPadding: EdgeInsets.zero,
                              title: Text(name),
                              subtitle: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.message),
                                      onPressed: () {}),
                                ],
                              ),
                              trailing: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: ((context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context, setState) {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 50),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30),
                                                  )),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 4,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 223, 221, 211),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.network(
                                                        widget._products[
                                                            "product-img"][0],
                                                        height: 80,
                                                        width: 80,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        widget._products[
                                                            "product-name"],
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(height: 5),
                                                  const Divider(
                                                      color: Colors.black),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "จำนวน",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 190),
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFF7F8FA),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() =>
                                                                    decrementQuantity());
                                                              },
                                                              icon: Icon(
                                                                Icons.remove,
                                                                size: 18,
                                                                color: MainColors
                                                                    .maincolors,
                                                              ))),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        widget.quantityCount
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: MainColors
                                                                .maincolors,
                                                            fontSize: 17),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFFF7F8FA),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() =>
                                                                    incrementQuantity());
                                                              },
                                                              icon: Icon(
                                                                Icons.add,
                                                                size: 18,
                                                                color: MainColors
                                                                    .maincolors,
                                                              ))),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "เลือกไซส์ :",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      for (var size
                                                          in widget._products[
                                                              "product-sizes"])
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (widget
                                                                      ._selectedSize ==
                                                                  size) {
                                                                // ถ้าคลิกครั้งที่สองทำให้ไม่เลือกไซส์
                                                                widget._selectedSize =
                                                                    '';
                                                              } else {
                                                                selectSize(
                                                                    size);
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        6),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFF7F8FA),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border: Border.all(
                                                                  color: widget
                                                                              ._selectedSize ==
                                                                          size
                                                                      ? MainColors
                                                                          .maincolors
                                                                      : Colors
                                                                          .grey),
                                                            ),
                                                            child: Text(
                                                                size.toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                )),
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  const Divider(
                                                      color: Colors.black),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "ราคาสินค้า",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 210),
                                                      Text(
                                                        "\฿ ${widget._products['product-price'].toString()}",
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "ค่าส่ง",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 250),
                                                      Text(
                                                        "\฿ ${widget._products['product-portage']}",
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "ราคารวม",
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 210),
                                                      Text(
                                                        "฿ ${NumberFormat('#,###').format(totalPrice * widget.quantityCount)}",
                                                      
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NikeScreen(),
                                                              ));
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 90,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MainColors
                                                                .maincolors,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Align(
                                                            child: Text(
                                                              "สั่งล่วงหน้า",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            addToCart(),
                                                        child: Container(
                                                          height: 30,
                                                          width: 110,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration: BoxDecoration(
                                                              color: MainColors
                                                                  .maincolors,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Align(
                                                              child: Text(
                                                            'เพิ่มลงรถเข็น',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ChanelScreen(),
                                                              ));
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 90,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MainColors
                                                                .maincolors,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Align(
                                                            child: Text(
                                                              "ฝากหิ้ว",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                        }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      primary: MainColors.maincolors),
                                  child: Text('ฝากหิ้วสินค้า',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
