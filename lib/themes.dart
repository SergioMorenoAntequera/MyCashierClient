import 'package:flutter/material.dart';

final ThemeData defaultTheme = buildDefaultTheme();

ThemeData buildDefaultTheme() {
  // Add text theme rules here like so:
  var textTheme = new TextTheme(
    headline1: TextStyle(
      fontSize: 23,
    ),
  );

  // Add app themes rules here like so:
  var mainTheme = new ThemeData(
    primaryColor: Colors.blue,

    // Adding the text theme
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    accentTextTheme: textTheme,
  );

  return mainTheme;
}
