import 'package:afrigas/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class EmailCard extends StatelessWidget {
  const EmailCard({
     this.isActive = true,
    required this.press,
    required this.image,
    required this.conyext,


  });

  final bool isActive;
  final String image;
  final String conyext;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    Size _size = MediaQuery
        .of(context)
        .size;
    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding/2, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: (){

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
                  SizedBox(height: 5),
                  CachedNetworkImage(
                    imageUrl: image,
                    imageBuilder: (context, imageProvider) => Container(
                      width: Responsive.isDesktop(context)? _size.width:_size.width,
                      height: Responsive.isDesktop(context)? 200:200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,),
                      ),
                    ),
                    placeholder: (context, url) =>  Container(
                      color: Colors.black87,
                      width: Responsive.isDesktop(context)? _size.width:_size.width,
                      height: Responsive.isDesktop(context)? 200:200,),
                    errorWidget: (context, url, error) =>Container(
                      color: Colors.black87,
                      width: Responsive.isDesktop(context)? _size.width:_size.width,
                      height: Responsive.isDesktop(context)? 200:200,),
                  ),
                  SizedBox(height: 12),

                  Text(
                      conyext,textAlign: TextAlign.center,style:GoogleFonts.nunito(
                      fontSize: Responsive.isDesktop(context)? 19:17.8)

                  ),


                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
            SizedBox(height: kDefaultPadding / 2),





          ],
        ),
      ),
    );
  }
}
