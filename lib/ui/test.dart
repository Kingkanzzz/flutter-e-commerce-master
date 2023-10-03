// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/const/AppColors.dart';
// import 'package:flutter_ecommerce/const/MainColors.dart';
// import 'package:flutter_ecommerce/ui/chanel_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'nike_screen.dart';

// class ProductDetails extends StatefulWidget {
//   var _product;
//   ProductDetails(this._product);
//   String _selectedSize = '';
//   int quantityCount = 0;
//   @override
//   _ProductDetailsState createState() => _ProductDetailsState();
// }

// class _ProductDetailsState extends State<ProductDetails> {
//   void selectSize(String size) {
//     setState(() {
//       widget._selectedSize = size;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   void decrementQuantity() {
//     setState(() {
//       widget.quantityCount=widget.quantityCount-1;
//     });
//   }

//   void incrmentQuantity() {
//     setState(() {
//       widget.quantityCount=widget.quantityCount+1;
//     });
//   }

//   Future addToCart() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     var currentUser = _auth.currentUser;
//     CollectionReference _collectionRef =
//         FirebaseFirestore.instance.collection("users-cart-items");
//     return _collectionRef
//         .doc(currentUser!.email)
//         .collection("items")
//         .doc()
//         .set({
//       "name": widget._product["product-name"],
//       "price": widget._product["product-price"],
//       "images": widget._product["product-img"],
//       "product-sizes": [widget._selectedSize],
//     }).then((value) => print("Added to cart"));
//   }

