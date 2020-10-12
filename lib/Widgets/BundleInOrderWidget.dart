import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';

class BundleInOrderWidget extends StatelessWidget {
  final Bundle bundle;

  BundleInOrderWidget(this.bundle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: Text(
              bundle.amount.toString() + " " + bundle.product.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          bundle.amount > 1
              ? Flexible(
                  flex: 2, child: Text(bundle.product.price.toString() + "€"))
              : Container(),
          Flexible(
              flex: 2,
              child: Text(
                  (bundle.product.price * bundle.amount).toString() + "€")),
        ],
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
    );
  }
}
