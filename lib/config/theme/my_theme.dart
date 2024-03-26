import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/my_shared_pref.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static getThemeData({required bool isLight}){
    return ThemeData(
        useMaterial3: true,
        // main color (app bar,tabs..etc)
        primaryColor: isLight ? LightThemeColors.primaryColor : DarkThemeColors.primaryColor,
        primaryColorLight: isLight ? LightThemeColors.primaryColorLight : DarkThemeColors.primaryColorLight,
        primaryColorDark: isLight ? LightThemeColors.primaryColorDark : DarkThemeColors.primaryColorDark,
        // secondary color (for checkbox,float button, radio..etc)
        accentColor: isLight ? LightThemeColors.accentColor : DarkThemeColors.accentColor,
        // color contrast (if the theme is dark text should be white for example)
        brightness: isLight ? Brightness.light : Brightness.dark,
        // canvas Color
        canvasColor: isLight ? LightThemeColors.canvasColor : DarkThemeColors.canvasColor,
        // card widget background color
        cardColor: isLight ? LightThemeColors.cardColor : DarkThemeColors.cardColor,
        // hint text color
        hintColor: isLight ? LightThemeColors.hintTextColor : DarkThemeColors.hintTextColor,
        // divider color
        dividerColor: isLight ? LightThemeColors.dividerColor : DarkThemeColors.dividerColor,
        // app background color
        backgroundColor: isLight ? LightThemeColors.backgroundColor : DarkThemeColors.backgroundColor,
        scaffoldBackgroundColor: isLight ? LightThemeColors.scaffoldBackgroundColor : DarkThemeColors.scaffoldBackgroundColor,

        // progress bar theme
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: isLight ? LightThemeColors.primaryColor : DarkThemeColors.primaryColor,
        ),

        // appBar theme
       

        // icon theme
        iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),
    );
  }

  /// update app theme and save theme type to shared pref
  /// (so when the app is killed and up again theme will remain the same)

}