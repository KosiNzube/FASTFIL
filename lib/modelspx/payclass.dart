import 'dart:math';

import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';


import '../auth/auth.dart';
import '../auth/database.dart';
import '../constants.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';

class PayClass {
  final String name;
  final String usd;
  final int naira;
  final Timestamp timestamp;


  PayClass({
    required this.name,
    required this.usd,
    required this.naira,
    required this.timestamp,

  });
// final Color tagColor;

}

List<PayClass> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return PayClass(
        name: doc.data().toString().contains('name') ? doc.get('name') : '',
        usd: doc.data().toString().contains('usd') ? doc.get('usd') : '',
        naira: doc.data().toString().contains('naira') ? doc.get('naira') : 0,
        timestamp: doc.data().toString().contains('timestamp') ? doc.get('timestamp') : Timestamp(0, 0),

    );
  }).toList();
}


Stream<List<PayClass>> get payprice{
  return FirebaseFirestore.instance.collection("price").orderBy('timestamp',descending: true).limit(20).snapshots().map(items);
}
String generateRef() {
  final randomCode = Random().nextInt(3234234);
  return 'ref-$randomCode';
}

class PayCard extends StatefulWidget {
  const PayCard({
    required this.email,
    required this.press, required this.student,
  }) ;

  final PayClass email;
  final StudentData student;
  final VoidCallback press;

  @override
  State<PayCard> createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> {
  var publicKey = 'pk_test_285b6fee2412a1eb08e41763cb76aa63828a525a';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final ThemeData mode=Theme.of(context);

    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()async{


            //  js.context.callMethod('open', ['https://play.google.com/store/apps/details?id=myapplication.flame.fleming.zain']);

            if(kIsWeb){



              /*
              final ref = generateRef();
              final amount = widget.email.naira;


              await PaystackPopup.openPaystackPopup(
              email: _auth.currentUser!.email.toString(),
              amount: (amount * 100).toString(),
              ref: ref,
              onClosed: () {
                debugPrint('Could\'nt finish payment');
              },
              onSuccess: () async {




//                Restart.restartApp();




                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(" Payment Successful. "),

                ));

                debugPrint('successful payment');
              },
            );




               */







            }else{
              final ref = generateRef();
              final amount = widget.email.naira;

              _processPayment(ref,amount,_auth.currentUser!.email.toString(),context,_auth);

            }



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
                      SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text.rich(


                          TextSpan(
                            text: "${widget.email.name} \n",
                            style: TextStyle(
                              fontSize: Responsive.isDesktop(context)?20:  16,
                              fontWeight: FontWeight.w500,
                            ),

                            children: [

                              TextSpan(
                                text: widget.email.usd,
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

                      Icon(Icons.stars_rounded)

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

  Future<void> _processPayment(String ref, int amount, String email,BuildContext context, FirebaseAuth auth) async {
    Charge charge = Charge()
      ..amount = amount*100
      ..reference = ref
    // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = email;
    CheckoutResponse response = await plugin.checkout(
       context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );





  }
}


class ListOfPay extends StatefulWidget {

  final List<PayClass> brewx;
  final StudentData student;

  const ListOfPay({ required this.brewx, required this.student}) ;

  // Press "Command + ."

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<ListOfPay> {
  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }

    return Scaffold(



      body:
      Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            children: [

              SizedBox(height: kDefaultPadding/2),

              // This is our Seearch bar


              Responsive.isDesktop(context)? NewWidgetD(brewcx: widget.brewx,stud:widget.student):NewWidget(brewcx: widget.brewx,stud:widget.student),

            ],
          ),
        ),
      ),

    );
  }
}

class NewWidget extends StatelessWidget {
  final List<PayClass> brewcx;
  final StudentData stud;

  const NewWidget({ required this.brewcx, required this.stud});


  @override
  Widget build(BuildContext context) {


    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),

        itemCount: brewcx.length,
        // On mobile this active dosen't mean anything
        itemBuilder: (context, index) => PayCard(
          email: brewcx[index],
          student: stud,
          press: () {

          },
        ),
      ),
    );
  }
}

class NewWidgetD extends StatelessWidget {
  final List<PayClass> brewcx;
  final StudentData stud;

  const NewWidgetD({ required this.brewcx, required this.stud});


  @override
  Widget build(BuildContext context) {


    return Responsive(
        mobile: Center(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            itemCount: brewcx.length,
            // On mobile this active dosen't mean anything
            itemBuilder: (context, index) => PayCard(
              email: brewcx[index],
              student: stud,
              press: () {

              },
            ),
          ),
        ),
        tablet: Center(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            itemCount: brewcx.length,
            // On mobile this active dosen't mean anything
            itemBuilder: (context, index) => PayCard(
              email: brewcx[index],
              student: stud,
              press: () {

              },
            ),
          ),
        ),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340

            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: defaultPadding),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemCount: brewcx.length,
                  // On mobile this active dosen't mean anything
                  itemBuilder: (context, index) => PayCard(
                    email: brewcx[index],
                    student: stud,
                    press: () {

                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Image.asset(
                        'assets/images/xl.png',
                        height: 800,
                      ),



                    ],
                  ),
                ),
              )
              ,

            ),
          ],

        )

    );

  }
}
