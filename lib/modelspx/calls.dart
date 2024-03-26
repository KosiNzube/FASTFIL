
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Calls {
   String number;
   String id;
   String agentID;
   String userID;
   String agentname;

   Timestamp timestamp;





   Calls({
      required this.number,
      required this.id,
      required this.agentID,
      required this.userID,
      required this.agentname,

      required this.timestamp,


   });
   Calls.fromJson(Map<String, Object?> json)
       : this(
      agentname: json['agentname']! as String,
      id: json['id']! as String,
      agentID: json['agentID']! as String,
      userID: json['userID']! as String,
      number: json['number']! as String,
      timestamp: json['timestamp']! as Timestamp,


   );

   Map<String, Object?> toJson() {
      return {
         'id': id!=null?id:"",
         'userID': userID!=null?userID:"",
         'number': number!=null?number:"",
         'agentname': agentname!=null?agentname:"",
         'agentID': agentID!=null?agentID:"",

         'timestamp': timestamp!=null?timestamp:Timestamp(0, 0),

      };
   }



   /// get stream

   /// get user doc stream


}
List<Calls> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Calls(
         id: doc.get('id') ,
         userID: doc.get('userID'),
         number: doc.get('number'),
         agentname: doc.get('agentname'),
         agentID: doc.get('agentID'),

         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}

Stream<List<Calls>> get getcalls{

   return FirebaseFirestore.instance.collection("Calls").orderBy('timestamp',descending: true).limit(30)  .snapshots().map(items);
}




