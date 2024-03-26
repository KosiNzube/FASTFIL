import 'package:afrigas/modelspx/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Hostel{
  String id, name,state;
  int orders;


  Hostel({
    required this.name,
    required this.orders,
    required this.state,

    required this.id,
    });
}


List<Hostel> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Hostel(
      name: doc.get('name') ,
      orders: doc.get('orders') ,
      state: doc.get('state') ,

      id: doc.get('id'),

    );
  }).toList();
}




Stream<List<Hostel?>> get getHostels{

  return FirebaseFirestore.instance.collection("Hostels").where("state", isEqualTo: x_State).snapshots().map(items);
}
