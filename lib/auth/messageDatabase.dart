import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modelspx/Order.dart';
import '../screen/ChatScreenxxx.dart';



class messageDatabase {
  final String? uid;

  messageDatabase({ this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Messages');

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future updateStudent() async {
    return await _reference.doc(uid).update({'students':FieldValue.increment(1)}).then((value) => print("students update"))
        .catchError((error) => print("Failed to update student: $error"));

  }



  Future<void> addMessage(String agentid,String student,String studentname, String text, String type, bool sent, Timestamp timestamp,bool xy) {

    // Call the user's CollectionReference to add a new user
    return _reference.add({
      'student': student, // John Doe
      'agent': agentid, // Stokes and Sons
      'type': type,
      'agentsender': false,
      'content':text,
      'del': false,

      'id':"",
      'sent':sent,
      'timestamp':timestamp


    })
        .then((value) async {
       _reference.doc(value.id).update({'id':value.id});
      await _reference.doc(value.id).update({'del':true});

       DocumentSnapshot documentSnapshot=await _reference.doc(value.id).get();

       if(documentSnapshot.exists){
         bool snt=documentSnapshot['sent'];

         if(snt==false){
           print("notseen");
           sendMessageToTopic(agentid, studentname, text);

         }else{
           print("seen");

         }

       }

    })
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future updateSent() async {
    return await _reference.doc(uid).update({
      'sent': true,

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }



  Future updateOrder( String? state,bool? stateBool, Timestamp? deliveryDate) async {
    return await _reference.doc(uid).update({
      'deliveryDate': deliveryDate,
      'state': state,
      'stateBool': stateBool,
    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }


  Future<void> publisher(bool x) {

    // Call the user's CollectionReference to add a new user
    return _reference.doc(uid).update({

      'publish': x,


    })
        .then((value) {

      // DataBaseService(uid: firebaseAuth.currentUser!.uid, email: firebaseAuth.currentUser!.email).updateNumC();

    })
        .catchError((error) => print("Failed to add user: $error"));
  }




  Future deleteOrder() async {
    return await _reference.doc(uid).delete();
  }

  Stream<Orderx> get coursedata {
    return _reference.doc(uid).snapshots().map(items);
  }

  Orderx items(DocumentSnapshot doc ){
      return Orderx(
        id: doc.get('id')??'',
        name: doc.get('name') ,
        userID: doc.get('userID')??'',
        agent: doc.get('agent')??'',
        kg: doc.get('kg')??'',
        service: doc.get('service')??'',

        hostelID: doc.get('hostelID')??'',
        agentID: doc.get('agentID')??'',
        userphone: doc.get('userphone')??'',
        state: doc.get('state')??'',
        blockNO: doc.get('blockNO')??0,
        roomNO: doc.get('roomNO')??0,
        hostelname: doc.get('hostelname')??"",
        price: doc.get('price')??0,

        stateBool: doc.get('stateBool')??false,
        deliveryDate: doc.get('deliveryDate')??Timestamp(0, 0),
        timestamp: doc.get('timestamp')??Timestamp(0, 0),

      );
  }





}
