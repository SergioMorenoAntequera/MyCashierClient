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
  );

  // Add app themes rules here like so:
  var mainTheme = new ThemeData(
    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    backgroundColor: Colors.white,
    accentColor: Color(0xff4790FF),

    // Adding the text theme
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    accentTextTheme: textTheme,
  );

  return mainTheme;
}
