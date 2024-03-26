import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Agents.dart';
import 'package:afrigas/modelspx/student.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class agentCard extends StatelessWidget {
  const agentCard({
    required this.email,
    required this.student,
    required this.press,
  });

  final AgentData email;
  final StudentData student;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    //  Here the shadow is not showing properly
    return Padding(
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

                        child: CachedNetworkImage(
                          imageUrl: email.image,
                          imageBuilder: (context, imageProvider) => Container(
                            height: Responsive.isDesktop(context)? 60:40,
                            width: Responsive.isDesktop(context)? 60:40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>  Container(
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lime,),

                            height: Responsive.isDesktop(context)? 60:40,),
                          errorWidget: (context, url, error) =>Container(
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lime,),

                            height: Responsive.isDesktop(context)? 60:40,),),
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                email.name,textAlign: TextAlign.left,style:GoogleFonts.nunito(

                                fontSize: Responsive.isDesktop(context)? 19:15.8,fontWeight: FontWeight.w600)

                            ),
                            SizedBox(height: 7),

                            Text(
                               email.hostel+" Hall Agent",textAlign: TextAlign.left,style:GoogleFonts.nunito(
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

           email.active==true? Positioned(right: 12, top: 12, child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
               shape: BoxShape.circle, color: kBadgeColor,
          ),
        ),):Container(),
            SizedBox(height: kDefaultPadding / 2),





          ],
        ),
      ),
    );
  }
}
