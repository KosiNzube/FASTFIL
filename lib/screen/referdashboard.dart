import 'dart:convert';
import 'dart:math';

import 'package:afrigas/extensions.dart';
import 'package:afrigas/screen/ChatScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';


import '../../../auth/agentDatabase.dart';
import '../../../auth/database.dart';
import '../../../comp2/responsive.dart';
import '../../../constants.dart';
import '../auth/auth.dart';
import '../card/cartCard.dart';
import '../comp2/DarkThemeProvider.dart';
import '../components/custom_text.dart';
import '../components/style.dart';
import '../modelspx/Admin.dart';
import '../modelspx/student.dart';
import '../responsive.dart';




class referDashboard extends StatefulWidget {



  // Press "Command + ."

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<referDashboard> {
  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    final student = Provider.of<StudentData?>(context);

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

        return student!=null? student.affiliate==false? Scaffold(


          appBar: AppBar(
            centerTitle: false,
            title: Container(

              child: Text("Fastfil affiliate"),
            ),
            // like this!
          ),




          body:
          Container(

            child: SingleChildScrollView(
                physics: ScrollPhysics(),

                child: Column(
                  key: PageStorageKey(145),

                  children: [
                    SizedBox(height: kDefaultPadding),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Row(

                                  children: [
                                    SizedBox(
                                      width: Responsive.isDesktop(context)? 60:40,
                                      height: Responsive.isDesktop(context)? 60:40,

                                      child: Icon(CupertinoIcons.money_yen_circle),
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(
                                              "FASTFIL" ,textAlign: TextAlign.left,style:GoogleFonts.lato(

                                              fontSize: Responsive.isDesktop(context)? 19:16,fontWeight: FontWeight.w600)

                                          ),
                                          SizedBox(height: 7),

                                          Text(
                                            "Earn passive income referring people to Fasfil and earn a profit off every purchase they make\n\nLet's get started",
                                              textAlign: TextAlign.left,style:GoogleFonts.lato(
                                              fontSize: Responsive.isDesktop(context)? 17:15.8)


                                          )
                                        ],
                                      ),
                                    ),


                                    SizedBox(width: kDefaultPadding / 2),



                                  ],
                                ),

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



                    const SizedBox(height: defaultPadding/1.2),

                    MultiProvider(providers: [


                      StreamProvider.value(
                          value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),


                      StreamProvider.value(
                          value: adminData, initialData: null),


                    ],
                        child: NewWidget(context2: context,)),






                    SizedBox(height: 90,)







                  ],
                ),
              ),
            ),

      ):Revenue():Center(child: CircularProgressIndicator());
  }
}









class Revenue extends StatefulWidget {
  const Revenue({
    Key? key,
  }) : super(key: key);

  @override
  State<Revenue> createState() => _RevenueState();
}



class _RevenueState extends State<Revenue> {
  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    List<OnBoardingModel> xx=[];
    final brewx = Provider.of<StudentData>(context);

    int revenue=brewx.earnings;


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Revenue",),
        ),
        // like this!
      ),



      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),






            accardyxxx(s:brewx.referrals.toString(),x:"Number of referrals",q:Icons.description,press: (){}),


            accardyxxx(s:revenue.toString(),x:"Total revenue",q: Icons.money,press: (){},),

            SizedBox(height: kDefaultPadding),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () async {
                  if(brewx.earnings>2999){

                    xx= await fetchOnboarding();

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen:selBank(brewx: xx,amount:brewx.earnings),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation
                          .cupertino,
                    );




                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "The payment threshold is "+ formatAmountWithNairaSign(3000)),

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
                    text: "Cash out",
                  ),
                ),
              ),
            ),





          ],
        ),
      ),
    );
  }
}
























class NewWidget extends StatefulWidget {
  final BuildContext context2;

  const NewWidget({ required this. context2});

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    final admin = Provider.of<Admin>(context);
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;



    return SingleChildScrollView(
      physics: ScrollPhysics(),

      child: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
        child: Column(
          children: [



            SizedBox(height: kDefaultPadding),

            Text("Create your referral code",style: GoogleFonts.raleway (fontSize: 27,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),

            SizedBox(height: kDefaultPadding*2),

            TextField(
              controller: name,

              decoration: InputDecoration(
                  labelText: "Input code here",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: kDefaultPadding),


            InkWell(
              onTap: () async {
                if (name.text.length > 4) {

                  if(admin.refercodes.contains(name.text)){

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Refer code already taken"),

                        ));

                  }else{
                    SmartDialog.showLoading(msg:"Just a moment...");

                    await FirebaseFirestore.instance.collection('students').doc(firebaseAuth.currentUser!.uid).update({'myrefercode': name.text});

                    await FirebaseFirestore.instance.collection('ADMIN').doc("ihFiNg83MAyFX3danjxr").update({"refercodes":FieldValue.arrayUnion([name.text])});
                    await FirebaseFirestore.instance.collection('students').doc(firebaseAuth.currentUser!.uid).update({'affiliate':true});

                    SmartDialog.dismiss();


                  }

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                              "Refer code must be a 4+ word"),

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
                  text: "Continue",
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: kDefaultPadding*6),


          ],
        ),
      ),
    );
  }

}




