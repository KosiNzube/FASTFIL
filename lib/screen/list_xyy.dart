import 'package:afrigas/auth/orderDatabase.dart';
import 'package:afrigas/card/orderCard.dart';
import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Agents.dart';
import 'package:afrigas/modelspx/Order.dart';
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
import '../components/custom_text.dart';
import '../modelspx/Admin.dart';
import '../modelspx/Offcamp.dart';
import '../modelspx/Quantity.dart';
import '../modelspx/hostels.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../style.dart';

class List_xxy extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

   // final hostels = Provider.of<List<Hostel?>>(context);
    final student = Provider.of<StudentData?>(context);
    final quantities = Provider.of<List<Quantity?>>(context);

  //  final offcamps = Provider.of<List<Offcamp?>>(context);

    final admin = Provider.of<Admin>(context);



    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar:AppBar(
          centerTitle: false,




          bottom: TabBar(
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontFamily: 'Quicksand'),
            tabs: [
              Tab(text:'Place Order',),
              Tab(text:'Order History'),
            ],
          ),
          title: Text('Gas Refill',),
        ),
        body:TabBarView(
          children: [
            student!=null && admin!=null && quantities!=null ?    MultiProvider(
                providers: [

                  StreamProvider.value(
                      value: getHostels, initialData: null),

                  StreamProvider.value(
                      value: getOffcamps, initialData: null),

                ],
                child:             makeOrder( admin:admin, student:student!,quantities:quantities!)):Center(child: CircularProgressIndicator(strokeWidth: 1,)),







            MultiProvider(
                providers: [
                  StreamProvider.value(
                      value: getOrders, initialData: null),


                ],
                child: faves_prov3()),
          ],
        ),

      ),
    );
  }
}


class makeOrder extends StatefulWidget {
  final StudentData? student;
  final List<Quantity?> quantities;
  final Admin? admin;

  bool xyx=false;
  bool cyx=false;

  bool offc=false;
  String kg="KG";
  int price=0;
  String hostelname="Enter Hostel name";
  String hostelID="";
  TextEditingController fullname = new TextEditingController();
  TextEditingController phonenumber = new TextEditingController();
  TextEditingController blockno = new TextEditingController();
  TextEditingController roomno = new TextEditingController();

   makeOrder({required this.student, required this.quantities, required this.admin});

  @override
  State<makeOrder> createState() => _makeOrderState();
}

