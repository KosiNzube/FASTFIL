import 'package:afrigas/comp2/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../constants.dart';
import '../responsive.dart';
import '../services/routes.dart';

class Footer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) ? DesktopFooter() : MobileFooter();
  }
}

class DesktopFooter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              kIsWeb?Navigator.pushNamed(context, Routes.privacy):{};

            },
            child: Text(
              'All Right Reserved | Privacy',
              style: TextStyle(fontSize:Responsive.isMobile(context)? 10:16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NavItem(
                title: 'Twitter',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Facebook',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Linkedin',
                tapEvent: () {},
              ),
              NavItem(
                title: 'Instagram',
                tapEvent: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MobileFooter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff132137),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),

        child: Column(
          children: <Widget>[
            SizedBox(height: 35,),
            Text(
              'This service accesses your Camera, Location and Storage only for functional and safety purposes',
              textAlign: TextAlign.center,
              style: GoogleFonts.assistant(
                fontSize:  14,
                color: Colors.grey
              ),
            ),

            SizedBox(height: 25,),

            InkWell(
              onTap: (){
                kIsWeb?Navigator.pushNamed(context, Routes.privacy):{};

              },
              child: Text(
                'All Right Reserved | Privacy',
                style: TextStyle(fontSize:Responsive.isMobile(context)? 11:16,color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NavItem(
                  title: 'Twitter',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'Facebook',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'Linkedin',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'Instagram',
                  tapEvent: () {},
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({required this.title, required this.tapEvent});

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: TextStyle(color: kBadgeColor, fontSize:Responsive.isMobile(context)? 12:22),
        ),
      ),
    );
  }
}
