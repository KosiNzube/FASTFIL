import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Statex{
  String name;
  int orders;


  Statex({
    required this.name,
    required this.orders,
   });
}


List<Statex> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Statex(
      name: doc.get('name') ,
      orders: doc.get('orders'),

    );
  }).toList();
}




Stream<List<Statex?>> get getStates{

  return FirebaseFirestore.instance.collection("States").snapshots().map(items);
}


Stream<List<Statex?>> get getStatesxxx{

  return FirebaseFirestore.instance.collection("States").snapshots().map(items);
}