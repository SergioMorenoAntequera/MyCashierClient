import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';
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
  var _inTheTrolley = <Bundle>[];
  double _totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShoppingCartAppBar(
        totalPrice: _totalPrice,
        height: 90,
      ),
      body: _inTheTrolley.isEmpty
          // Warning add something
          ? buildEmptyCartWarning()
          // Show the list
          : ListView.builder(
              itemCount: _inTheTrolley.length,
              itemBuilder: (context, index) {
                final bundle = _inTheTrolley[index];
                return BundleWidget(
                  bundleShowing: bundle,
                  changeTotal: changeTotal,
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
      //Check if it's already inside
      var foundInTrolley = false;
      _inTheTrolley.forEach((bundle) {
        if (bundle.product.barcode == barcode) {
          foundInTrolley = true;
          setState(() {
            bundle.amount++;
            _totalPrice += bundle.product.price;
          });
          return null;
        }
      });

      // Create new Bundle with the product
      if (!foundInTrolley) {
        var newBundle = new Bundle(product: fetchedProduct, amount: 1);
        addToTrolley(newBundle);
      }
    }
  }

  addToTrolley(Bundle newBundle) {
    setState(() {
      _inTheTrolley.add(newBundle);
      _totalPrice += newBundle.product.price;
    });
  }

  changeTotal(double price) {
    setState(() {
      this._totalPrice += price;
    });
  }
}
