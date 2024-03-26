import 'package:afrigas/modelspx/State.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../mainx.dart';
import '../modelspx/Admin.dart';
import '../modelspx/student.dart';
import '../pages/EmailVerificationScreen.dart';
import '../screen/welcome_screen.dart';
import 'database.dart';

class Controller2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    final user = Provider.of<Student?>(context);
    return user != null ? MultiProvider(
        providers: [

          StreamProvider.value(
            
            value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null,),
          StreamProvider.value(
              value: adminData, initialData: null),
          StreamProvider.value(

            value: getStates, initialData: null,),

        ],
        child: firebaseAuth.currentUser?.emailVerified==true?Home():EmailVerificationScreen()):WelcomeScreen();
  }
}
