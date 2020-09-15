import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Views/ShoppingCart/ShoppingCartAppBar.dart';
import 'package:qrcode_test/Widgets/BundleWidget.dart';
import '../../Widgets/Dialogs/AddProductDialog.dart' as dialogs;
import 'package:qrscan/qrscan.dart' as scanner;

import '../../Models/Product.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    var myCartAux = Provider.of<Cart>(context, listen: true);

    return Scaffold(
      appBar: ShoppingCartAppBar(
        height: 90,
      ),
      body: myCartAux.bundles.isEmpty
          // Warning add something
          ? buildEmptyCartWarning()
          // Show the list
          : ListView.builder(
              itemCount: myCartAux.bundles.length,
              itemBuilder: (context, index) {
                final bundle = myCartAux.bundles[index];
                return BundleWidget(
                  bundleShowing: bundle,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.linked_camera),
        onPressed: _startScanning,
      ),
    );
  }

  buildEmptyCartWarning() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 150),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: new Column(
              children: <Widget>[
                Text(
                  "Tu carrito está vacio",
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Escanea un código de barras para meter un producto!",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 100),
            child: Image.asset("assets/images/arrowToScan.png"),
          ),
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  /// AUX METHODS /////////////////////////////////////////////////////////

  // Method to Scan codes
  Future _startScanning() async {
    // String barcode = await scanner.scan();
    // String barcode = "8412779230601";
    // String barcode = "111112";
    String barcode = "expensive";

    var fetchedProduct = await Product.fetchByBarcode(barcode);

    // LOOKING IF WE HAVE THE PRODUCT
    if (fetchedProduct == null) {
      // WE DONT, adding new one
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
      // WE DO
      // Logic to show the product with this barcode
      //Check if it's already inside
      var myCartAux = Provider.of<Cart>(context, listen: false);
      var bundleFound = myCartAux.findByBarcode(barcode);
      if (bundleFound != null) {
        bundleFound.amount++;
        myCartAux.overrideBundle(bundleFound);
      } else {
        var newBundle = new Bundle(product: fetchedProduct, amount: 1);
        myCartAux.addBundle(newBundle);
      }
    }
  }
}
