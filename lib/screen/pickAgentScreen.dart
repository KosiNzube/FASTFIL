import 'dart:convert';
import 'dart:math';

import 'package:afrigas/card/orderCard.dart';
import 'package:afrigas/mainx.dart';
import 'package:afrigas/modelspx/Order.dart';
import 'package:afrigas/screen/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../auth/auth.dart';
import '../auth/orderDatabase.dart';
import '../card/agentCard.dart';
import '../card/cartCard.dart';
import '../modelspx/Agents.dart';
import '../modelspx/student.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';
import 'ChatScreen.dart';
import 'ChatScreenxxx.dart';
import 'liveTrack.dart';


String generateRef() {
  final randomCode = Random().nextInt(3234234);
  return 'ref-$randomCode';
}
class pickAgentScreen extends StatefulWidget {
  pickAgentScreen({
    Key? key, required this.orderx,required this.student
  }) : super(key: key);

  final Orderx orderx;
  final StudentData student;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<pickAgentScreen> {



  @override
  Widget build(BuildContext context) {
    Stream<List<AgentData>> xx=FirebaseFirestore.instance.collection("Agents").where('hostelID',isEqualTo: widget.orderx.hostelID).where("active",isEqualTo: true).where("disable",isEqualTo: false).limit(20).snapshots().map(items);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Pick a specific agent'),

      ),


      body:

      StreamProvider.value(
        value: xx,initialData: null,
        child: NewWidgetcom(student:widget.student,orderx:widget.orderx),),
    );
  }

}
class NewWidgetcom extends StatefulWidget {
  final StudentData student;
  final Orderx orderx;

  const NewWidgetcom({super.key, required this.student, required this.orderx});

  @override
  State<NewWidgetcom> createState() => _NewWidgetcomState();
}

class _NewWidgetcomState extends State<NewWidgetcom> {

