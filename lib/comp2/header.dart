import 'package:afrigas/comp2/responsive.dart';
import 'package:flutter/material.dart';


import '../responsive.dart';
import 'menu_item.dart';

class Header extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: <Widget>[

          Text(
            "Varlc Web",
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          if (!isMobile(context))
            Row(
              children: [
                NavItem(
                  title: 'Home',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'Instructor',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'Schedule',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'About Studio',
                  tapEvent: () {},
                ),
                NavItem(
                  title: 'Login',
                  tapEvent: () {},
                ),
              ],
            ),
          if (isMobile(context))
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                })
        ],
      ),
    );
  }
}
