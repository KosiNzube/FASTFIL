
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../responsive.dart';

class Library{
   String courseid;
   String id;
   String name;
   String image;
   int progress;
   int total;
   List<String> watched;


   Timestamp timestamp;

   Library({
      required this.courseid,
      required this.id,
      required this.watched,

      required this.name,
      required this.image,
      required this.progress,
      required this.total,
      required this.timestamp});
}


List<Library> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Library(
         name: doc.get('name') ,
         id: doc.get('id') ,
         watched:  List<String>.from(doc.data().toString().contains('watched')?doc.get('watched') : []),

         courseid: doc.get('courseid')??'',
         progress: doc.get('progress')??0,
         total: doc.get('total')??0,
         image: doc.get('image')??'',
         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}








Stream<List<Library>> get getLibrary{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('library').orderBy('timestamp',descending: true).snapshots().map(items);
}








