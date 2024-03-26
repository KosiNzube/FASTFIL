import 'package:afrigas/screen/afrostore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


import '../../../constants.dart';
import '../card/cartCard.dart';
import '../components/DefaultButton.dart';
import '../modelspx/Offcamp.dart';
import '../modelspx/hostels.dart';
import '../modelspx/student.dart';

class CheckoutCard extends StatelessWidget {
  final double? xxx;
  final List<Hostel?> hostels;
  final List<Offcamp?> offcamps;

  final StudentData? student;
  final String? des;
   CheckoutCard({

    Key? key, this.xxx, this.student, this.des,required this.hostels,required this.offcamps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",style: TextStyle(fontSize: 15, color: Colors.black),
                    children: [
                      TextSpan(
                        text:formatAmountWithNairaSignxxx(xxx!)==0?"-----": formatAmountWithNairaSignxxx(xxx!).toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {


                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:makeOrderGas(hostels: hostels, student: student, des: des,price:xxx,offcamps:offcamps),







                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation
                            .cupertino,
                      );



                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}