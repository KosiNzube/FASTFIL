import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'chronicle.dart';




class chronicleDatabase {


  /// collection reference 'test'.


  Future<void> addChronicle(Chronicle course) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return  FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('chronicle').doc(course.id).set({
      'format': course.format,
      'id': course.id,
      'bot':course.bot,
      'content':course.content,
      'header':course.header,
      'unseen':1,
      'timestamp':course.timestamp,



    })
      .catchError((error) => print("Failed to add user: $error"));
  }






  Future deleteMsg(String id) async {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return await FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('chronicle').doc(id).delete().then((value) => print("students update"))
        .catchError((error) => print("Failed to update student: $error"));

  }



  Future updateSeen(String id) async {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return  FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('chronicle').doc(id).update({'unseen':0}).then((value) => print("rating update"))
        .catchError((error) => print("Failed to update rating: $error"));

  }


}
Stream<List<Chronicle>> get mychronicles{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  return FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('chronicle').orderBy('timestamp',descending: true).limit(15).snapshots().map(budgets);
}
List<Chronicle> budgets(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Chronicle(
      id: doc.data().toString().contains('id') ? doc.get('id') : '',
      format: doc.data().toString().contains('format') ? doc.get('format') : '',
      content: doc.data().toString().contains('content') ? doc.get('content') : '',
      header: doc.data().toString().contains('header') ? doc.get('header') : '',
      bot: doc.data().toString().contains('bot') ? doc.get('bot') : '',
      unseen: doc.data().toString().contains('unseen') ? doc.get('unseen') : 0,

      timestamp: doc.data().toString().contains('timestamp') ? doc.get('timestamp') : Timestamp(0, 0),


    );
  }).toList();
}