  String x="";
  var publicKey = 'pk_live_0176f37a4197df7ae83c902f8e670e6f1add610c';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
  }
  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<List<AgentData>>(context);
    FirebaseAuth _auth = FirebaseAuth.instance;
    Orderx coux = Orderx(
        userID: widget.orderx.userID,
        name: "Service: "+widget.orderx.service,
        hostelname: widget.orderx.hostelname,
        price: widget.orderx.price,
        blockNO: widget.orderx.blockNO,
        userphone: widget.orderx.userphone,

        service: widget.orderx.service,
        roomNO: widget.orderx.roomNO,
        stateBool: widget.orderx.stateBool,
        kg: widget.orderx.kg,
        hostelID: widget.orderx.hostelID,
        state: "Checkout",
        agent: x,
        agentID: "",

        id: widget.orderx.id,
        deliveryDate: Timestamp.fromDate(DateTime.now()),
        timestamp: Timestamp.fromDate(DateTime.now()));

    if(brewx!=null) {
      return brewx.length>0? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,


              itemCount: brewx.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) => agentCard(
                email: brewx[index]!,
                student:widget.student,
                press: () {
                  setState(() {
                    x=brewx[index].name;
                  });
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 10,),


                              orderCard(orderx: coux, press: (){}),

                              SizedBox(height: 10,),

                              ListTile(
                                leading: new Icon(CupertinoIcons.money_yen_circle),
                                title: new Text('Make Payment '+"("+formatAmountWithNairaSign(widget.orderx.price)+")"),
                                onTap: () async {



                                  if(kIsWeb){


                                    /*

                                    final ref = generateRef();
                                    final amount = widget.orderx.price ;


                                    await PaystackPopup.openPaystackPopup(
                                      email: _auth.currentUser!.email.toString(),
                                      amount: (amount * 100).toString(),
                                      ref: ref,
                                      onClosed: () {
                                        debugPrint('Could\'nt finish payment');
                                      },
                                      onSuccess: () async {


                                        Orderx coux = Orderx(
                                            userID: widget.student.id,
                                            name: widget.orderx.name,
                                            hostelname: widget.orderx.hostelname,
                                            price: widget.orderx.price,
                                            blockNO: widget.orderx.blockNO,
                                            roomNO: widget.orderx.roomNO,
                                            userphone: widget.orderx.userphone,

                                            service: widget.orderx.service,
                                            stateBool: widget.orderx.stateBool,
                                            kg: widget.orderx.kg,
                                            hostelID: widget.orderx.hostelID,
                                            state: "In Progress",
                                            agent: brewx[index].name,
                                            agentID: brewx[index].id,

                                            id: widget.orderx.id,
                                            deliveryDate: Timestamp.fromDate(DateTime.now()),
                                            timestamp: Timestamp.fromDate(DateTime.now()));

                                       await orderDatabase(uid:widget.orderx.userID).addOrder(coux).whenComplete(() {


                                        });

                                        Navigator.popUntil(
                                            context, ModalRoute.withName(Navigator.defaultRouteName));


                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("Payment Successful. Your order is on its way to you"),

                                        ));

                                        debugPrint('successful payment');
                                      },
                                    );

                                     */

                                  }else{

                                    final ref = generateRef();
                                    final amount = widget.orderx.price;

                                    _showPaystack(ref,amount,_auth.currentUser!.email.toString(),context,_auth,brewx[index]);

                                    /*
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(height: 15,),

                                              Text("Choose Payment method",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: Responsive.isDesktop(context)? 24.9:21.4,
                                                      letterSpacing: Responsive.isMobile(context)? 2.1:2.8,
                                                      fontWeight: FontWeight.bold)),


                                              SizedBox(height: 15,),
                                              ListTile(
                                                leading: new Icon(CupertinoIcons.creditcard),
                                                title: new Text('Pay with Card'),
                                                onTap: () {

                                                  _processPayment(ref,amount,_auth.currentUser!.email.toString(),context,_auth,brewx[index]);


                                                },
                                              ),

                                              ListTile(
                                                leading: new Icon(CupertinoIcons.money_yen_circle),
                                                title: new Text('Pay with Transfer, USSD & more'),
                                                onTap: () async {

                                                  _showPaystack(ref,amount,_auth.currentUser!.email.toString(),context,_auth,brewx[index]);




                                                },
                                              ),
                                              SizedBox(height: 5,),

                                              SizedBox(height: 10,),

                                            ],
                                          );
                                        });

                                     */




                                  }


                                },
                              ),
                              SizedBox(height: 5,),

                              ListTile(
                                leading: new Icon(CupertinoIcons.chat_bubble_text),
                                title: new Text('Chat Agent'),
                                onTap: () {

                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen:ChatScreen(agent:brewx[index]! ,student: widget.student,),







                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation
                                        .cupertino,
                                  );

                                },
                              ),
                              SizedBox(height: 10,),

                            ],
                          ),
                        );
                      });            },
              ),),
          ],
        ),
      ):Center(
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
                'Sorry. There is currently no active agent in this location ',
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
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _processPayment(String ref, int amount, String email,BuildContext context, FirebaseAuth auth, AgentData brewx) async {
    Charge charge = Charge()
      ..amount = amount*100
      ..reference = ref
    // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = email;
    CheckoutResponse response = await  plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if(response.status==true){
      Orderx coux = Orderx(
          userID: widget.orderx.userID,
          name: widget.orderx.name,
          hostelname: widget.orderx.hostelname,
          price: widget.orderx.price,
          agentID: brewx.id,
          userphone: widget.orderx.userphone,

          service: widget.orderx.service,
          blockNO: widget.orderx.blockNO,
          roomNO: widget.orderx.roomNO,
          stateBool: widget.orderx.stateBool,
          kg: widget.orderx.kg,
          hostelID: widget.orderx.hostelID,
          state: "In Progress",
          agent: brewx.name,
          id: widget.orderx.id,

          timestamp: Timestamp.fromDate(DateTime.now()),
          deliveryDate: Timestamp.fromDate(DateTime.now())


      );
     await orderDatabase(uid:widget.orderx.userID).addOrder(coux).whenComplete(() {});


      final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Hostels');

      final CollectionReference Offcamp =
      FirebaseFirestore.instance.collection('Offcamp');

      // Check if the document exists
      var documentSnapshot = await _reference.doc(widget.orderx.hostelID).get();

// If the document exists, update the 'orders' field
      if (documentSnapshot.exists) {
        _reference.doc(widget.orderx.hostelID).update({'orders': FieldValue.increment(1)});
      } else {
        // Handle the case where the document doesn't exist
        Offcamp.doc(widget.orderx.hostelID).update({'orders': FieldValue.increment(1)});
      }



      _reference.doc(widget.orderx.hostelID).update({'orders':FieldValue.increment(1)});

      sendMessageToTopic(brewx!.id, widget.student!.name,"New order and you are the Agent!");


      sendMessageToTopic("ADMIN", "New order from "+widget.student!.name,"Agent: "+brewx!.name);

      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));





      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Payment Successful. Your order is on its way to you"),

      ));

    }else{

    }




  }

  _showPaystack(String ref, int amount, String email,BuildContext context, FirebaseAuth auth, AgentData brewx) async {


   // SmartDialog.showLoading(msg: "Just a moment...", backDismiss: true);
    SmartDialog.showLoading(msg: "Just a moment...", backDismiss: true);

    bool isLoading = true;
    var _ref = ref;

    // This awaits the [authorization_url](#authUrl). NB: I'm using the MVVM architecture in my live code, but it's still the same process of retrieving the authURL.
    var authUrl = await request(ref, amount, email, context, auth, brewx);

    // only pull-up the dialog box when we get the authURL
    if (authUrl != null) {
      SmartDialog.dismiss();

      if(authUrl.length>2){
        setState(() {
          isLoading=false;
        });
      }
      WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) async {
              if (request.url.startsWith('https://www.google.com/')) {
                Orderx coux = Orderx(
                    userID: widget.orderx.userID,
                    name: widget.orderx.name,
                    hostelname: widget.orderx.hostelname,
                    price: widget.orderx.price,
                    agentID: brewx.id,
                    userphone: widget.orderx.userphone,

                    service: widget.orderx.service,
                    blockNO: widget.orderx.blockNO,
                    roomNO: widget.orderx.roomNO,
                    stateBool: widget.orderx.stateBool,
                    kg: widget.orderx.kg,
                    hostelID: widget.orderx.hostelID,
                    state: "In Progress",
                    agent: brewx.name,
                    id: widget.orderx.id,

                    timestamp: Timestamp.fromDate(DateTime.now()),
                    deliveryDate: Timestamp.fromDate(DateTime.now())


                );
                await orderDatabase(uid:widget.orderx.userID).addOrder(coux).whenComplete(() {});

                sendMessageToTopic(brewx!.id, widget.student!.name,"New order and you are the Agent!");


                sendMessageToTopic("ADMIN", "New order from "+widget.student!.name,"Agent: "+brewx!.name);

                sendMessageToTopic(  widget.student.referGuy,"FASTFIL","You just made a PROFIT!");


                double xx=amount/100;

                 FirebaseFirestore.instance.collection('students').doc(
                    widget.student.referGuy).update({"earnings": FieldValue.increment(xx.toInt())});

                FirebaseFirestore.instance.collection('students').doc(
                    widget.student.referGuy).update({"referrals": FieldValue.increment(1)});


                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));





                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Payment Successful. Your order is on its way to you"),

                ));


                return NavigationDecision.prevent;

              }
              if (request.url == "https://standard.paystack.co/close") {
                Navigator.of(context).pop(); //close webview


              }


              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(authUrl.toString()));


      return showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  // height: MediaQuery.of(context).size.height - 80,
                  height: MediaQuery.of(context).size.height - 0,
                  padding: const EdgeInsets.only(top: 40),
                  color: Colors.white,
                  child: isLoading==false? WebViewWidget(controller: controller):CircularProgressIndicator(),
                ));
          });
    }
  }

  Future<String> request(String ref, int amount, String email,BuildContext context, FirebaseAuth auth, AgentData brewx) async {
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
    Response response;
    response = await dio.post('https://api.paystack.co/transaction/initialize', data: {'amount': amount*100, 'email': email,"callback_url": "https://www.google.com/",});
    var responsex = jsonDecode(response.toString());
    String title = responsex['data']['authorization_url'];
    return title.toString();
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

      number: doc.get("number"),
      active: doc.get('active')??false,
      disable: doc.get('disable')??false,
      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),


    );
  }).toList();
}


