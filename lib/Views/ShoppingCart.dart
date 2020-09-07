import 'package:flutter/material.dart';
import 'package:qrcode_test/Widgets/ProductWidget.dart';
import '../Widgets/Dialogs/AddProductDialog.dart' as dialogs;
import 'package:qrscan/qrscan.dart' as scanner;

import '../Models/Product.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
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
    String barcode = "111115";

    var fetchedProduct = await Product.fetchByBarcode(barcode);

    if (fetchedProduct == null) {
      // No product found, adding new one
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new dialogs.AddProductDialog(
            context: context,
            barcodeToAdd: barcode,
          );
        },
      );
    } else {
      // Logic to show the product with this barcode
      setState(() {
        _inTheTrolley.add(fetchedProduct);
      });
    }
  }
}
