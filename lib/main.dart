import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Models/Product.dart';
import 'themes.dart';
import 'Views/Controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => Cart(bundles: []),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My cashier',
      theme: defaultTheme,
      home: Controller(),
    );
  }
}
