
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../responsive.dart';

class Product {
   String description;
   String mrp;
   String name;
   int previousprice;

   int saleprice;
   String image;
   bool curate;
   String id;
   Timestamp timestamp;

   Product({
      required this.description,
      required this.mrp,
      required this.saleprice,
      required this.image,
      required this.curate,
      required this.name,
      required this.previousprice,

      required this.id,
      required this.timestamp
   });

   Product.fromJson(Map<String, Object?> json)
       : this(
      description: json['description']! as String,
      mrp: json['mrp']! as String,
      image: json['image']! as String,
      name: json['name']! as String,
      previousprice: json['previousprice']! as int,

      saleprice: json['saleprice']! as int,
      id: json['id']! as String,
      curate: json['curate']! as bool,

      timestamp: json['timestamp']! as Timestamp,



   );

   Map<String, Object?> toJson() {
      return {
         'id': id!=null?id:"",
         'description': description!=null?description:"",
         'saleprice': saleprice!=null?saleprice:0,
         'image': image!=null?image:"",
         'timestamp': timestamp!=null?timestamp:Timestamp(0, 0),
         'mrp': mrp!=null?mrp:"",
         'curate': curate!=null?curate:"",
         'name': name!=null?name:"",
         'previousprice': previousprice!=null?previousprice:0,


      };
   }


}
List<Product> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Product(
         description: doc.get('description') ,
         mrp: doc.get('mrp'),
         saleprice: doc.get('saleprice'),
         curate: doc.get('curate'),
         name: doc.get('name'),
         previousprice: doc.get('previousprice'),

         image: doc.get('image'),
         id: doc.get('id'),
         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
   }).toList();
}




Stream<List<Product>> get getProducts{

   return FirebaseFirestore.instance.collection("Products").where('curate', isEqualTo: true).orderBy('timestamp',descending: true).limit(40).snapshots().map(items);
}

Stream<List<Product>> get getSpecials{

   FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   return FirebaseFirestore.instance.collection("SProducts").where('mrp', isEqualTo: firebaseAuth.currentUser!.uid).orderBy('timestamp',descending: true).limit(140).snapshots().map(items);
}




