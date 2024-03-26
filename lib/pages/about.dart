import 'package:afrigas/comp2/footer.dart';
import 'package:flutter/material.dart';

import '../components/blog.dart';
import '../components/spacing.dart';
import '../components/typography.dart';



class About extends StatelessWidget {

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
                      child: Text("ABOUT FASTFIL", style: headlineTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                          child: Text("Fastfil is a gas delivery startup that aims to relieve students of the stress of walking over long distances to refill their gas cylinders",
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
                      child: Text("Why you need to choose Fastfil",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                          child: Text("",
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
                      child: Text("How Fastfil planned to help you",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom30,
                      child: Text("",
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
