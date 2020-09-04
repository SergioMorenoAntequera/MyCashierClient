import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Product.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

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
        title: Text("TEST CODIGO QR"),
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
        onPressed: () => {fetchProduct(2)},
        tooltip: 'Increment',
        child: Icon(Icons.add_to_home_screen),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Product> fetchProduct(int id) async {
    final response =
        await http.get('http://192.168.1.78:3001/products/' + id.toString());

    if (response.statusCode == 200) {
      var jsonTest = json.decode(response.body);
      var fetchedProduct = Product.fromJson(jsonTest[0]);
      setState(() {
        qrCodeValue = fetchedProduct.price.toString();
      });
      // print(fetchedProduct);
    } else {
      throw Exception('Failed to load the product');
    }
  }

  // Future _scan() async {
  //   String cameraScanResult = await scanner.scan();
  //   setState(() {
  //     qrCodeValue = cameraScanResult;
  //   });
  // }
}
