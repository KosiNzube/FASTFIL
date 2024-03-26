
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Notificationx {
   String context;
   String id;
   String header;
   String image;

   Timestamp timestamp;





   Notificationx({
      required this.context,
      required this.id,
      required this.header,
      required this.image,

      required this.timestamp,


   });
   Notificationx.fromJson(Map<String, Object?> json)
       : this(
      context: json['context']! as String,
      id: json['id']! as String,
      header: json['header']! as String,
      image: json['image']! as String,

      timestamp: json['timestamp']! as Timestamp,


   );

   Map<String, Object?> toJson() {
      return {
         'id': id!=null?id:"",
         'context': context!=null?context:"",
         'header': header!=null?header:"",
         'image': image!=null?image:"",

         'timestamp': timestamp!=null?timestamp:Timestamp(0, 0),

      };
   }



   /// get stream

   /// get user doc stream


}
List<Notificationx> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Notificationx(
         id: doc.get('id') ,
         context: doc.get('context'),
         header: doc.get('header'),
         image: doc.get('image'),

         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}

Stream<List<Notificationx>> get getnots{

   return FirebaseFirestore.instance.collection("Notifications").orderBy('timestamp',descending: true)  .snapshots().map(items);
}




