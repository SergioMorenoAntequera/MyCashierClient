import 'package:flutter/material.dart';

var addProductDialog = new AlertDialog(
  title: Text(":("),
  content: Text("Ayyy, justo nos falta ese producto \n ¿Podrias ayudarnos?"),
  actions: [
    RaisedButton(onPressed: () => {}, child: Text("No")),
    RaisedButton(onPressed: () => {}, child: Text("YES")),
  ],
);
