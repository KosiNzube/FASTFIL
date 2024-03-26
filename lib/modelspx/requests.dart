
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Requestx {
   String content;
   String student;
   int state;
   String id;

   Timestamp timestamp;





   Requestx({
      required this.content,
      required this.id,

      required this.student,
      required this.state,
      required this.timestamp,


   });
   Requestx.fromJson(Map<String, Object?> json)
       : this(
      content: json['content']! as String,
      student: json['student']! as String,
      state: json['state']! as int,
      id: json['id']! as String,

      timestamp: json['timestamp']! as Timestamp,


   );

   Map<String, Object?> toJson() {
      return {
         'content': content!=null?content:"",
         'student': student!=null?student:"",
         'state': state!=null?state:0,
         'id': id!=null?id:"",

         'timestamp': timestamp!=null?timestamp:Timestamp(0, 0),

      };
   }



/// get stream

/// get user doc stream


}







