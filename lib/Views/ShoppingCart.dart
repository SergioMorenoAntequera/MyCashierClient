import 'package:flutter/material.dart';
import 'package:qrcode_test/Widgets/ProductWidget.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../Widgets/Dialogs.dart' as dialogs;

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
      body: ListView.builder(
        itemCount: _inTheTrolley.length,
        itemBuilder: (context, index) {
          final product = _inTheTrolley[index];
          return ProductWidget(
            productShowing: product,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_to_home_screen),
        onPressed: () => {_startScanning()},
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  /// AUX METHODS /////////////////////////////////////////////////////////
  ///

  // Method to Scan codes
  Future _startScanning() async {
    // String barcode = await scanner.scan();
    String barcode = "111112";

    var fetchedProduct = await Product.fetchByBarcode(barcode);

    if (fetchedProduct == null) {
      // No product found, adding new one
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogs.addProductDialog;
        },
      );
    } else {
      // Logic to show the product with this barcode
      setState(() {
        _inTheTrolley.add(fetchedProduct);
      });
    }
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
