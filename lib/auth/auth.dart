import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../modelspx/student.dart';
import 'database.dart';

class AuthSerives {



  final FirebaseAuth _auth = FirebaseAuth.instance;

  Student? _usersFromFirebaseUser(User? user) {
    return user != null ? Student(id: user.uid, email: user.email.toString()) : null;
  }

  Future signMailPassword(String? email, String? password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      User user = result.user!;
      FirebaseMessaging.instance.subscribeToTopic(user.uid);
      FirebaseMessaging.instance.subscribeToTopic("ADMIN_USERS");



      return _usersFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text( e.code.toString()),
      ));

      return null;
    }
  }




  Future registerMailPasword(String? email, String? password,BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      User user = result.user!;
      FirebaseMessaging.instance.subscribeToTopic(user.uid);
      FirebaseMessaging.instance.subscribeToTopic("ADMIN_USERS");

      /// create a new document for the user with the uid
      await DataBaseService(uid: user.uid, email:user.email )
          .addUser('0', false, Timestamp.fromDate(DateTime.now()));

      return _usersFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text( e.code.toString()),
      ));
      return null;
    }
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print('error : ${e.code}');
    }
  }

  Stream<Student?> get user {
    return _auth.authStateChanges().map(_usersFromFirebaseUser);
  }



}


