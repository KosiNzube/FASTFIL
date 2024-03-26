import 'dart:async';
import 'package:afrigas/modelspx/State.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import '../auth/database.dart';
import '../mainx.dart';
import '../modelspx/Admin.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  FirebaseAuth auth=FirebaseAuth.instance;
  AuthSerives _serives = AuthSerives();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MultiProvider(
                  providers: [

                    StreamProvider.value(

                      value: DataBaseService(uid:auth.currentUser!.uid,email:auth.currentUser!.email).userData, initialData: null,



                    ),


                    StreamProvider.value(
                        value: adminData, initialData: null),

                    StreamProvider.value(

                      value: getStates, initialData: null,),


                  ],
                  child: Home()),
        ),
      );


      // TODO: implement your code after email verification
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));

      timer?.cancel();


    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                    'Check your \n Email',
                    textAlign: TextAlign.center,style: TextStyle(fontSize: 19)
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                      'We have sent you an Email on  ${auth.currentUser?.email}'+" for confirmation",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 19,)
                  ),
                ),
              ),
              const SizedBox(height: 16),
              /*
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),

              const Padding(
                padding: EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

               */
              const SizedBox(height: 37),


              SizedBox(
                width: 130,
                height: 40,
                child:  MaterialButton(
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27.0)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Resend'),
                    onPressed: (){
                      try {
                        FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                      } catch (e) {
                        debugPrint('$e');
                      }

                    }
                ),
              ),


              const SizedBox(height: 14),

              SizedBox(
                width: 148,
                height: 40,
                child:  MaterialButton(
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.0)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Wrong email'),
                  onPressed: () => _serives.logOut(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

