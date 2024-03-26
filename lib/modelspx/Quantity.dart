import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Quantity{
  String  name;
  int price;


  Quantity({
    required this.name,

    required this.price,
    });
}


List<Quantity> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Quantity(
      name: doc.get('name') ,
      price: doc.get('price')??0,

    );
  }).toList();
}




Stream<List<Quantity?>> get getQuantities{

  return FirebaseFirestore.instance.collection("Quantity").snapshots().map(items);
}
