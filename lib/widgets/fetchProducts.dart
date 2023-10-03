import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/MainColors.dart';

Widget fetchData(String collectionName) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
            dynamic imageUrl = _documentSnapshot['images'];

            // Assuming you want to display the first image if there are multiple
            String firstImageUrl = imageUrl.isNotEmpty ? imageUrl[0] : 'images';

            return Card(
              elevation: 5,
              child: ListTile(
                leading: firstImageUrl != null && firstImageUrl.isNotEmpty
                    ? Image.network(
                        firstImageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey, // Placeholder color
                      ),
                title: Text(_documentSnapshot['name']),
                subtitle: Text(
                  "\฿ ${_documentSnapshot['price']}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                trailing: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: MainColors.maincolors,
                    child: Icon(Icons.delete_outline,color: Colors.white,),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection(collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .doc(_documentSnapshot.id)
                        .delete();
                  },
                ),
              ),
            );
          });
    },
  );
}
