import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modelspx/Order.dart';



class orderDatabase {
  final String? uid;

  orderDatabase({ this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Orders');

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future updateStudent() async {
    return await _reference.doc(uid).update({'students':FieldValue.increment(1)}).then((value) => print("students update"))
        .catchError((error) => print("Failed to update student: $error"));

  }


  Future<void> addOrder(Orderx order) {

    // Call the user's CollectionReference to add a new user
    return _reference.add({
      'userID': order.userID, // John Doe
      'name': order.name, // Stokes and Sons
      'id': order.id,
      'hostelname':order.hostelname,
      'state':order.state,
      'kg':order.kg,
      'price':order.price,
      'hostelID':order.hostelID,
      'agent':order.agent,
      'stateBool':order.stateBool,
      'service':order.service,

      'userphone':order.userphone,
      'blockNO':order.blockNO,
      'roomNO':order.roomNO,
      'agentID':order.agentID,
      'deliveryDate':order.deliveryDate,

      'timestamp':order.timestamp


    })
        .then((value) {
      _reference.doc(value.id).update({'id':value.id});


    })
        .catchError((error) => print("Failed to add user: $error"));
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
        hostelID: doc.get('hostelID')??'',
        agentID: doc.get('agentID')??'',
        userphone: doc.get('userphone')??'',
        service: doc.get('service')??'',

        state: doc.get('state')??'',
        blockNO: doc.get('blockNO')??"",
        roomNO: doc.get('roomNO')??"",
        hostelname: doc.get('hostelname')??"",
        price: doc.get('price')??0,

        stateBool: doc.get('stateBool')??false,
        deliveryDate: doc.get('deliveryDate')??Timestamp(0, 0),
        timestamp: doc.get('timestamp')??Timestamp(0, 0),

      );
  }




}
