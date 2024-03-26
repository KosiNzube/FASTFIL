import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';
import '../responsive.dart';
import 'side_menu_item.dart';
import 'tags.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class SideMenu extends StatelessWidget {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(double.infinity, 44),
    padding: EdgeInsets.symmetric(
      vertical: kDefaultPadding,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: kPrimaryColor,
  );
  final ButtonStyle flatButtonStylex = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(double.infinity, 44),
    padding: EdgeInsets.symmetric(
      vertical: kDefaultPadding,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefopadding : 0),
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefopadding),
          child: Column(
            children: [
              Row(
                children: [

                  Spacer(),
                  // We don't want to show this close button on Desktop mood
                  if (!Responsive.isDesktop(context)) CloseButton(),
                ],
              ),
              SizedBox(height: kDefopadding),
              

              

              SizedBox(height: kDefopadding),


              SizedBox(height: kDefaultPadding ),

              SizedBox(height: kDefaultPadding * 2),

              // Menu Items

              /*
              SideMenuItem(
                press: () {},
                title: "Inbox",
                iconSrc: "assets/Icons/Inbox.svg",
                isActive: true,
                itemCount: 3,
              ),
              SideMenuItem(
                press: () {},
                title: "Sent",
                iconSrc: "assets/Icons/Send.svg",
                isActive: false, itemCount: 0,
              ),
              SideMenuItem(
                press: () {},
                title: "Sent",
                iconSrc: "assets/Icons/Send.svg",
                isActive: false, itemCount: 0,
              ),
              SideMenuItem(
                press: () {},
                title: "Sent",
                iconSrc: "assets/Icons/Send.svg",
                isActive: false, itemCount: 0,
              ),
*/
              SizedBox(height: kDefopadding * 2),
              // Tags
            //  Tags(key: 0,),
            ],
          ),
        ),
      ),
    );
  }
}
