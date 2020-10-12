import 'dart:async';

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
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var myCartAux = Provider.of<Cart>(context, listen: true);

    return Scaffold(
      appBar: ShoppingCartAppBar(height: 90),
      body: myCartAux.bundles.isEmpty
          // Warning add something
          ? buildEmptyCartWarning()
          // Show the list
          : ListView.builder(
              controller: _scrollController,
              // reverse: true,
              itemCount: myCartAux.bundles.length,
              itemBuilder: (context, index) {
                final bundle = myCartAux.bundles[index];
                return BundleWidget(
                  bundleShowing: bundle,
                );
              },
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: _startScanning,
        ),
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
    String barcode = await scanner.scan();
    // String barcode = "8412779230601";
    // String barcode = "111112";
    // String barcode = "deisi";

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
            notifier: notifyAddProduct,
          );
        },
      );
    } else {
      // WE DO
      var myCartAux = Provider.of<Cart>(context, listen: false);
      var bundleFound = myCartAux.findByBarcode(barcode);
      if (bundleFound != null) {
        bundleFound.amount++;
        myCartAux.overrideBundle(bundleFound);
      } else {
        var newBundle = new Bundle(product: fetchedProduct, amount: 1);
        myCartAux.addBundle(newBundle);
      }
      notifyAddProduct();
    }
  }

  void notifyAddProduct() {
    var myCartAux = Provider.of<Cart>(context, listen: false);

    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text('Producto añadido al carrito'),
    );

    Scaffold.of(context).showSnackBar(snackBar);

    if (myCartAux.bundles.length > 1) {
      Timer(
        Duration(milliseconds: 100),
        () => {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          )
        },
      );
    }
  }
}