class _makeOrderState extends State<makeOrder> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
     final hostels = Provider.of<List<Hostel?>>(context);


      final offcamps = Provider.of<List<Offcamp?>>(context);



    if(widget.student!=null && hostels!=null && offcamps!=null && widget.admin!=null ) {
      setState(() {
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
    return widget.student!=null && hostels!=null&& offcamps!=null? SingleChildScrollView(
      physics: BouncingScrollPhysics(),


      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10,),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [

                  Container(
                    padding: EdgeInsets.all(kDefaultPadding/2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(

                      children: [
                        SizedBox(height: kDefaultPadding / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: kDefaultPadding / 2),



                            Expanded(

                              child: Text.rich(


                                TextSpan(
                                  text:
                                 "Gas per KG: "+ widget.admin!.perKG+  "\n",
                                  style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)?19: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  children: [

                                    TextSpan(
                                      text: "Both pick up and delivery: "+widget.admin!.deliveryFee+  "\n",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)?20: 16.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.brown,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.admin!.disclaimer,
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)?20: 16.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                      ],
                    ),
                  ).addNeumorphism(
                    blurRadius: mode.brightness==Brightness.dark?0: 15,
                    borderRadius: mode.brightness==Brightness.dark?9: 15,
                    offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                  ),
                ],
              ),
            ),

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

            SizedBox(height: 4.0),


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
                  text: "Quantity in KG",
                  size: 20,
                ),

                Icon(Icons.local_gas_station_rounded),

              ],
            ),
            SizedBox(height: 19.0),

            InkWell(
              onTap: (){
                showAlertDialogyyy(context);
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
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            SizedBox(width: kDefaultPadding / 2),
                            Expanded(child: Text(widget.kg),
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
                  text: "Hostel name",
                  size: 20,
                ),

                Icon(Icons.home_filled),

              ],
            ),
            SizedBox(height: 19.0),

            InkWell(
              onTap: (){
                print(hostels.toString());
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return hostels!=null? ListView.builder(

                      itemCount: hostels!.length,
                      // On mobile this active dosen't mean anything
                      itemBuilder: (context, index) {
                        return AlertDialog(
                            content: InkWell(
                              onTap: (){
                                widget.hostelname=hostels[index]!.name;

                                setState(() {
                                  widget.offc=false;

                                  widget.xyx=true;
                                  widget.hostelname=hostels[index]!.name;
                                  widget.hostelID=hostels[index]!.id;
                                });
                                print(hostels[index]!.name);
                                Navigator.of(context).pop();
                              },
                              child: Text(hostels[index]!.name),
                            )
                        );



                      },
                    ):Container();
                  },
                );


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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return offcamps!=null? ListView.builder(

                      itemCount: offcamps!.length,
                      // On mobile this active dosen't mean anything
                      itemBuilder: (context, index) {
                        return AlertDialog(
                            content: InkWell(
                              onTap: (){
                                widget.hostelname=offcamps[index]!.name;

                                setState(() {
                                  widget.offc=true;



                                  widget.xyx=true;
                                  widget.hostelname=offcamps[index]!.name;
                                  widget.hostelID=offcamps[index]!.id;
                                });
                                print(offcamps[index]!.name);
                                Navigator.of(context).pop();
                              },
                              child: Text(offcamps[index]!.name),
                            )
                        );



                      },
                    ):Container();
                  },
                );


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
                  text: "Block no. or lodge address",
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
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: "Enter Block no. or lodge address ",
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
                               widget.phonenumber.text, widget.blockno.text,widget.roomno.text.toString());

                            Orderx coux = Orderx(
                                userID: widget.student!.id,
                                name: widget.fullname.text,
                                hostelname: widget.hostelname,
                                price: widget.price,
                                blockNO:  widget.blockno.text,
                                roomNO:  widget.roomno.text,
                                stateBool: false,
                                kg: widget.kg,
                                userphone: widget.phonenumber.text,
                                hostelID: widget.hostelID,
                                agentID: "",
                                service: "Gas Refill",

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
                              " Select the name of your hostel or lodge area "),

                        ));
                  }
                } else if(widget.roomno.text.length>0) {
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
    ):Center(child: CircularProgressIndicator(strokeWidth: 1,));
  }

  showAlertDialog(BuildContext context) {

    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('3KG'),
      onPressed: () {
        setState(() {
          widget.kg="3KG";
        });
        print('3KG');
       // Navigator.of(context).pop();
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text('6KG'),
      onPressed: () {
        setState(() {
          widget.kg="6KG";
        });

      },
    );
    Widget optionThree = SimpleDialogOption(
      child: const Text('12.5KG'),
      onPressed: () {
        setState(() {
          widget.kg="12.5KG";
        });     //   Navigator.of(context).pop();
      },
    );
    Widget optionFour = SimpleDialogOption(
      child: const Text('25KG'),
      onPressed: () {
        setState(() {
          widget.kg="25KG";
        });      //  Navigator.of(context).pop();
      },
    );
    Widget optionFive = SimpleDialogOption(
      child: const Text('50KG'),
      onPressed: () {
        setState(() {
          widget.kg="50KG";
        });      //  Navigator.of(context).pop();
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Quantity in KG'),
      children: <Widget>[
        optionOne,
        optionTwo,
        optionThree,
        optionFour,
        optionFive,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }






  showAlertDialogyyy(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget.quantities!=null? ListView.builder(

          itemCount: widget.quantities!.length,
          // On mobile this active dosen't mean anything
          itemBuilder: (context, index) {
            return AlertDialog(
                content: InkWell(
                  onTap: (){

                    setState(() {

                      widget.kg=widget.quantities[index]!.name;

                      widget.price=widget.quantities[index]!.price;
                    });
                    print(widget.quantities[index]!.name);
                    Navigator.of(context).pop();
                  },
                  child: Text(widget.quantities[index]!.name),
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






