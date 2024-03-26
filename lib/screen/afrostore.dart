import 'dart:convert';

import 'package:afrigas/auth/orderDatabase.dart';
import 'package:afrigas/card/orderCard.dart';
import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Agents.dart';
import 'package:afrigas/modelspx/Offcamp.dart';
import 'package:afrigas/modelspx/Order.dart';
import 'package:afrigas/modelspx/catrogory.dart';
import 'package:afrigas/screen/ChatScreenxxx.dart';
import 'package:afrigas/screen/liveTrack.dart';
import 'package:afrigas/screen/pickAgentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';




import '../../../constants.dart';


import 'package:flutter/foundation.dart' show kIsWeb;


import '../auth/database.dart';
import '../card/cartCard.dart';
import '../comp2/DarkThemeProvider.dart';
import '../components/custom_text.dart';
import '../mainx.dart';
import '../modelspx/Cart.dart';
import '../modelspx/Product.dart';
import '../modelspx/Quantity.dart';
import '../modelspx/hostels.dart';
import '../modelspx/requests.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../style.dart';
import 'ChatScreen.dart';
import 'Lily.dart';

class Afrostore extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   // final allS = Provider.of<List<StudentData?>>(context);

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar:AppBar(
          centerTitle: false,

          actions: [


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(onPressed: (){


                /*
                if(allS!=null) {
                  for (int i = 0; i < allS!.length; i++) {
                    DataBaseService(uid: allS[i]!.id, email: allS[i]!.email)
                        .updateALLLSC();
                  }
                }

                 */

                /*
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Lily(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );


                 */



                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Lily(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );


              }, icon: Icon(Icons.search)),
            ),

            SizedBox(width: 5,),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(onPressed: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:MultiProvider(
                      providers: [
                        StreamProvider.value(
                            value: getSpecials, initialData: null),
                        StreamProvider.value(
                            value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),

                      ],
                      child: accolumnyyy()),


                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );


              }, icon: Icon(Icons.star_border_rounded)),
            )

          ],


          bottom: TabBar(
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontFamily: 'Quicksand'),
            tabs: [
              Tab(text:'Market',),
              Tab(text:'Cart',),

              Tab(text:'Order History'),
            ],
          ),
          title:  TimeOfDayWidget(),
        ),
        body:TabBarView(
          children: [
            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getProducts, initialData: null),
                  StreamProvider.value(
                      value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),
                  StreamProvider.value(
                      value: getCategories, initialData: null),
                ],
                child: products()),
            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getusercart, initialData: null),

                  StreamProvider.value(
                      value: getHostels, initialData: null),


                  StreamProvider.value(
                      value: getOffcamps, initialData: null),


                  StreamProvider.value(
                      value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),

                ],
                child: usercat()),
            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getOrderstore, initialData: null),


                ],
                child: faves_prov3())
          ],
        ),

      ),
    );
  }
}


class makeOrderGas extends StatefulWidget {
  final List<Hostel?> hostels;
  final List<Offcamp?> offcamps;

  final StudentData? student;
  final String? des;
  final double? price;

  bool xyx=false;
  bool cyx=false;

  String kg="";
  int xxx=0;
  String hostelname="Enter Hostel name";
  String hostelID="";
  bool offc=false;
  TextEditingController fullname = new TextEditingController();

  TextEditingController phonenumber = new TextEditingController();
  TextEditingController blockno = new TextEditingController();
  TextEditingController roomno = new TextEditingController();

  makeOrderGas({ required this.hostels,required this.student, required this.des, required this. price, required this. offcamps});

  @override
  State<makeOrderGas> createState() => _makeOrderState();
}

class _makeOrderState extends State<makeOrderGas> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if(widget.student!=null && widget.hostels!=null&& widget.offcamps!=null) {
      setState(() {

        widget.kg=widget.des!;

        if (widget.student!.name.length > 1) {
          widget.fullname.text = widget.student!.name;
        }
        if (widget.student!.phone.length > 1) {
          widget.phonenumber.text = widget.student!.phone;
        }


        if (widget.student!.roomnumber.length > 0) {
          widget.roomno.text = widget.student!.roomnumber.toString();
        }
        if (widget.student!.blocknumber.length >0) {
          widget.blockno.text = widget.student!.blocknumber.toString();
        }
      });
    }
    return Scaffold(

      appBar:AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Delivery Location"),
        ),

