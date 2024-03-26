import 'package:afrigas/auth/cartDatabase.dart';
import 'package:afrigas/auth/userCart.dart';
import 'package:afrigas/modelspx/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';
import '../modelspx/Cart.dart';
import '../modelspx/student.dart';
import 'cartCard.dart';

class usercartCart extends StatelessWidget {
  const usercartCart({
    Key? key,
    required this.press,
    required this.student,

    required this.cart,
  }) : super(key: key);

  final Cart cart;
  final VoidCallback press;
  final StudentData student;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    int xxx=cart.saleprice*cart.numberofproducts;

    return InkWell(
      onTap: (){
        _displayTextInputDialog(context, cart.description);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Image.network(cart.image),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              cart.name.length<1?  Text(
            cart.description.length>35?cart.description.substring(0,35)+'...':cart.description,
                  style: GoogleFonts.raleway( fontSize: 16),
                  maxLines: 2,
                ):Text(
                cart.name.length>35?cart.name.substring(0,35)+'...':cart.name,
                style: GoogleFonts.raleway( fontSize: 16),
                maxLines: 2,
              ),
                SizedBox(height: 5),


                Text(formatAmountWithNairaSign(cart.saleprice)+" (Sum: "+ formatAmountWithNairaSign(xxx)+")", style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.deepOrange,fontSize: 16),),
                SizedBox(height: 5),

                Row(
                  children: [
                    IconButton(onPressed: (){

                      if(cart.numberofproducts>0){
                        cartDatabase(uid: student.id,productid: cart.productId).removefromcart();
                      }
                      if(cart.numberofproducts==1){
                        cartDatabase(uid: student.id,productid: cart.productId).deletefromcart();
                      }


                    },icon: Icon(Icons.remove),),
                    SizedBox(width: 5),

                    Text(cart.numberofproducts.toString()),
                    SizedBox(width: 5),

                    IconButton(onPressed: (){
                      cartDatabase(uid: student.id,productid: cart.productId).addtocart();

                    },icon: Icon(Icons.add),),

                  ],
                ),



              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _displayTextInputDialog(BuildContext context, String name) async {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: SelectableText(
                            name,
                            style:  TextStyle(fontSize: 16),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
