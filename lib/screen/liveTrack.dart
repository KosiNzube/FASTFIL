import 'dart:math';

import 'package:afrigas/auth/agentDatabase.dart';
import 'package:afrigas/card/orderCard.dart';
import 'package:afrigas/modelspx/Order.dart';
import 'package:afrigas/screen/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import '../auth/orderDatabase.dart';
import '../card/agentCard.dart';
import '../components/custom_text.dart';
import '../components/style.dart';
import '../constants.dart';
import '../modelspx/Agents.dart';
import '../modelspx/student.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';
import 'ChatScreenxxx.dart';


class liveTrack extends StatefulWidget {
  liveTrack({
    Key? key, required this.orderx
  }) : super(key: key);

  final Orderx orderx;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<liveTrack> {
  bool y=false;




  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Live Track'),

      ),




      body:y==false? SingleChildScrollView(
        child: Column(

          children: [

            SizedBox(height: 10,),
            Image.asset(
              'assets/images/thesis.png',
              width: 350,
              height: Responsive.isMobile(context)?300:600,

            ),
            SizedBox(height: 10.0),

            Text(
              'Live tracker not yet available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 1,thickness: 1,),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomText(
                      text: "In Progress",
                      size: 20,
                    ),
                  ),

                  SizedBox(height: 3),


                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(

                      children: [
                        SizedBox(
                          width: Responsive.isDesktop(context)? 60:40,
                          height: Responsive.isDesktop(context)? 60:40,

                          child: Icon(Icons.agriculture_rounded),
                        ),
                        SizedBox(width: kDefaultPadding / 2),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [



                              Text(
                                  "Your order is on the way",textAlign: TextAlign.center,style:GoogleFonts.nunito(

                                  fontSize: Responsive.isDesktop(context)? 19:15.8,fontWeight: FontWeight.w600)

                              ),
                              SizedBox(height: 7),

                              Text(
                                widget.orderx.service=="Gas Refill"?  "Refilling of "+widget.orderx.kg+" Gas Cylinder":widget.orderx.kg,textAlign: TextAlign.center,style:GoogleFonts.nunito(
                                  fontSize: Responsive.isDesktop(context)? 19:15.8)

                              )
                            ],
                          ),
                        ),





                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm Delivery'),
                              content:Text('Confirm you recieved the delivery'),

                              actions: <Widget>[
                                MaterialButton(
                                  child: Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                MaterialButton(
                                  child: Text('CONFIRM'),
                                  onPressed: ()  {
                                    setState(() {
                                      y=true;
                                    });
                                    orderDatabase(uid: widget.orderx.id).updateOrder("Completed", true, Timestamp.now());
                                    agentDatabase(uid: widget.orderx.agentID).updateDeliveries();
                                    sendMessageToTopic(widget.orderx!.agentID, widget.orderx!.name, "Delivery confirmed. Thank you");
                                    sendMessageToTopic("ADMIN", widget.orderx!.name, "Delivery confirmed from agent: "+widget.orderx.agent);



                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(

                        decoration: BoxDecoration(color: active,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomText(
                          color: Colors.white,
                          text: "Confirm Delivery",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ):  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon(CupertinoIcons.checkmark_alt_circle,size: 100,),
            SizedBox(height: 20.0),

            Text(
              'Delivery Confirmed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }

}


List<AgentData> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return AgentData(
      name: doc.get('name') ,
      image: doc.get('image'),
      online: doc.get('online')??false,
      hostel: doc.get('hostel'),
      hostelID: doc.get('hostelID'),
      id: doc.get('id'),
      number: doc.get("name"),
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),
      disable: doc.get('disable')??false,
      active: doc.get('active')??false,
      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,
      state: doc.get('state'),


    );
  }).toList();
}