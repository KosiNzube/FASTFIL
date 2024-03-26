
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Message {
   String agent;
   String student;
   String id;

   String content;
   String type;
   bool sent;
   bool del;

   bool agentsender;
   Timestamp timestamp;





   Message({
      required this.student,
      required this.agent,
      required this.type,
      required this.del,

      required this.id,
      required this.agentsender,
      required this.content,
      required this.sent,
      required this.timestamp,


   });
   Message.fromJson(Map<String, Object?> json)
       : this(
      student: json['student']! as String,
      agent: json['agent']! as String,
      type: json['type']! as String,
      id: json['id']! as String,
      content: json['content']! as String,
      del: json['del']! as bool,

      timestamp: json['timestamp']! as Timestamp,
      agentsender: json['agentsender']! as bool,

      sent: json['sent']! as bool,


   );

   Map<String, Object?> toJson() {
      return {
         'id': id!=null?id:"",
         'agent': agent!=null?agent:"",
         'student': student!=null?student:"",
         'type': type!=null?type:"",
         'timestamp': timestamp!=null?timestamp:Timestamp(0, 0),
         'content': content!=null?content:"",
         'sent': sent!=null?sent:false,
         'del': del!=null?del:false,

         'agentsender': agentsender!=null?agentsender:"",

      };
   }



   /// get stream

   /// get user doc stream


}
List<Message> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Message(
         agent: doc.get('agent') ,
         student: doc.get('student'),
         type: doc.get('type'),
         content: doc.get('content'),
         id: doc.get('id'),
         agentsender: doc.get('agentsender')??false,
         del: doc.get('del')??false,

         sent: doc.get('sent')??false,
         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}

Stream<List<Message>> get getMsgs{

   FirebaseAuth firebaseAuth =FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("Messages").where("student",isEqualTo: firebaseAuth.currentUser!.uid).orderBy('timestamp',descending: true)  .snapshots().map(items);
}




