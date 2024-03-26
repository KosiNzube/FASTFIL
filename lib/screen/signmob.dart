import 'package:afrigas/screen/uxScreen.dart';
import 'package:afrigas/screen/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../auth/auth.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';


class Signmob extends StatefulWidget {
  Signmob({
    Key? key,
    required this.formKeys,
    required this.textControllers,
    required this.nodes,
  }) : super(key: key);

  final GlobalKey<FormState> formKeys;
  final List<TextEditingController> textControllers;
  final List<FocusNode> nodes;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Signmob> {
  final AuthSerives _serives = AuthSerives();

  String? mail;

  bool fifi=false;


  String? password;

  void signIn(BuildContext context) async {
    widget.formKeys.currentState!.validate();

    mail = widget.textControllers[0].text;
    password = widget.textControllers[1].text;

    if (mail!.isNotEmpty && password!.isNotEmpty) {
      setState(() {
        isLoad = false;
      });
      dynamic user = await _serives.signMailPassword(mail, password,context);
      setState(() {
        isLoad = true;
      });
      if (user == null) {


      } else {
        print('successful signing');
      }
    } else if (mail!.isNotEmpty && password!.isEmpty) {
      FocusScope.of(context).requestFocus(widget.nodes[1]);
    }
  }

  void logIn(BuildContext context) async {
    WelcomeScreen.of(context).jumpLogin();
  }

  bool isLoad = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,

      body:Signincenter(size, context),
    );
  }

  Center Signincenter(Size size, BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kIsWeb ? 20.0 : 40.0),

            Text(
              'Login!',
              style: TextStyle(
                fontSize: 48,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),

            InputWidget(
              formKey: widget.formKeys,
              editController: widget.textControllers,
              itemCount: widget.textControllers.length,
              nodes: widget.nodes,
              icons: [
                Icons.mail,
                Icons.lock,
              ],
              type: [
                TextInputType.emailAddress,
                fifi==false? TextInputType.visiblePassword:TextInputType.text,
              ],
              titles: [
                'E-mail',
                'Password',
              ],
            ),
            InkWell(
                onTap: (){
                  setState(() {

                    fifi=!fifi;
                  });



                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(fifi==true?Icons.visibility_off:Icons.visibility,color: Colors.grey,),
                    SizedBox(width: 2,),
                    Text(fifi==false?"Show Password":"Hide Password",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey),)
                  ],
                )),


            SizedBox(height: 20.0),
            SizedBox(
              width: size.width * 0.9,
              height: 50,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                child: isLoad
                    ? Text('Continue')
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white,),
                    SizedBox(width: 10.0),
                    Text('Signing In'),
                  ],
                ),
                onPressed: () => signIn(context),
              ),
            ),
            SizedBox(height: 20.0),

            Text('or', style: TextStyle(fontSize: 16,                color: Colors.black,)),
            SizedBox(height: 20.0),

            SizedBox(
              width: size.width * 0.8,
              height: 50,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Create Account'),
                onPressed: () => logIn(context),
              ),
            ),

            SizedBox(height: 10,),
            InkWell(
                onTap: (){

                  Navigator.pop(context);


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return uxScreen();
                        }
                    ),
                  );


                },
                child: Text('Forgot Password?',style: TextStyle(color: Colors.black),)),



           // SizedBox(height: kIsWeb? 20.0:70),
            SizedBox(height: kIsWeb ? 20.0 : 40.0),



          ],
        ),
      ),
    );
  }
}
