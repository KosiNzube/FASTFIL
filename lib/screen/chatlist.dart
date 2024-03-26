import 'package:afrigas/auth/orderDatabase.dart';
import 'package:afrigas/card/orderCard.dart';
import 'package:afrigas/modelspx/Agents.dart';
import 'package:afrigas/modelspx/Order.dart';
import 'package:afrigas/screen/ChatScreenxxx.dart';
import 'package:afrigas/screen/liveTrack.dart';
import 'package:afrigas/screen/pickAgentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';




import '../../../constants.dart';


import 'package:flutter/foundation.dart' show kIsWeb;


import '../auth/database.dart';
import '../auth/messageDatabase.dart';
import '../card/msgCard.dart';
import '../components/custom_text.dart';
import '../mainx.dart';
import '../modelspx/Message.dart';
import '../modelspx/Quantity.dart';
import '../modelspx/hostels.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../style.dart';
import 'ChatScreen.dart';

class Chatlist extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar:AppBar(
          centerTitle: false,




          bottom: TabBar(
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontFamily: 'Quicksand'),
            tabs: [
              Tab(text:'Messages',),
              Tab(text:'Agents'),
            ],
          ),
          title: Text('Chats',),
        ),
        body:TabBarView(
          children: [
            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getMsgs, initialData: null),

                ],
                child: chatxxx()),


            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getAgents, initialData: null),
                  StreamProvider.value(
                      value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),

                ],
                child: chat()),
          ],
        ),

      ),
    );
  }
}





class faves_prov3 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Orderx>>(context);

    Size _size = MediaQuery
        .of(context)
        .size;
    return orders!=null?

    orders.length>0?

    SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,


            itemCount: orders.length,
            // On mobile this active dosen't mean anything
            itemBuilder: (context, index) => orderCard(
              orderx: orders[index]!,
              press: () {

                if(orders[index]!.state=="In Progress"){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:liveTrack(orderx: orders[index]),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );
                }

              },
            ),),
        ],
      ),
    ):Container(

      child: Center(
        child: SingleChildScrollView(
          physics: ScrollPhysics() ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                'assets/images/think.png',
                width: 350,
                height: Responsive.isMobile(context)?300:600,

              ),
              SizedBox(height: 20.0),

              Text(
                'No orders yet',
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
      ),
    ) :Center(child: CircularProgressIndicator());  }
}



class chatxxx extends StatefulWidget {

  @override
  State<chatxxx> createState() => _chatState();
}



class _chatState extends State<chatxxx> {
  late List<Message> uniquelist;

  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<List<Message>?>(context);
    if(brewx!=null) {
      var seen = Set<String>();
      uniquelist = brewx!.where((student) =>
          seen.add(student.agent)).toList();
    }
    return Scaffold(



      body: brewx!=null?

      uniquelist.length>-1?  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,


              itemCount: uniquelist.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) => msgCard(
                message: uniquelist[index],
                press: () {


                  PersistentNavBarNavigator.pushNewScreen(

                    context,
                    screen:ChatScreenxxx(message:uniquelist[index]),







                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );

                },
              ),
            ),
          ],
        ),
      ): Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon(CupertinoIcons.chat_bubble_2,size: 100,),
            SizedBox(height: 20.0),

            Text(
              'No messages',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.0),

          ],
        ),
      )  :Center(),
    );

  }
}