// like this!
      ),



      body: widget.student!=null && widget.hostels!=null&& widget.offcamps!=null? SingleChildScrollView(
        physics: BouncingScrollPhysics(),


        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Full name",
                    size: 20,
                  ),

                  Icon(Icons.person),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.fullname,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter full name ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Phone number",
                    size: 20,
                  ),

                  Icon(Icons.phone),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.phonenumber,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,

                  decoration: InputDecoration(
                      labelText: "Enter Phone number ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Room number",
                    size: 20,
                  ),

                  Icon(Icons.room_outlined),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.roomno,
                  keyboardType: TextInputType.number,

                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Room number ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),

              SizedBox(height: 4.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Purchasing...",
                    size: 20,
                  ),

                  Icon(Icons.shopping_cart),

                ],
              ),
              SizedBox(height: 19.0),

              InkWell(
                onTap: (){
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    border: Border.all(),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                  Container(

          child: Column(

            children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: kDefaultPadding / 2),



                      Expanded(

                        child: Text(widget.des!),
                      ),

                    ],
                  ),
            ],
          ),

        ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 19.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Hostel name",
                    size: 20,
                  ),

                  Icon(Icons.home_filled),

                ],
              ),
              SizedBox(height: 19.0),

              InkWell(
                onTap: (){
                  showAlertDialogxxx(context);


                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    border: Border.all(),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Container(

                        child: Column(

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: kDefaultPadding / 2),



                                Expanded(

                                  child: Text(widget.offc==false?   widget.hostelname:"---"),
                                ),

                              ],
                            ),
                          ],
                        ),

                      ),
                      Positioned.fill(

                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Icon( CupertinoIcons.chevron_up_chevron_down),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

              SizedBox(height: 19.0),










              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "You stay Off campus?",
                    size: 20,
                  ),

                  Icon(Icons.home_work_outlined),

                ],
              ),
              SizedBox(height: 19.0),

              InkWell(
                onTap: (){
                  showAlertOffcamp(context);


                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    border: Border.all(),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Container(

                        child: Column(

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: kDefaultPadding / 2),



                                Expanded(

                                  child: Text(widget.offc==true?   widget.hostelname:"---"),
                                ),

                              ],
                            ),
                          ],
                        ),

                      ),
                      Positioned.fill(

                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Icon( CupertinoIcons.chevron_up_chevron_down),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

              SizedBox(height: 19.0),




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Block no. or lodge Address",
                    size: 20,
                  ),

                  Icon(Icons.account_balance_outlined),

                ],
              ),
              Container(

                padding: EdgeInsets.symmetric(vertical: 20.0,),
                child:TextFormField(
                  controller: widget.blockno,

                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'cant be null';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Block no. or lodge address ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 19.0),














              InkWell(
                onTap: ()   {




                  if (widget.offc==true || widget.cyx==true) {
                    if (widget.xyx==true) {
                      if (widget.blockno.text.length>1) {
                        if (widget.phonenumber.text.length>1) {
                          if (widget.fullname.text.length>1) {
                            if (widget.kg.length>2) {

                               DataBaseService(uid: _auth.currentUser?.uid, email:_auth.currentUser?.email).updateUserData(widget.fullname.text,
                                 widget.phonenumber.text, widget.blockno.text,widget.roomno.text.toString(),);

                              Orderx coux = Orderx(
                                  userID: widget.student!.id,
                                  name: widget.fullname.text,
                                  hostelname: widget.hostelname,
                                  price: widget.price!.toInt(),
                                  blockNO: widget.blockno.text,
                                  roomNO:  widget.roomno.text,
                                  stateBool: false,
                                  kg: widget.kg,

                                  userphone: widget.phonenumber.text,
                                  hostelID: widget.hostelID,
                                  agentID: "",
                                  service: "In Store Purchase",

                                  state: "Pick Agent",
                                  agent: "",
                                  id: "",
                                  deliveryDate: Timestamp.fromDate(DateTime.now()),
                                  timestamp: Timestamp.fromDate(DateTime.now()));

                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen:MultiProvider(
                                    providers: [
                                      StreamProvider.value(
                                          value: getActiveAgents, initialData: null),


                                    ],
                                    child:pickAgentScreen(orderx: coux,student: widget.student!),
                                ),







                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation
                                    .cupertino,
                              );




                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        " Enter the Quantity "),

                                  ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      " Enter your name "),

                                ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    " Enter phone number "),

                              ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  " Enter block number or lodge address "),

                            ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                " Whats the name of your hostel "),

                          ));
                    }
                  } else if( widget.roomno.text.length>0) {
                    setState(() {
                      widget.cyx=true;
                    });
                  }else{
                    setState(() {
                      widget.cyx=false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              " Whats your room number  "),

                        ));
                  }


                },
                child: Container(

                  decoration: BoxDecoration(color: active,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    color: Colors.white,
                    text: "Pick a specific agent(Active)",
                  ),
                ),
              ),

              SizedBox(height: 19.0),


            ],
          ),
        ),
      ):CircularProgressIndicator(),
    );
  }


  showAlertDialogxxx(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget.hostels!=null? ListView.builder(

          itemCount: widget.hostels!.length,
          // On mobile this active dosen't mean anything
          itemBuilder: (context, index) {
            return AlertDialog(
              content: InkWell(
                onTap: (){
                  widget.hostelname=widget.hostels[index]!.name;

                  setState(() {
                    widget.offc=false;
                    widget.xyx=true;
                    widget.hostelname=widget.hostels[index]!.name;
                    widget.hostelID=widget.hostels[index]!.id;
                  });
                  print(widget.hostels[index]!.name);
                  Navigator.of(context).pop();
                },
                child: Text(widget.hostels[index]!.name),
              )
            );



          },
        ):Container();
      },
    );
  }
  showAlertOffcamp(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget.offcamps!=null? ListView.builder(

          itemCount: widget.offcamps!.length,
          // On mobile this active dosen't mean anything
          itemBuilder: (context, index) {
            return AlertDialog(
                content: InkWell(
                  onTap: (){
                    widget.hostelname=widget.offcamps[index]!.name;

                    setState(() {
                      widget.offc=true;
                      widget.xyx=true;
                      widget.hostelname=widget.offcamps[index]!.name;
                      widget.hostelID=widget.offcamps[index]!.id;
                    });
                    print(widget.offcamps[index]!.name);
                    Navigator.of(context).pop();
                  },
                  child: Text(widget.offcamps[index]!.name),
                )
            );



          },
        ):Container();
      },
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


