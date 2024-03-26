import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'chronicle.dart';
import 'chronicleDatabase.dart';






class writeDatabase {
  final String? uid;

  writeDatabase({ this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Admindata');

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future updateStudent() async {
    return await _reference.doc(uid).update({'students':FieldValue.increment(1)}).then((value) => print("students update"))
        .catchError((error) => print("Failed to update student: $error"));

  }

  Future deleteMsg() async {
    return await _reference.doc(uid).delete().then((value) => print("students update"))
        .catchError((error) => print("Failed to update student: $error"));

  }


  Future<void> addWrite(String msg,String summary,String type, bool sent, Timestamp timestamp) {

    // Call the user's CollectionReference to add a new user
    return _reference.add({
      'student': uid, // John Doe
      'type': type,
      'summary':summary,
      'msg':msg,
      'id':"",
      'sent':sent,
      'timestamp':timestamp


    })
        .then((value) async {
      _reference.doc(value.id).update({'id':value.id});

      await chronicleDatabase().addChronicle(new Chronicle(unseen: 1,format: "text", id: value.id, bot: "writer", content: summary, header: msg, timestamp: timestamp));



    })
        .catchError((error) => print("Failed to add user: $error"));
  }



  Future updateSent() async {
    return await _reference.doc(uid).update({
      'sent': true,

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }











}
