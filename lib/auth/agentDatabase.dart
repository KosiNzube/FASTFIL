import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modelspx/Order.dart';



class agentDatabase {
  final String? uid;

  agentDatabase({ this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Agents');

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future updateDeliveries() async {
    return await _reference.doc(uid).update({'deliveries':FieldValue.increment(1)}).then((value) => print("deliveries update"))
        .catchError((error) => print("Failed to update deliveries: $error"));

  }




}
