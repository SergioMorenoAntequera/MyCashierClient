import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../Models/Product.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  String qrCodeValue = "";
  var _inTheTrolley = <Product>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My shopping cart"),
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
        child: Icon(Icons.add_to_home_screen),
        onPressed: () => {},
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  /// AUX METHODS /////////////////////////////////////////////////////////
  ///

  // Method to Scan codes
  Future _startScanning() async {
    String cameraScanResult = await scanner.scan();
    setState(() {
      qrCodeValue = cameraScanResult;
    });
  }

  // Create product in database
  void _createNewProductInDB(Product newProduct) async {
    var product = Product(
      id: null,
      barcode: newProduct.barcode,
      name: newProduct.name,
      price: newProduct.price,
    );

    product = await product.create();

    setState(() {
      qrCodeValue = "New thingy created";
    });
  }
}
