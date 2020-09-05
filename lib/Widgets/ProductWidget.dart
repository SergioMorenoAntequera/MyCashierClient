import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Product.dart';

class ProductWidget extends StatelessWidget {
  final Product productShowing;
  final Key key;

  const ProductWidget({this.key, this.productShowing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(productShowing.name),
    );
  }
}
