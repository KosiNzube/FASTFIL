import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modelspx/Library.dart';


class userCart {
  String description;
  int numitems;
  int saleprice;
  String image;
  String id;
  Timestamp timestamp;

  userCart({ required this.description,required this.saleprice,required this.image,required this.id,required this.numitems,required this.timestamp});

  /// collection reference 'test'.
  final CollectionReference _reference = FirebaseFirestore.instance.collection('students');



  Future updateUserData( String? id) async {
    return await _reference.doc(id).collection("cart").doc(id).update({
      'id': id,
    }).then((value) => print("id update"))
        .catchError((error) => print("Failed to update user: $error"));

  }





  userCart item(DocumentSnapshot doc ){
      return userCart(
        description: doc.get('description') ,
        id: doc.get('id') ,
        saleprice: doc.get('saleprice')??0,


        numitems: doc.get('numitems')??0,
        image: doc.get('image')??'',
        timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
  }


}