class accolumnyyy extends StatefulWidget {

  @override
  State<accolumnyyy> createState() => _accolumnState();
}

class _accolumnState extends State<accolumnyyy> {

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);

    final themeChange = Provider.of<DarkThemeProvider>(context);
    final ThemeData mode=Theme.of(context);
    TextEditingController name = new TextEditingController();
    bool correctpass=false;
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    final student = Provider.of<StudentData>(context);


   return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar:AppBar(
          centerTitle: false,



          bottom: TabBar(
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontFamily: 'Quicksand'),
            tabs: [
              Tab(text:'Request',),
              Tab(text:'History',),

            ],
          ),
          title:  Text('Specials'),
        ),
        body:TabBarView(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),

              child: Padding(
                padding: const EdgeInsets.only(left: 0.0,right: 0,top: 15),
                child: Column(
                  children: [



                    SizedBox(height: kDefaultPadding),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("MAKE A GROCERY REQUEST",style: GoogleFonts.raleway(fontSize: 28,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    ),

                    SizedBox(height: kDefaultPadding),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: name,


                        decoration: InputDecoration(

                            labelText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero)),
                        maxLines: 4,

                      ),
                    ),

                    SizedBox(height: kDefaultPadding),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          if (name.text.length > 0) {

                            SmartDialog.showLoading(msg:"Just a moment...");

                            await FirebaseFirestore.instance
                                .collection('Requests').
                            add({
                              'content': name.text, // John Doe
                              'student': firebaseAuth.currentUser!.uid, // Stokes and Sons
                              'state': 0,
                              'id':'',
                              'timestamp': Timestamp.now() // 42
                            }).then((value) async {
                              FirebaseFirestore.instance
                                  .collection('Requests').doc(value.id).update({'id':value.id});


                            });

                            sendMessageToTopic("ADMIN", "New request", name.text);


                            SmartDialog.dismiss();


                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please type in the request"),

                                ));
                          }


                        },
                        child: Container(
                          decoration: BoxDecoration(color: active,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CustomText(
                            text: "Submit",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding/2),


                    student!=null && products!=null && products.length>0? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/1.5),
                      child:  CustomText2(
                        text: "AVAILABLE REQUESTS",
                        size: 20,
                      ),
                    ):Container(),


                    student!=null && products!=null?  Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: GridView.builder(

                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 240,
                        ),
                        primary: false,
                        itemCount: products.length,
                        itemBuilder: (context, index) => ProductCard(
                          cart: products[index],
                          press: () {

                          }, student: student,
                        ),
                      ),
                    ):CircularProgressIndicator(strokeWidth: .9,),

                    SizedBox(height: 30.0),

                  ],
                ),
              ),
            ),
            NewWidget(),

          ],
        ),

      ),
    );
  }
}

