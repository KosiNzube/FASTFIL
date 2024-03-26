import 'package:flutter/material.dart';

import '../comp2/Appjumbotron.dart';
import '../comp2/footer.dart';
import '../comp2/jumbotron.dart';

import '../components/side_menu.dart';



class AppScreen extends StatelessWidget {
  double _screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return AppJumbotron();
  }
}
