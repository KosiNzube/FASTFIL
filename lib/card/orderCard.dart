import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Agents.dart';
import 'package:afrigas/modelspx/student.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../modelspx/Order.dart';
import '../responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class orderCard extends StatelessWidget {
  const orderCard({
    required this.orderx,
    required this.press,
  });

  final Orderx orderx;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding/2, vertical: kDefaultPadding/2),
      child: InkWell(
        onTap: (){

          press();
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding/1.3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(

                    children: [
                      SizedBox(height: kDefaultPadding / 2),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                               orderx.agent.length>0? "AGENT: "+orderx.agent: orderx.service=="Gas Refill"? "Service: Gas Refill":"In Store Purchase",textAlign: TextAlign.left,style:GoogleFonts.nunito(

                                fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,color: Colors.deepOrange,)

                            ),
                            SizedBox(height: 7),

                            Text(
                               orderx.service=="Gas Refill"?"Quantity: "+orderx.kg+" Gas Cylinder":orderx.kg,textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                fontSize: Responsive.isDesktop(context)? 19:15.8),

                            ),
                            Text(
                              "Order date "+DateFormat('yyyy-MM-dd').format(orderx.timestamp.toDate()),textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                fontSize: Responsive.isDesktop(context)? 19:15.8),

                            ),

                            orderx.id.length>2? Text(
                              "Order ID: "+orderx.id,textAlign: TextAlign.left,style:GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                                fontSize: Responsive.isDesktop(context)? 19:17.8),

                            ):Container(),

                            Text(
                              "Delivery state: "+orderx.state,textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                fontSize: Responsive.isDesktop(context)? 19:15.8),

                            ),
                            SizedBox(height: kDefaultPadding/1.5 ),

                            orderx.state=="In Progress"?Text("Track Order >",textAlign: TextAlign.left,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 16),):
                            orderx.state=="Completed"?Text("Completed: "+DateFormat('yyyy-MM-dd').format(orderx.deliveryDate.toDate()) ,textAlign: TextAlign.left,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 16),)

                               :orderx.state=="Cancelled"?Text("Cancelled",textAlign: TextAlign.left,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 16),) :Container()

                          ],
                        ),
                      ),


                      SizedBox(height: kDefaultPadding / 2),



                    ],
                  ),

                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),

           orderx.state=="Checkout"? Positioned(right: 12, top: 12, child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
               shape: BoxShape.circle, color: Colors.deepPurple,
          ),
        ),): orderx.state=="In Progress"? Positioned(right: 12, top: 12, child: Container(
             height: 15,
             width: 15,
             decoration: BoxDecoration(
               shape: BoxShape.circle, color: Colors.deepOrange,
             ),
           ),): orderx.state=="Completed"? Positioned(right: 12, top: 12, child: Container(
             height: 15,
             width: 15,
             decoration: BoxDecoration(
               shape: BoxShape.circle, color: Colors.green,
             ),
           ),): orderx.state=="Cancelled"? Positioned(right: 12, top: 12, child: Container(
             height: 15,
             width: 15,
             decoration: BoxDecoration(
               shape: BoxShape.circle, color: Colors.red,
             ),
           ),):Container(),
            SizedBox(height: kDefaultPadding / 2),






          ],
        ),
      ),
    );
  }
}
