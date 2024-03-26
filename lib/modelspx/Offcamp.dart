import 'package:afrigas/modelspx/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Offcamp{
  String id, name,state;
  int orders;


  Offcamp({
    required this.name,
    required this.orders,
    required this.state,

    required this.id,
    });
}


List<Offcamp> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Offcamp(
      name: doc.get('name') ,
      id: doc.get('id'),
      state: doc.get('state'),

      orders: doc.get('orders'),

    );
  }).toList();
}




Stream<List<Offcamp?>> get getOffcamps{



  return FirebaseFirestore.instance.collection("Offcamp").where("state", isEqualTo: x_State).snapshots().map(items);
}
