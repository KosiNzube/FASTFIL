import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../modelspx/student.dart';
import 'package:get/get.dart';
import '../responsive.dart';
import '../screen/ChatScreen.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../screen/afrostore.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.press,
    required this.student,

    required this.cart,
  }) : super(key: key);

  final Product cart;
  final VoidCallback press;
  final StudentData student;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    Size _size = MediaQuery
        .of(context)
        .size;
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: (){
          showModalBottomSheet(
              context: context,
              builder: (context2) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 17,),


                      detailCard(cart: cart),


                      SizedBox(height: 40)

                    ],
                  ),
                );
              });

        },
        child: Stack(
          children: [
            Positioned(

              right: 11,
              bottom: 11,
              child: InkWell(
                onTap: (){
                  FirebaseFirestore.instance
                      .collection('students')
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection('cart').doc(cart.id).set({
                    'numberofproducts': 1, // John Doe
                    'image': cart.image, // Stokes and Sons
                    'description': cart.description,
                    'saleprice': cart.saleprice,
                    'name': cart.name,

                    'previousprice':cart.previousprice,
                    'total': 1,
                    'productId': cart.id,

                    'timestamp': Timestamp.now() // 42
                  });

                  snack(cart.name+" has been added to your cart",context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 18,
                  child: const Icon(Icons.add_rounded,color: Colors.white,),
                ).animate().fade(duration: 200.ms),
              ),
            ),
            Positioned(
              top: 22,
              left: 26,
              right: 25,
              child: Image.network(cart.image,width: 100,height: 100,).animate().slideX(
                duration: 200.ms,
                begin: 1, curve: Curves.easeInSine,
              ),
            ),
            Positioned(
              left: 16,
              right: 16,

              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cart.name.length>30?cart.name.substring(0,30)+'...':cart.name,
                    style: GoogleFonts.raleway(fontSize: 14,fontWeight: FontWeight.w500),)
                      .animate().fade().slideY(
                    duration: 200.ms,

                    begin: 1, curve: Curves.easeInSine,
                  ),



                  SizedBox(height: 5,),
                  Text(
                    formatAmountWithNairaSign(cart.saleprice),
                    style: TextStyle(  color: Colors.green,fontSize: 15,fontWeight: FontWeight.w700),
                  ).animate().fade().slideY(
                    duration: 200.ms,
                    begin: 2, curve: Curves.easeInSine,
                  ),
                  cart.previousprice>0 ? SizedBox(height: 3):Container(),

                  cart.previousprice>0 ?Text(formatAmountWithNairaSign(cart.previousprice), style: TextStyle(

                      decoration: TextDecoration.lineThrough,

                      color: Colors.blueGrey,fontSize: 12.5),):Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    ).addNeumorphism(
      blurRadius: mode.brightness==Brightness.dark?0: 15,
      borderRadius: mode.brightness==Brightness.dark?9: 15,
      offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
    );
  }
}
String formatAmountWithNairaSign(int amount) {
  final currencyFormat = NumberFormat.currency(symbol: '₦');
  return currencyFormat.format(amount.toInt()).replaceAll(".00", "");
}
String formatAmountWithNairaSignxxx(double amount) {
  final currencyFormat = NumberFormat.currency(symbol: '₦');
  return currencyFormat.format(amount.toInt()).replaceAll(".00", "");
}




class ProductCardx extends StatelessWidget {
  const ProductCardx({
    Key? key,
    required this.press,
    required this.student,

    required this.cart,
  }) : super(key: key);

  final Product cart;
  final VoidCallback press;
  final StudentData student;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return InkWell(
      onTap: (){
        showModalBottomSheet(
            context: context,
            builder: (context2) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 17,),


                    detailCard(cart: cart,),


                    SizedBox(height: 90)

                  ],
                ),
              );
            });
        },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Image.network(cart.image),
                  ),
                ),

                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.name.length>35?cart.name.substring(0,35)+'...':cart.name,
                      style: TextStyle( fontSize: 16),
                    ),

                    SizedBox(height: 5),


                    Text(formatAmountWithNairaSign(cart.saleprice), style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.deepOrange,fontSize: 16),),
                    cart.previousprice>0 ? SizedBox(height: 3):Container(),

                    cart.previousprice>0 ?Text(formatAmountWithNairaSign(cart.previousprice), style: TextStyle(

                        decoration: TextDecoration.lineThrough,

                        color: Colors.blueGrey,fontSize: 12.5),):Container(),
                    SizedBox(height: 5),

                    SizedBox(
                      height: 33,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          primary: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance
                              .collection('students')
                              .doc(firebaseAuth.currentUser!.uid)
                              .collection('cart').doc(cart.id).set({
                            'numberofproducts': 1, // John Doe
                            'image': cart.image, // Stokes and Sons
                            'description': cart.description,
                            'saleprice': cart.saleprice,
                            'total': 1,
                            'productId': cart.id,
                            'name': cart.name,
                            'previousprice': cart.previousprice,

                            'timestamp': Timestamp.now() // 42
                          });

                          snack(cart.description+" added",context);

                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0,0,12,0),
                          child: Text(
                            "Add to Cart",
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
              ],
            ),
            Icon(CupertinoIcons.cart)
          ],
        ),
      ),
    );
  }
}

