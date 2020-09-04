import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Product.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'Models/Product.dart';
// import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String qrCodeValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cashier woooo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Presiona el botón para escanear'),
            Text("$qrCodeValue"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
        tooltip: 'Increment',
        child: Icon(Icons.add_to_home_screen),
      ),
    );
  }

  void test() async {
    var product =
        Product(id: null, barcode: "BARCODEAHI", name: "FLUTTER", price: 1.8);
    // print(product.barcode.toString());
    product = await product.create();

    setState(() {
      // qrCodeValue =
    });
  }

  Future _scan() async {
    String cameraScanResult = await scanner.scan();
    setState(() {
      qrCodeValue = cameraScanResult;
    });
  }
}
