import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/MainColors.dart';
import 'package:flutter_ecommerce/ui/adidas_screen.dart';
import 'package:flutter_ecommerce/ui/allproducts.dart';
import 'package:flutter_ecommerce/ui/bagsproducts.dart';
import 'package:flutter_ecommerce/ui/chanel_screen.dart';
import 'package:flutter_ecommerce/ui/nike_screen.dart';
import 'package:flutter_ecommerce/ui/shirtproducts.dart';
import 'package:flutter_ecommerce/ui/shoesproducts.dart';
import 'package:flutter_ecommerce/ui/test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Seller> sellers = [];
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  var _seller;
  

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });
    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
  }
  

  // fetchSeller() async {
  //   QuerySnapshot qn = await _firestoreInstance
  //       .collection("register-users")
  //       .doc()
  //       .collection("seller")
  //       .get();
  //   setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       _seller.add({
  //         "address": qn.docs[i]["address"],
  //         "brand": qn.docs[i]["brand"],
  //         "email": qn.docs[i]["email"],
  //         "idcard": qn.docs[i]["idcard"],
  //         "mobile": qn.docs[i]["mobile"],
  //         "name": qn.docs[i]['name'],
  //         "url": qn.docs[i]["url"],
  //         "username": qn.docs[i]["username"]
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    // sellers = [];
    // fetchSeller();
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    borderSide: BorderSide(
                      color: MainColors.maincolors,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Search products here",
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
                onTap: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => SearchScreen())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AllProducts();
                      }));
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        child: Text(
                          "ทั้งหมด",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ShirtProducts();
                      }));
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        child: Text(
                          "เสื้อ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BagsProducts();
                      }));
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        child: Text(
                          "กระเป๋า",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ShoesProducts();
                      }));
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        child: Text(
                          "รองเท้า",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AspectRatio(
              aspectRatio: 2,
              child: CarouselSlider(
                  items: _carouselImages
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            SizedBox(
              height: 10.h,
            ),
            DotsIndicator(
              dotsCount:
                  _carouselImages.length == 0 ? 1 : _carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: MainColors.maincolors,
                color: MainColors.maincolors.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6, 6),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(width: 17),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AdidasScreen();
                    }));
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Image.asset("assets/adidas.png")),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NikeScreen();
                    }));
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Image.asset("assets/nikelogo.png")),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChanelScreen();
                    }));
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Image.asset("assets/chanel.png")),
                ),
              ],
            ),
            SizedBox(height: 10),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) {
            //         return YourWidget();
            //       }));
            //     },
            //     child: Text('ฝากหิ้ว'))
          ],
        ),
      )),
    );
  }
}
