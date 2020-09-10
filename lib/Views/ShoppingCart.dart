import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import 'package:qrcode_test/Widgets/ProductWidget.dart';
import '../Widgets/Dialogs/AddProductDialog.dart' as dialogs;
import 'package:qrscan/qrscan.dart' as scanner;

import '../Models/Product.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    with SingleTickerProviderStateMixin {
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
        child: Icon(Icons.linked_camera),
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
    String barcode = "841006901792257ssssssssss500";

    var fetchedProduct = await Product.fetchByBarcode(barcode);

    if (fetchedProduct == null) {
      // No product found, adding new one
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new dialogs.AddProductDialog(
            context: context,
            barcodeToAdd: barcode,
            addToTrolley: addToTrolley,
          );
        },
      );
    } else {
      // Logic to show the product with this barcode
      // Create new Bundle with the product
      // var newNundle =
      addToTrolley(fetchedProduct);
    }
  }

  addToTrolley(newProduct) {
    setState(() {
      _inTheTrolley.add(newProduct);
    });
  }
}
