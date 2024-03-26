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


class Notificationxx extends StatefulWidget {



  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Notificationxx> {
  bool y=false;




  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Notifications'),

      ),




      body:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),

              Icon(CupertinoIcons.bell_slash,size: 100,),
              SizedBox(height: 20.0),

              Text(
                'No notifications yet',
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
      )
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
      state: doc.get('state'),
      number: doc.get("name"),
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),
      disable: doc.get('disable')??false,
      active: doc.get('active')??false,
      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,


    );
  }).toList();
}