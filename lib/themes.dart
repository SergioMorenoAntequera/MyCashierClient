import 'package:flutter/material.dart';

final ThemeData defaultTheme = buildDefaultTheme();

ThemeData buildDefaultTheme() {
  // Add text theme rules here like so:
  var textTheme = new TextTheme(
    headline1: TextStyle(
      fontSize: 60,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 35,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),

    // Background
    subtitle1: TextStyle(
      color: Colors.black54,
      fontSize: 35,
    ),
    subtitle2: TextStyle(
      color: Colors.black54,
      fontSize: 20,
    ),
  );

  // Add app themes rules here like so:
  var mainTheme = new ThemeData(
    // backgroundColor: Colors.white,
    backgroundColor: Color(0xffD1D1D1),

    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    buttonColor: Color(0xff747474),
    accentColor: Color(0xff4790FF),

    // Adding the text theme
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    accentTextTheme: textTheme,
  );

  return mainTheme;
}