Future<List<OnBoardingModel>> fetchOnboarding() async {
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
  try {
    Response response = await dio.get("https://api.paystack.co/bank?currency=NGN");
    var responsex = jsonDecode(response.toString());

    List<OnBoardingModel> xxx=[];


    (response.data['data']).forEach((element) {
      xxx.add(new OnBoardingModel(name: element['name'].toString(), slug: element['slug'].toString(), code: element['code'].toString(), currency: element['currency'].toString(),));
    });
    print(xxx[0]);

    // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
    return (xxx);
  } catch (error, stacktrace) {
    throw Exception("Exception occured: $error stackTrace: $stacktrace");
  }
}


class OnBoardingModel {




  OnBoardingModel({
    required this.name,
    required this.slug,
    required this.code,
    required this.currency,
  });

  String name;
  String slug;
  String code;
  String currency;

  @override
  String toString() {
    return '$name, $slug,$code, $currency';
  }
}



class accardyxx extends StatelessWidget {
  const accardyxx({
    Key? key, required this.q, required this.press
  }) : super(key: key);

  final OnBoardingModel q;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);



    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()  {

          press();

        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(q.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
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
    );
  }
}
class accardyxxx extends StatelessWidget {
  const accardyxxx({
    Key? key, required this.s, required this.x,required this.q, required this.press
  }) : super(key: key);

  final IconData q;
  final String s;
  final String x;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()  {

          press();

        },
        child:Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(


                          TextSpan(
                            text:  "${x} \n",
                            style: TextStyle(
                              fontSize: Responsive.isDesktop(context)?20:  16,
                              fontWeight: FontWeight.w600,
                            ),

                            children: [

                              TextSpan(
                                text: s,
                                style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)?22:  18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Icon(q)

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
    );
  }
}
class selBank extends StatelessWidget {
  const selBank({
    Key? key,
    required this.brewx, required this.amount,
  }) : super(key: key);

  final int amount;
  final List<OnBoardingModel> brewx;

  @override
  Widget build(BuildContext context) {

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    return Scaffold(



      body:ListView.builder(
        shrinkWrap: true,


        itemCount: brewx.length,
        // On mobile this active dosen't mean anything
        itemBuilder: (context, index) => accardyxx(
          q: brewx[index]!,
          press: () {

            _displayTextInputDialog(context,brewx[index].name , brewx[index].code,amount);



          },
        ),
      ),
    );
  }
}

Future<void> _displayTextInputDialog(BuildContext context, String name,String code, int amount) async {
  TextEditingController _textFieldController = TextEditingController();
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("ACCOUNT NUMBER"),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Input account number"),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: Text('PROCEED'),
            onPressed: () async {
              print(_textFieldController.text);

             String x= await request(_textFieldController.text, code, context);


             SmartDialog.showLoading(msg: "Just a moment...");

              await Initiatetransfer(x,amount);
             // await FirebaseFirestore.instance.collection('students').doc(firebaseAuth.currentUser!.uid).update({'referrals':0});
              await FirebaseFirestore.instance.collection('students').doc(firebaseAuth.currentUser!.uid).update({'earnings':0});

              SmartDialog.dismiss();



              snack("The transfer is being processed now!", context);

              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> Initiatetransfer(String s, int amount) async {
  FirebaseAuth auth=FirebaseAuth.instance;
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
  Response response;
  response = await dio.post('https://api.paystack.co/transfer', data: {"source": "balance","recipient": s,  "amount": amount, "reference": generateRef(),"reason": "Happy payday" });
  var responsex = jsonDecode(response.toString());
  String title = responsex['data']['status'];
  print(title);
}


Future<String> request(String number,String code,BuildContext context) async {
  FirebaseAuth auth=FirebaseAuth.instance;
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer sk_live_b72e9c9940fc4ae722107967ca939603cd8d7816";
  Response response;
  response = await dio.post('https://api.paystack.co/transferrecipient', data: {"type": "nuban",  "account_number": number, "bank_code": code,"currency": "NGN","name": auth.currentUser!.email });
  var responsex = jsonDecode(response.toString());
  String title = responsex['data']['recipient_code'];
  print(title);
  return title.toString();
}

String generateRef() {
  final randomCode = Random().nextInt(3234234);
  return 'ref-$randomCode';
}