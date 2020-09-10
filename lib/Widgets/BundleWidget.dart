import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';

class BundleWidget extends StatefulWidget {
  final Bundle bundleShowing;
  final Key key;

  const BundleWidget({this.key, this.bundleShowing}) : super(key: key);

  @override
  _BundleWidgetState createState() => _BundleWidgetState();
}

class _BundleWidgetState extends State<BundleWidget> {
  @override
  Widget build(BuildContext context) {
    var product = widget.bundleShowing.product;
    var bundle = widget.bundleShowing;

    return ListTile(
      title: Text(product.name + " // ${bundle.amount}"),
      subtitle: Text(product.price.toString() +
          " € // ${bundle.amount * product.price} €"),
      leading: RaisedButton(
        child: Icon(Icons.remove_circle_outline),
        onPressed: () => {
          if (bundle.amount > 0)
            {
              setState(() {
                bundle.amount--;
              })
            }
        },
      ),
      trailing: RaisedButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () => {
          setState(() {
            bundle.amount++;
          })
        },
      ),
    );
  }
}
