import 'package:afrigas/comp2/responsive.dart';
import 'package:afrigas/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';


import 'package:flutter_animator/flutter_animator.dart';

import '../auth/auth.dart';
import '../auth/controller.dart';
import '../constants.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import '../screen/welcome_screen.dart';
import '../services/custom_button.dart';
import 'main_button.dart';
const Color kBadgeColor = Colors.blueGrey;

const TextStyle kWelcomeTextStyle = TextStyle(
  fontWeight: FontWeight.w800,
  color: kBadgeColor,
  fontSize: 20,
);

const TextStyle kFastfilMobileTextStyle = TextStyle(
  color: kBadgeColor,
  fontWeight: FontWeight.w800,
  fontSize:  32,
);

const TextStyle kUberForGasTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.black,

  fontSize: 20,
);





// MainButton Widget
class MainButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback tapEvent;

  const MainButton({
    required this.title,
    required this.color,
    required this.tapEvent,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: tapEvent,
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
      child: Text(title),
    );
  }
}
class AppJumbotron extends StatefulWidget {


  @override
  State<AppJumbotron> createState() => _JumbotronState();
}

class _JumbotronState extends State<AppJumbotron> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust the opacity value (0.0 to 1.0)
              child: Image.asset(
                  Constants.background ,
                  fit: BoxFit.fill
              ),
            )








            /*


            Image.asset(
                 Constants.background ,
                fit: BoxFit.fill,
              ),

             */

          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 95),
                  Image.asset(
                    'assets/images/sadro.png',
                    width: 128,
                    height: 128,
                  ).animate().fade().slideY(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
                  SizedBox(height: 30),
                  PlaceholderText(
                    text: 'FAST-FIL',
                    fontSize: Responsive.isMobile(context) ? 50 : 100,
                  ).animate().fade().slideY(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
                  buildTitle().animate().fade().slideY(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
                //  SizedBox(height: 10),
                  SizedBox(height: 24),
                  buildDescription().animate().fade().slideY(
                    duration: 300.ms,
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
                  SizedBox(height: 40),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 90),
                    child: CustomButton(
                      text: 'Proceed',
                      onPressed: () {
                        //  widget.animationController.animateTo(0.2);
                        //   _animationController!.stop();


                        Navigator.pop(context);

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          //  settings: RouteSettings(name:  "assistant"),
                          screen:     MultiProvider(
                              providers: [
                                StreamProvider<Student?>.value(
                                  value: AuthSerives().user,
                                  initialData: null,
                                )
                              ],

                              child: Controller())
                          ,
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );

                      },
                      fontSize: 16,
                      radius: 50,
                      verticalPadding: 16,
                      hasShadow: false,
                    ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  MainAxisAlignment getMainAxisAlignment(BuildContext context) {
    return isMobile(context) ? MainAxisAlignment.center : MainAxisAlignment.start;
  }

  CrossAxisAlignment getCrossAxisAlignment(BuildContext context) {
    return isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start;
  }

  RichText buildRichText() {
    return RichText(
      textAlign: !isMobile(context) ? TextAlign.start : TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Welcome To\n',
            style: kWelcomeTextStyle,
          ),
          TextSpan(
            text: kIsWeb ? "Fastfil Mobile" : "Fastfil Mobile",
            style: kFastfilMobileTextStyle,
          ),
        ],
      ),
    );
  }

  Text buildTitle() {
    return Text(
      'Swift Delivery',
      textAlign: !isMobile(context) ? TextAlign.start : TextAlign.center,
      style: GoogleFonts.raleway(
        fontSize:  20,
        fontWeight: FontWeight.w500,
        color: Colors.black,

      ),
    );
  }

  Text buildDescription() {
    return Text(
      'Fastfil is a gas and grocery delivery startup with a heartfelt mission to alleviate the burdensome task of traversing lengthy distances to replenish gas cylinders or acquire essential groceries',
      textAlign: isMobile(context) ? TextAlign.center : TextAlign.start,
      style:  GoogleFonts.raleway(
        fontSize:  19,
        fontWeight: FontWeight.w500,
        color: Colors.black,

      ),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          MainButton(
            title: 'GET STARTED',
            color: kBadgeColor,
            tapEvent: () {
              setState(() {
                tutotAcc = false;
              });
              WelcomeScreen.of(context).jumpSign();
            },
          ),
          MainButton(
            title: 'BROWSE',
            color: kBadgeColor,
            tapEvent: () {
              setState(() {
                tutotAcc = true;
              });
              WelcomeScreen.of(context).jumpSign();
            },
          ),
        ],
      ),
    );
  }

}

class PlaceholderText extends StatelessWidget {
  final String text;
  final double fontSize;

  const PlaceholderText({
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black, // Placeholder text color
      ),
    );
  }
}


bool tutotAcc=false;