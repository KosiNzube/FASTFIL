import 'package:afrigas/comp2/footer.dart';
import 'package:flutter/material.dart';

import '../components/blog.dart';
import '../components/spacing.dart';
import '../components/typography.dart';



class Contact extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(

              child: Column(
                children: <Widget>[
                  SizedBox(height: 25,),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                      child: Text("CONTACT US", style: headlineTextStyle),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                      child: Text("Address",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                          child: Text("Obafemi Awolowo University, OAU, Ile-Ife, Osun State, Nigeria",
                          style: subtitleTextStyle),
                    ),
                  ),
                  divider,
                  Container(
                    margin: marginBottom30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                      child: Text("Call",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                          child: Text("09055772501, 07012156187",
                          style: subtitleTextStyle),
                    ),
                  ),
                  dividerSmall,

                  Container(
                    margin: marginBottom30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                      child: Text("Email",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                      child: Text("olasodiq604.com",
                          style: subtitleTextStyle),
                    ),
                  ),
                  dividerSmall,

                  Container(
                    margin: marginBottom40,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                          child: Text("Thank you so much for your patronage. We really appreciate it.",
                          style: subtitleTextStyle),
                    ),
                  ),

                  dividerSmall,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
