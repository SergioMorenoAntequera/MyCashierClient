import 'package:flutter/material.dart';
import 'themes.dart';

import 'Views/ShoppingCart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My cashier',
      theme: defaultTheme,
      home: ShoppingCart(),
    );
  }
}
