import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/login_screen.dart';

Future<User?> createAccount(String name, String email, String password, String phone , String address, {Uint8List? file}) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);
    String imageUrl = await uploadImageToStorage('user/${_auth.currentUser!.uid}', file!); // ใช้ UID เป็นชื่อไฟล์
    await _firestore.collection('users-depositor').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "password" :password,
      "phone": phone,
      "address": address,
      'image': imageUrl,
      "status": "Unavalible",
      "uid": _auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}
final FirebaseStorage _storage = FirebaseStorage.instance;
uploadImageToStorage(String childName, Uint8List? file) async {
   Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file!);
    TaskSnapshot snapshot = await uploadTask;
    String DownloadUrl = await snapshot.ref.getDownloadURL();
    return DownloadUrl;
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users-depositor')
        .doc(_auth.currentUser!.uid)
        .get();
        // .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}