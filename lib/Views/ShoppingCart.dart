import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import 'package:qrcode_test/Views/ShoppingCartAppBar.dart';
import 'package:qrcode_test/Widgets/BundleWidget.dart';
import '../Widgets/Dialogs/AddProductDialog.dart' as dialogs;
import 'package:qrscan/qrscan.dart' as scanner;

import '../Models/Product.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var _inTheTrolley = <Bundle>[];
  double _totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        totalPrice: _totalPrice,
        height: 90,
      ),
      body: ListView.builder(
        itemCount: _inTheTrolley.length,
        itemBuilder: (context, index) {
          final bundle = _inTheTrolley[index];
          return new BundleWidget(
            bundleShowing: bundle,
            addToTotal: addToTotal,
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
    String barcode = "8412779230601";

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
      var newBundle = new Bundle(product: fetchedProduct, amount: 1);
      addToTrolley(newBundle);
    }
  }

  addToTrolley(Bundle newBundle) {
    setState(() {
      _inTheTrolley.add(newBundle);
      _totalPrice += newBundle.product.price;
    });
  }

  addToTotal(double priceToAdd) {
    setState(() {
      this._totalPrice += priceToAdd;
    });
  }
}
