
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../responsive.dart';

class Cart{
   String description;
   String name;

   String productId;
   String image;
   int numberofproducts;
   int total;
   int saleprice;

   int previousprice;

   Timestamp timestamp;

   Cart({
      required this.numberofproducts,
      required this.total,
      required this.productId,
      required this.saleprice,
      required this.previousprice,
      required this.name,

      required this.image,
      required this.description,
      required this.timestamp});
}


List<Cart> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      try{
      return Cart(
         description: doc.get('description') ,
         productId: doc.get('productId') ,
         saleprice: doc.get('saleprice')??0,
        // previousprice: doc.get('previousprice')??0,
         name: doc.data().toString().contains('name') ? doc.get('name') : '',
         previousprice: doc.data().toString().contains('previousprice') ? doc.get('previousprice') : 0,

         numberofproducts: doc.get('numberofproducts')??0,
         total: doc.get('total')??0,
         image: doc.get('image')??'',
         timestamp: doc.get('timestamp')??Timestamp(0, 0),


      );
      } catch (e) {
         print('Error mapping document: $e');
         return Cart(description: "description", productId: 'productId', saleprice: 0, name: "name", previousprice: 0,
             timestamp: Timestamp.now(), numberofproducts:0 , total: 0, image: 'image' ); // Return a default instance or handle the error as needed
      }
   }).toList();
}








Stream<List<Cart>> get getusercart{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("students").doc(firebaseAuth.currentUser!.uid).collection('cart').orderBy('timestamp',descending: true).snapshots().map(items);
}