class NewWidget extends StatefulWidget {


  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  late Query<Requestx> usersQuery;


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersQuery = FirebaseFirestore.instance.collection("Requests")
        .where('student',isEqualTo: firebaseAuth.currentUser!.uid)
        .withConverter<Requestx>(
      fromFirestore: (snapshot, _) => Requestx.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

  }


  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);


    return FirestoreListView<Requestx>(
      physics: BouncingScrollPhysics(),


      query: usersQuery,
      itemBuilder: (context, snapshot) {
        // Data is now typed!
        Requestx user = snapshot.data();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding/1.3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
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
                               user.content,textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                  fontSize: Responsive.isDesktop(context)? 19:17.8),

                              ),

                              Text(
                               user.state==0?"This request is currently under review": user.state==1?"This request is currently available": "This request was voided",textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                color: Colors.pink,
                                  fontSize: Responsive.isDesktop(context)? 19:17.8),

                              ),

                              Text(
                                DateFormat('yyyy-MM-dd').format(user.timestamp.toDate()),textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                  fontSize: Responsive.isDesktop(context)? 19:14.8),

                              ),



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

              user.state==0? Positioned(right: 12, top: 12, child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple,
                ),
              ),): user.state==1? Positioned(right: 12, top: 12, child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue,
                ),
              ),):Container(),






            ],
          ),
        );
      },
    );
  }
}


class detailCard extends StatelessWidget {
  detailCard({
    required this.cart,

  });

  final Product cart;


  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding/2, vertical: kDefaultPadding/2),
      child: Column(
        children: [
          InkWell(
            onTap: (){

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
                                    cart.name,textAlign: TextAlign.left,style:GoogleFonts.raleway(

                                  fontSize: Responsive.isDesktop(context)? 19:16.8,fontWeight: FontWeight.bold,color: Colors.deepOrange,)

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

                                SizedBox(height: 7),

                                Text(
                                  cart.description,textAlign: TextAlign.left,style:GoogleFonts.raleway(
                                    fontSize: Responsive.isDesktop(context)? 19:15.8),

                                ),

                              ],
                            ),
                          ),


                          SizedBox(height: kDefaultPadding),



                        ],
                      ),

                    ],
                  ),
                ).addNeumorphism(
                  blurRadius: mode.brightness==Brightness.dark?0: 15,
                  borderRadius: mode.brightness==Brightness.dark?9: 15,
                  offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                ),

                Positioned(right: 12, top: 12, child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple,
                  ),
                ),),
                SizedBox(height: kDefaultPadding / 2),






              ],
            ),
          ),

          SizedBox(height: 15,),

          InkWell(
            onTap: ()   {

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
            child: Container(

              decoration: BoxDecoration(color: active,
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CustomText(
                color: Colors.white,
                text: "ADD TO CART",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
