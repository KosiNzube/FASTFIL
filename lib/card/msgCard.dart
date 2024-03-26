
import 'package:afrigas/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Message.dart';
import '../modelspx/student.dart';
import '../responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class msgCard extends StatelessWidget {
  const msgCard({
    required this.press,
    required this.message,

  });
  final Message message;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    //  Here the shadow is not showing properly
    return MultiProvider(

      providers: [
        StreamProvider.value(
            value: Agent(id: message.agent).userData, initialData: null
        )
      ],
      child: NewWidget(press: press, message: message, mode: mode),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.press,
    required this.message,
    required this.mode,
  });

  final VoidCallback press;
  final Message message;
  final ThemeData mode;

  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<AgentData?>(context);

    return brewx!=null? Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding/2, vertical: kDefaultPadding/2),
      child: InkWell(
        onTap: (){

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

                    children: [
                      SizedBox(
                        width: Responsive.isDesktop(context)? 60:40,
                        height: Responsive.isDesktop(context)? 60:40,

                        child: Icon(CupertinoIcons.chat_bubble_2),
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                brewx!.name,textAlign: TextAlign.left,style:GoogleFonts.nunito(

                                fontSize: Responsive.isDesktop(context)? 19:15.8,fontWeight: FontWeight.w600)

                            ),
                            SizedBox(height: 7),

                            Text(
                               message.content,textAlign: TextAlign.left,style:GoogleFonts.nunito(
                                fontSize: Responsive.isDesktop(context)? 19:15.8)

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

            message.agentsender==true?message.sent==false? Positioned(right: 12, top: 12, child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
               shape: BoxShape.circle, color: kBadgeColor,
          ),
        ),):Container():message.sent==false?Positioned(right: 12, top: 12, child: Icon(Icons.done),):Positioned(right: 12, top: 12, child: Icon(Icons.done_all,color: Colors.blueAccent,),),
            SizedBox(height: kDefaultPadding / 2),


            Positioned(right: 12, bottom: 8, child:Text(DateFormat('HH:mm:ss').format(message.timestamp.toDate())),),

         //   Positioned(right: 12, bottom: 12, child:Text(DateFormat('EEE, M/d/y').format(message.timestamp.toDate())),)


          ],
        ),
      ),
    ):Container();
  }
}
