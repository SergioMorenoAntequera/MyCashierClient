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
        children: [
          Text(bundle.amount.toString()),
          Text(bundle.product.name + " / "),
          Text(bundle.product.price.toString()),
          Text((bundle.product.price * bundle.amount).toString()),
        ],
      ),
    );
  }
}
