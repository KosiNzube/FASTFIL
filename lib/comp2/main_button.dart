
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.title,
    required this.tapEvent,
    required this.color,
  });

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    return InkWell(
      onTap: (){
        tapEvent();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 44, vertical: 15),
        decoration:  BoxDecoration(
          border: Border.all(color: mode.brightness==Brightness.dark? Colors.white:Colors.black87),
        ),
        child: Text(
          title,
          style: GoogleFonts.marcellus(
              textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600)),
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
    final ThemeData mode=Theme.of(context);


    return InkWell(
      onTap: (){
        tapEvent();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration:  BoxDecoration(
          border: Border.all(color: mode.brightness==Brightness.dark? Colors.white:Colors.black87),
        ),
        child: Center(
          child: Text(

            title,
            textAlign: TextAlign.start,
              style: GoogleFonts.marcellus(
                  textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600))

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

            Icon(Icons.done_all),
            SizedBox(width: 10,),

            SizedBox(
              width: size,

              child: Text(

                title,
                textAlign: TextAlign.start,

                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainButton4 extends StatelessWidget {
  const MainButton4({
    required this.title,
    required this.tapEvent,
    required this.color,
  });

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 60,
      child: MaterialButton(
        elevation: 0,

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        child: Stack(
          children: [
            Positioned(

              child:                  Align(
                alignment: Alignment.centerLeft,

                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Image.asset(
                    'assets/images/zand.png',
                    width: 30,
                    height: 30,

                  ),
                ),
              ),
            ),
            Center(child: Text(' Get in on Playstore ', textAlign: TextAlign.center,

              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold)),)),
          ],
        ),
        onPressed:  (){
          Uri _url = Uri.parse('https://play.google.com/apps/internaltest/4701671897735021639');
          launchUrl(_url);


        },
      ),
    );
  }
}

class MainButton5 extends StatelessWidget {
  const MainButton5({
    required this.title,
    required this.tapEvent,
    required this.color,
  });

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: MaterialButton(
        elevation: 0,

        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(45.0)),


        color: Colors.tealAccent,
        textColor: Colors.white,
        child: Stack(
          children: [
            Positioned(

              child:                  Align(
                alignment: Alignment.centerLeft,

                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Image.asset(
                    'assets/images/ios.png',
                    width: 30,
                    height: 30,

                  ),
                ),
              ),
            ),
            Center(child: Text('Get in on AppStore', textAlign: TextAlign.center,

              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold)),)),
          ],
        ),
        onPressed: () =>         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  " iOS version is not yet released. Coming soon! "),

            )),
      ),
    );
  }
}
