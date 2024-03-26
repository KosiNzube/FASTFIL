import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    required Key key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: kBadgeColor, borderRadius: BorderRadius.circular(9)),
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
      ),
    ).addNeumorphism(
      blurRadius: mode.brightness==Brightness.dark?0: 15,
      borderRadius: mode.brightness==Brightness.dark?9: 15,
      offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
      topShadowColor: Colors.white,
      bottomShadowColor: Color(0xFF30384D).withOpacity(0.3),
    );
  }
}
