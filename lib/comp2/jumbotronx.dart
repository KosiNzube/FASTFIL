import 'package:afrigas/comp2/responsive.dart';
import 'package:afrigas/extensions.dart';
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
import 'main_button.dart';

class Jumbotronx extends StatefulWidget {


  @override
  State<Jumbotronx> createState() => _JumbotronState();
}

class _JumbotronState extends State<Jumbotronx> {
  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    Size size = MediaQuery.of(context).size;
    List array=["Video library","Mock exams","Live lessons","Tests and Quizzes","PDFS and linked DOCS"];

    return        BounceInUp(
      child:                   Container(
          color: CupertinoColors.tertiarySystemFill,

          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: <Widget>[



                if (isDesktop(context) || isTab(context))
                  Expanded(
                      child: Image.asset(
                        'assets/images/yl.png',
                        height: size.height * 0.5,
                      )),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
                      child: Column(
                        mainAxisAlignment: !isMobile(context)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        crossAxisAlignment: !isMobile(context)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: <Widget>[


                          if (isMobile(context))
                            Image.asset(
                              kIsWeb?'assets/images/yl.png':'assets/images/yl.png',
                              width: 300,
                              height: Responsive.isMobile(context)?300:600,

                            ),
                          RichText(
                              textAlign: !isMobile(context)
                                  ? TextAlign.start
                                  : TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Everything you need to excel in school and beyond',
                                    style: GoogleFonts.caladea(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.w800,
                                        fontSize: Responsive.isDesktop(context)? 65:45)),

                              ])),
                          SizedBox(height: kDefaultPadding / 2),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),

                            itemCount: array.length,
                            // On mobile this active dosen't mean anything
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [

                                    Container(
                                      padding: EdgeInsets.all(kDefaultPadding/2),
                                      decoration: BoxDecoration(
                                        color:  Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(

                                        children: [
                                          SizedBox(height: kDefaultPadding / 2),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: kDefaultPadding / 2),



                                              Expanded(

                                                child: Text.rich(


                                                  TextSpan(

                                                    text:array[index],
                                                    style: GoogleFonts.nunito(
                                                        color: CupertinoColors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: Responsive.isDesktop(context)? 22:19.5),

                                                    children: [


                                                    ],

                                                  ),
                                                  textAlign:Responsive.isMobile(context)? TextAlign.center:TextAlign.start,

                                                ),
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
                                    Positioned.fill(

                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 13.0),
                                          child: Icon( CupertinoIcons.link,color: Colors.black54,),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );


                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Icon(Icons.done),
                                    SizedBox(width:  Responsive.isDesktop(context)? 15:10,),

                                    Expanded(child: Text(array[index], style: GoogleFonts.caladea(
                              textStyle:  TextStyle(fontSize: Responsive.isDesktop(context)? 30:20, color: Colors.black,fontWeight: FontWeight.w300)))),
                                  ],
                                ),
                              );
                            },

                          )



                        ],
                      ),
                    )),

              ],
            ),
          )),
    );



  }
}

bool tutotAcc=false;