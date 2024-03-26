import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modelspx/Library.dart';


class cartDatabase {
  final String? uid;
  final String? productid;


  cartDatabase({ required this.uid,required this.productid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  Future addtocart() async {
    return await _reference.doc(uid).collection("cart").doc(productid).update({'numberofproducts':FieldValue.increment(1)}).then((value) => print("numberofproducts update"))
        .catchError((error) => print("Failed to update student: $error"));
  }

  Future removefromcart() async {
    return await _reference.doc(uid).collection("cart").doc(productid).update({'numberofproducts':FieldValue.increment(-1)}).then((value) => print("numberofproducts update"))
        .catchError((error) => print("Failed to update student: $error"));

  }
  Future deletefromcart() async {
    return await _reference.doc(uid).collection("cart").doc(productid).delete().then((value) => print("numberofproducts delete"))
        .catchError((error) => print("Failed to update student: $error"));

  }
  Future calculatetotal(double x) async {
    return await _reference.doc(uid).collection("cart").doc(productid).update({'total':x}).then((value) => print("total update"))
        .catchError((error) => print("Failed to update student: $error"));
  }





}