//   Future addToFavourite() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     var currentUser = _auth.currentUser;
//     CollectionReference _collectionRef =
//         FirebaseFirestore.instance.collection("users-favourite-items");
//     return _collectionRef
//         .doc(currentUser!.email)
//         .collection("items")
//         .doc()
//         .set({
//       "name": widget._product["product-name"],
//       "price": widget._product["product-price"],
//       "images": widget._product["product-img"],
//       "product-sizes": [widget._selectedSize],
//     }).then((value) => print("Added to favourite"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget._product['product-name'],
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         backgroundColor: MainColors.maincolors,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             backgroundColor: MainColors.maincolors,
//             child: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: Colors.white,
//                 )),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//           padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AspectRatio(
//                 aspectRatio: 1.5,
//                 child: CarouselSlider(
//                     items: widget._product['product-img']
//                         .map<Widget>((item) => Padding(
//                               padding: const EdgeInsets.only(left: 3, right: 3),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image: NetworkImage(item),
//                                         fit: BoxFit.fitWidth)),
//                               ),
//                             ))
//                         .toList(),
//                     options: CarouselOptions(
//                         autoPlay: false,
//                         enlargeCenterPage: true,
//                         viewportFraction: 0.6,
//                         enlargeStrategy: CenterPageEnlargeStrategy.height,
//                         onPageChanged: (val, carouselPageChangedReason) {
//                           setState(() {});
//                         })),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "\฿ ${widget._product['product-price'].toString()}",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 26,
//                         color: Colors.black),
//                   ),
//                   StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("users-favourite-items")
//                         .doc(FirebaseAuth.instance.currentUser!.email)
//                         .collection("items")
//                         .where("name",
//                             isEqualTo: widget._product['product-name'])
//                         .snapshots(),
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
//                       if (snapshot.data == null) {
//                         return Text("");
//                       }
//                       return Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 160),
//                             child: IconButton(
//                               onPressed: () => snapshot.data.docs.length == 0
//                                   ? addToFavourite()
//                                   : print("Already Added"),
//                               icon: snapshot.data.docs.length == 0
//                                   ? Icon(
//                                       Icons.favorite_outline,
//                                       color: MainColors.maincolors,
//                                     )
//                                   : Icon(
//                                       Icons.favorite,
//                                       color: MainColors.maincolors,
//                                     ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Text("ชอบ",
//                       style: TextStyle(
//                           color: MainColors.maincolors, fontSize: 16)),
//                 ],
//               ),
//               Text("คนรับหิ้ว",
//                   style: TextStyle(color: Colors.grey[600], fontSize: 14)),
//               SizedBox(height: 10),
//               Center(
//                 child: Container(
//                   width: 350,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white, // Background color
//                     borderRadius: BorderRadius.circular(20), // Border radius
//                     border: Border.all(
//                       color: MainColors.maincolors, // Border color
//                       width: 2.0, // Border width
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         blurRadius: 10.0,
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//                             child: CircleAvatar(
//                               radius: 25,
//                               backgroundColor: MainColors.maincolors,
//                               child: Image.network(
//                                 widget._product["product-img"][0],
//                                 fit: BoxFit.fitWidth,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                             child: Text(
//                               widget._product["product-name"],
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(220, 0, 0, 0),
//                                     child: ElevatedButton(
//                                         onPressed: () {
//                                           showModalBottomSheet(
//                                               context: context,
//                                               builder: ((context) {
//                                                 return Container(
//                                                   padding: EdgeInsets.only(
//                                                       left: 20,
//                                                       right: 20,
//                                                       bottom: 50),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                         topLeft:
//                                                             Radius.circular(30),
//                                                         topRight:
//                                                             Radius.circular(30),
//                                                       )),
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       SizedBox(height: 10),
//                                                       Container(
//                                                         height: 4,
//                                                         width: 50,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: Color.fromARGB(
//                                                               255,
//                                                               223,
//                                                               221,
//                                                               211),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                         ),
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Image.network(
//                                                             widget._product[
//                                                                 "product-img"][0],
//                                                             height: 80,
//                                                             width: 80,
//                                                           ),
//                                                           SizedBox(width: 5),
//                                                           Text(
//                                                             widget._product[
//                                                                 "product-name"],
//                                                             style: TextStyle(
//                                                                 fontSize: 16),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // SizedBox(height: 5),
//                                                       const Divider(
//                                                           color: Colors.black),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             "จำนวน",
//                                                             style: TextStyle(
//                                                               fontSize: 17,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ),
//                                                           SizedBox(width: 190),
//                                                           Container(
//                                                             width: 30,
//                                                             height: 30,
//                                                               decoration: BoxDecoration(
//                                                                   color: Color(
//                                                                       0xFFF7F8FA),
//                                                                   shape: BoxShape.circle,),
//                                                               child: IconButton(
//                                                                   onPressed:
//                                                                       decrementQuantity,
//                                                                   icon: Icon(
//                                                                     Icons
//                                                                         .remove,
//                                                                     size: 18,
//                                                                     color: MainColors.maincolors,
//                                                                   ))),
//                                                           SizedBox(width: 8),
//                                                           Text(
//                                                             widget.quantityCount
//                                                                 .toString(),
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     MainColors.maincolors,
//                                                                 fontSize: 17),
//                                                           ),
//                                                           SizedBox(width: 8),
//                                                           Container(
//                                                             width: 30,
//                                                             height: 30,
//                                                               decoration: BoxDecoration(
//                                                                   color: Color(
//                                                                       0xFFF7F8FA),
//                                                                   shape: BoxShape
//                                                                       .circle),
//                                                               child: IconButton(
//                                                                   onPressed:
//                                                                       incrmentQuantity,
//                                                                   icon: Icon(
//                                                                     Icons.add,
//                                                                     size: 18,
//                                                                     color: MainColors.maincolors,
//                                                                   ))),
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 20),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             "เลือกไซส์ :",
//                                                             style: TextStyle(
//                                                               fontSize: 17,
//                                                             ),
//                                                           ),
//                                                           SizedBox(width: 5),
//                                                           for (var size in widget._product["product-sizes"])
//                                                             GestureDetector(
//                                                               onTap: () {
//                                                                 selectSize(size);
//                                                                 // Navigator.pop(context);
//                                                               },
//                                                               child: Container(
//                                                                 width: 30,
//                                                                 height: 30,
//                                                                 margin: EdgeInsets.symmetric(
//                                                                 horizontal: 6),
//                                                                 padding:EdgeInsets.all(8),
//                                                                 decoration:BoxDecoration(
//                                                                   color: Color(0xFFF7F8FA),
//                                                                   borderRadius:
//                                                                       BorderRadius.circular(20),
//                                                                   border: Border.all(
//                                                                     color: widget._selectedSize == size
//                                                                     ? MainColors.maincolors
//                                                                     : Colors.grey
//                                                                   ),
//                                                                 ),
//                                                                 child: Text(size
//                                                                     .toString(),style: TextStyle(fontSize: 10,)),
//                                                               ),
//                                                             )
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 10),
//                                                       const Divider(
//                                                           color: Colors.black),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             "ราคาสินค้า",
//                                                             style: TextStyle(
//                                                               fontSize: 17,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ),
//                                                           SizedBox(width: 210),
//                                                           Text(
//                                                             "\฿ ${widget._product['product-price'].toString()}",
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             "ค่าหิ้ว",
//                                                             style: TextStyle(
//                                                               fontSize: 17,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ),
//                                                           SizedBox(width: 280),
//                                                           Text("฿10")
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             "ค่าส่ง",
//                                                             style: TextStyle(
//                                                               fontSize: 17,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ),
//                                                           SizedBox(width: 280),
//                                                           Text("฿50")
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 5),
//                                                       Row(
//                                                         children: [
//                                                           InkWell(
//                                                             onTap: () {
//                                                               Navigator.push(
//                                                                   context,
//                                                                   MaterialPageRoute(
//                                                                     builder:
//                                                                         (context) =>
//                                                                             NikeScreen(),
//                                                                   ));
//                                                             },
//                                                             child: Container(
//                                                               height: 30,
//                                                               width: 90,
//                                                               margin: EdgeInsets
//                                                                   .all(10),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color:
//                                                                     MainColors.maincolors,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                               ),
//                                                               child: Align(
//                                                                 child: Text(
//                                                                   "สั่งล่วงหน้า",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           15,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           InkWell(
//                                                             child: Container(
//                                                               height: 30,
//                                                               width: 110,
//                                                               margin: EdgeInsets.all(10),
//                                                               decoration: BoxDecoration(
//                                                                 color: MainColors.maincolors,
//                                                                 borderRadius: BorderRadius.circular(20)
//                                                               ),
//                                                               child: ElevatedButton(
//                                                                 onPressed: () => addToCart(),
//                                                                 child: Text("เพิ่มลงรถเข็น")
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           InkWell(
//                                                             onTap: () {
//                                                               Navigator.push(
//                                                                   context,
//                                                                   MaterialPageRoute(
//                                                                     builder:
//                                                                         (context) =>
//                                                                             ChanelScreen(),
//                                                                   ));
//                                                             },
//                                                             child: Container(
//                                                               height: 30,
//                                                               width: 90,
//                                                               margin: EdgeInsets
//                                                                   .all(10),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color:
//                                                                     MainColors.maincolors,
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                               ),
//                                                               child: Align(
//                                                                 child: Text(
//                                                                   "ฝากหิ้ว",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           15,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ),
//                                                 );
//                                               }));
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(30))),
//                                         child: Text(
//                                           'ฝากหิ้วสินค้า',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ))),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30)
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

