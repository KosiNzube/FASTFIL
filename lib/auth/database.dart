import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../modelspx/student.dart';
import '../screen/ChatScreen.dart';


class DataBaseService {
  final String? uid;
  final String? email;

  DataBaseService({required this.email, this.uid});

  /// collection reference 'test'.
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  Future updateUserData( String? name,String x,String y,String z) async {
    return  _reference.doc(uid).update({
      'phone': x,
      'name': name,
      'blocknumber': y,
      'roomnumber': z,


    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }

  Future updateALLLSC() async {
    return await _reference.doc(uid).update({
      'affiliate': false,
      'referrals':0,
      'myrefercode':"",
      'earnings':0,
      'referGuy':''
    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }


  Future updateCourseArray( String? list) async {
    return await _reference.doc(uid).update({
      'list': FieldValue.arrayUnion([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future negupdateCourseArray( String? list) async {
    return await _reference.doc(uid).update({
      'list': FieldValue.arrayRemove([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }

  Future updateLikeArray( String? list) async {
    return await _reference.doc(uid).update({
      'loved': FieldValue.arrayUnion([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future updateWishArray( String? list) async {
    return await _reference.doc(uid).update({
      'liked': FieldValue.arrayUnion([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future negupdateWishArray( String? list) async {
    return await _reference.doc(uid).update({
      'liked': FieldValue.arrayRemove([list]),

    }).then((value) => print("User update"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  Future updatePurchased( String? list) async {
    return await _reference.doc(uid).update({
      'purchased': FieldValue.arrayUnion([list]),

    }).then((value) => print("purchased update"))
        .catchError((error) => print("Failed to update purchase: $error"));

  }


  Future<void> addUser(String? name,bool? substate, Timestamp? timestamp)  async {

    ClientInformation info = await ClientInformation.fetch();
    QuerySnapshot snapshot= await _reference.where("id",isEqualTo: uid).get();

    if(snapshot.docs.isNotEmpty){

    }else {
      // Call the user's CollectionReference to add a new user
      return _reference.doc(uid).
      set({
        'id': uid, // John Doe
        'name': '', // Stokes and Sons
        'phone': "",
        'disable': false,
        'hostelname': "",
        'disablestamp': timestamp, // 42
        'blocknumber': "",
        'engagements': -1,
        'state': "",

      'affiliate': false,
      'referrals':0,
      'myrefercode':"",
      'earnings':0,
      'referGuy':'',
        'email': email,
        'phone': "",

        'roomnumber': "",
        'timestamp': timestamp // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }


  Future updateFaculty( String faculty)  {

    return  _reference.doc(uid).update({
      'faculty': faculty,
    }).then((value) => print("faculty update"))
        .catchError((error) => print("Failed to update user: $error"));

  }


  /// [TestData] list from snapshot.

  /// user data from snapshot
  StudentData _userDataFromSnapshot(DocumentSnapshot? snapshot) {
    if (snapshot == null || !snapshot.exists) {
      print('nuller');
      snacklong("You can not use the same email for both the Fastfil and Agent app. Open a new account with another email");

      x_Snulle=false;


      // Return a default or empty StudentData if the snapshot is null or doesn't exist
      return StudentData(
        id: '',
        name: '',
        hostelname: '',
        phone: '',
        disable: true,
        disablestamp: Timestamp(0, 0),
        blocknumber: '',
        engagements: 0,
        email: '',
        roomnumber: '',
        state: '',
        timestamp: Timestamp(0, 0),

        affiliate: false, referGuy: '', earnings: 0,myrefercode: '',referrals: 0
      );
    }

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return StudentData(
      id: data?['id'] ?? '',
      name: data?['name'] ?? '',
      hostelname: data?['hostelname'] ?? '',
      phone: data?['phone'] ?? '',
      disable: data?['disable'] ?? true,
      disablestamp: data?['disablestamp'] ?? Timestamp(0, 0),
      blocknumber: data?['blocknumber'] ?? 0,
      engagements: data?['engagements'] ?? true,
      email: data?['email'] ?? '',
      roomnumber: data?['roomnumber'] ?? 0,
      state: data?['state'] ?? '',
      timestamp: data?['timestamp'] ?? Timestamp(0, 0),
      affiliate: data?['affiliate'] ?? false,
      referGuy: data?['referGuy'] ?? '',
      earnings: data?['earnings'] ?? 0,
      myrefercode:data?['myrefercode'] ?? '',
      referrals: data?['referrals'] ?? 0,

    );
  }

  /// get stream

  /// get user doc stream
  Stream<StudentData?> get userData {
    return _reference.doc(uid).snapshots().map(_userDataFromSnapshot);
  }



  Stream<List<StudentData>> get getAllStudents{

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
        referrals: snapshot.data().toString().contains('referrals') ? snapshot.get('referrals') : 0,
        disable: snapshot.data().toString().contains('disable') ? snapshot.get('disable') : true,

      );


    }).toList();
  }
}
