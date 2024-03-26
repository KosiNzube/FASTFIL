
import 'package:afrigas/modelspx/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Admin {
   String perKG;
   String disclaimer;
   String deliveryFee;
   List refercodes;
   String password;
   String id;


   Admin({
      required this.perKG,
      required this.password,
      required this.disclaimer,
      required this.id,
      required this.deliveryFee,
      required this.refercodes,

   });




   /// get stream

   /// get user doc stream


}
Admin _userDataFromSnapshot(DocumentSnapshot? snapshot) {
   return Admin(
      id:  snapshot!.data().toString().contains('id') ? snapshot.get('id') : '',
      password:  snapshot.data().toString().contains('password') ? snapshot.get('password') : '',
      perKG:  snapshot.data().toString().contains('perKG') ? snapshot.get('perKG') : '',
      refercodes:  List<dynamic>.from(snapshot.data().toString().contains('refercodes')?snapshot.get('refercodes') : []),

      disclaimer:  snapshot.data().toString().contains('disclaimer') ? snapshot.get('disclaimer') : '',
      deliveryFee:  snapshot.data().toString().contains('deliveryFee') ? snapshot.get('deliveryFee') : '',
   );
}
Stream<Admin> get adminData {
   final CollectionReference _reference =
   FirebaseFirestore.instance.collection('ADMIN');
   return _reference.doc("ihFiNg83MAyFX3danjxr").snapshots().map(_userDataFromSnapshot);
}

Stream<List<StudentData?>> get getAllStudents{

   FirebaseAuth firebaseAuth =FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("students").snapshots().map(allStudents);
}


List<StudentData> allStudents(QuerySnapshot snapshotx ){
   return snapshotx.docs.map((snapshot){
      return StudentData(
         id:  snapshot!.data().toString().contains('id') ? snapshot.get('id') : '',
         name:  snapshot.data().toString().contains('name') ? snapshot.get('name') : '',
         hostelname:snapshot.data().toString().contains('hostelname') ? snapshot.get('hostelname') : '',
         phone: snapshot.data().toString().contains('phone') ? snapshot.get('phone') : '',
         disablestamp:snapshot.data().toString().contains('disablestamp') ? snapshot.get('disablestamp') : Timestamp(0, 0),
         blocknumber: snapshot.data().toString().contains('blocknumber') ? snapshot.get('blocknumber') : '',
         engagements: snapshot.data().toString().contains('engagements') ? snapshot.get('engagements') : 0,
         email: snapshot.data().toString().contains('email') ? snapshot.get('email') : "",
         roomnumber: snapshot.data().toString().contains('roomnumber') ? snapshot.get('roomnumber') : "",
         state: snapshot.data().toString().contains('state') ? snapshot.get('state') : "",
         timestamp:snapshot.data().toString().contains('timestamp') ? snapshot.get('timestamp') : Timestamp(0, 0),
         affiliate: snapshot.data().toString().contains('affiliate') ? snapshot.get('affiliate') : false,
         referGuy: snapshot.data().toString().contains('referGuy') ? snapshot.get('referGuy')  : '',
         earnings:snapshot.data().toString().contains('earnings') ? snapshot.get('earnings')  : 0,
         myrefercode:snapshot.data().toString().contains('myrefercode') ? snapshot.get('myrefercode')  : '',
         referrals:  snapshot.data().toString().contains('referrals') ? snapshot.get('referrals')  : 0,
         disable: snapshot.data().toString().contains('disable') ? snapshot.get('disable') : true,

      );
   }).toList();
}
