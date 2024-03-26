
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class MainButtonxx extends StatelessWidget {
  const MainButtonxx({
    required this.title,
    required this.tapEvent,
    required this.color,
  });

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        tapEvent();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 44, vertical: 15),
        decoration:  BoxDecoration(
          border: Border.all(color: Colors.black87),
        ),
        child: Text(

          title,
          style: TextStyle(

            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class MainButton2 extends StatelessWidget {
  const MainButton2({
    required this.title,
    required this.tapEvent,
    required this.color,
  });

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        tapEvent();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration:  BoxDecoration(
          border: Border.all(color: Colors.black87),
        ),
        child: Center(
          child: Text(

            title,
            textAlign: TextAlign.start,

            style: GoogleFonts.marcellus(
                textStyle: const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

class MainButton3 extends StatelessWidget {
  const MainButton3({
    required this.title,
    required this.tapEvent,
    required this.size,

    required this.color,
  });

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        tapEvent();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 15),
        decoration:  BoxDecoration(
         // border: Border.all(color: Colors.black87),
        ),
        child: Row(
          children: [

            Icon(Icons.done_all,color: Colors.white,),
            SizedBox(width: 10,),

            SizedBox(
              width: size,

              child: Text(

                title,
                textAlign: TextAlign.start,

                style: TextStyle(

                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}