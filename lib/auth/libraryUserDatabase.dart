import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modelspx/Library.dart';


class libUser {
  final String? uid;
  final String? learnid;


  libUser({ required this.uid,required this.learnid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  Future updateProgress() async {
    return await _reference.doc(uid).collection("library").doc(learnid).update({'progress':FieldValue.increment(1)}).then((value) => print("progress update"))
        .catchError((error) => print("Failed to update student: $error"));

  }




  Future updateUserData( String? id) async {
    return await _reference.doc(uid).collection("library").doc(learnid).update({
      'id': learnid,
    }).then((value) => print("id update"))
        .catchError((error) => print("Failed to update user: $error"));

  }





  Library item(DocumentSnapshot doc ){
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
  }


}
