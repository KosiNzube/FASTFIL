import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class uxScreen extends StatefulWidget {

  const uxScreen() ;

  @override
  State<uxScreen> createState() => _uxScreenState();
}

class _uxScreenState extends State<uxScreen> {
  @override
  Widget build(BuildContext context) {

    bool xere=false;

    TextEditingController fullname = TextEditingController();


    return Scaffold(

      /*
      appBar: AppBar(

        title: Container(
          child: Text('Reviews',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 19,
          ),),),),

       */


      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [

              SizedBox(height: 80.0),


              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: fullname,

                style: TextStyle(color: Colors.black), // Set text color
                decoration: InputDecoration(
                  labelText: 'Input your email here',
                  labelStyle: TextStyle(color: Colors.black45,),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Background color

                ),

                maxLines: 1,
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return "Body field can't be empty";
                  }
                },
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                      "The new password will be sent to your email for verification",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 18,)
                  ),
                ),
              ),




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
                    child: Text('Proceed'),
                    onPressed: () async {
                      if(fullname.text.length>1&&fullname.text.contains("@")) {

                        setState(() {
                          xere=true;
                        });

                        await resetPassword(fullname.text.trim());

                        setState(() {
                          xere=false;
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid Email"),

                        ));

                      }
                    }
                ),
              ),

              const SizedBox(height: 17),

              xere==true? Center(child: CircularProgressIndicator()):Container(),
              const SizedBox(height: 8),

              xere==true? Padding(
                padding: EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ):Container(),

            ]
          ),
        ),
      ),
    );
  }
}
@override
Future<void> resetPassword(String email) async {
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  await _firebaseAuth.sendPasswordResetEmail(email: email);
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Fastfil',
          // criticalAlert: true,
          body: "Check your Email for your new Password",

          notificationLayout: NotificationLayout.BigText,
          actionType: ActionType.Default
      )
  );


}
