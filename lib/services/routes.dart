import 'package:flutter/widgets.dart';

class Routes {
  static const String home = "/";
  static const String post = "/post";
  static const String style = "style";
  static const String privacy = "privacy";
  static  String explore = "explore";
  static  String blog = "blog";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),

    );
  }
}
