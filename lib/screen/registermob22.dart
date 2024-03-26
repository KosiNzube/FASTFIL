import 'package:afrigas/screen/welcome_screen2.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';



class Registermob22 extends StatefulWidget {
  Registermob22({
    Key? key,
    required this.formKeys,
    required this.textControllers,
    required this.nodes,
  }) : super(key: key);

  final GlobalKey<FormState> formKeys;
  final List<TextEditingController> textControllers;
  final List<FocusNode> nodes;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Registermob22> {
  AuthSerives _serives = AuthSerives();

  String? mail;
  bool fifi=false;

  String? password;

  void logIn(BuildContext context) async {
    final check = widget.formKeys.currentState!.validate();

    mail = widget.textControllers[0].text;
    password = widget.textControllers[1].text;
    if (mail!.isNotEmpty && password!.isNotEmpty) {
      await _serives.registerMailPasword(mail, password,context);
    } else if (mail!.isNotEmpty && password!.isEmpty) {
      FocusScope.of(context).requestFocus(widget.nodes[1]);
    }
  }

  void back(BuildContext context) {
    WelcomeScreen2.of(context).onBack();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Back',style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () => back(context),
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),


      body: RegisterCenter(size, context),
    );
  }

  Center RegisterCenter(Size size, BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),

            Text(
              'Register!',
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
              width: size.width * 0.8,
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.green,
                elevation: 0,
                textColor: Colors.white,
                child: Text('Create Account'),
                onPressed: () => logIn(context),
              ),
            ),
            SizedBox(height: 40.0),

            /* ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
            child: GoogleSignupButtonWidget(),
          ), */

          ],
        ),
      ),
    );
  }
}
