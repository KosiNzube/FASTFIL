import 'package:afrigas/comp2/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';


import 'package:flutter_animator/flutter_animator.dart';

import '../constants.dart';
import '../responsive.dart';
import '../screen/welcome_screen.dart';
import 'main_button.dart';

class Jumbotron extends StatefulWidget {


  @override
  State<Jumbotron> createState() => _JumbotronState();
}

class _JumbotronState extends State<Jumbotron> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Row(
          children: <Widget>[



            Expanded(
                child: Column(
                  mainAxisAlignment: !isMobile(context)
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  crossAxisAlignment: !isMobile(context)
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 5,),

                    if (isMobile(context))
                      Image.asset(
                        kIsWeb?'assets/images/xl.png':'assets/images/xxx.png',
                        width: 300,
                        height: Responsive.isMobile(context)?300:600,

                      ),
                    RichText(
                        textAlign: !isMobile(context)
                            ? TextAlign.start
                            : TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Welcome To\n',
                              style: GoogleFonts.caladea(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Responsive.isDesktop(context)? 40:20)),
                          TextSpan(
                              text: kIsWeb? "Varlc Mobile":"Varlc Mobile",
                              style: GoogleFonts.montserrat(
                                  color: kBadgeColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Responsive.isDesktop(context)? 64:32)),
                        ])),
                    Text(
                      'An E-Learning Platform',
                      textAlign:
                          !isMobile(context) ? TextAlign.start : TextAlign.center,
                      style: GoogleFonts.marcellus(
                          color: Colors.black54,

                          fontWeight:FontWeight.w600,
                          fontSize: Responsive.isDesktop(context)? 40:20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Take professional courses and lectures from verified expert-instructors. Specially designed for university students ',
                      textAlign:
                          isMobile(context) ? TextAlign.center : TextAlign.start,
                      style:Responsive.isDesktop(context)?GoogleFonts.marcellus(
                          color: CupertinoColors.black,

                          fontSize: Responsive.isDesktop(context)? 36:19):GoogleFonts.marcellus(
                          color: CupertinoColors.black,

                          fontSize: Responsive.isDesktop(context)? 36:19),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          MainButton4(
                            title:  kIsWeb? "GET IT ON GOOGLE PLAYSTORE":"GET STARTED",
                            color: kBadgeColor,
                            tapEvent: () {

                              setState(() {
                                tutotAcc=false;

                              });

                              kIsWeb?WelcomeScreen.of(context).jumpSign() :WelcomeScreen.of(context).jumpSign();

                            },
                          ),
                         // SizedBox(width: 10),
                          MainButton5(
                            title:  kIsWeb? "GET IT ON iOS":"BROWSE",
                            color: kBadgeColor,
                            tapEvent: () {

                              setState(() {
                                tutotAcc=true;

                              });


                              kIsWeb?WelcomeScreen.of(context).jumpSign() :WelcomeScreen.of(context).jumpSign();


                            },
                          )
                        ],
                      ),
                    ),



                  ],
                )),
            if (isDesktop(context) || isTab(context))
              Expanded(
                  child: Image.asset(
                'assets/images/xl.png',
                height: size.height * 0.5,
              ))
          ],
        ));
  }
}

bool tutotAcc=false;