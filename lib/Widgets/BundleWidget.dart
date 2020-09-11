import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';

class BundleWidget extends StatefulWidget {
  final Bundle bundleShowing;
  final Key key;

  const BundleWidget({
    this.key,
    @required this.bundleShowing,
  }) : super(key: key);

  @override
  _BundleWidgetState createState() => _BundleWidgetState();
}

class _BundleWidgetState extends State<BundleWidget> {
  @override
  Widget build(BuildContext context) {
    var bundle = widget.bundleShowing;
    var product = bundle.product;

    return ListTile(
      contentPadding: EdgeInsets.all(5),
      // Delete icon
      leading: IconButton(
        onPressed: () => {},
        icon: Icon(
          Icons.delete,
          size: 50,
        ),
      ),
      //Content in the middle and Right
      title: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // MIDDLE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of product
                Padding(
                  padding: EdgeInsets.only(left: 11),
                  child: Text(
                    "${product.name}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                // Restar, sumar, cantidad
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Theme.of(context).cursorColor,
                      iconSize: 40,
                      onPressed: () => {
                        setState(() {
                          if (bundle.amount > 0) {
                            bundle.amount--;
                          } else {
                            // Show modal to confirm delete item
                          }
                        })
                      },
                    ),
                    Text(
                      "${bundle.amount}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      color: Theme.of(context).cursorColor,
                      iconSize: 40,
                      onPressed: () => {
                        setState(() {
                          bundle.amount++;
                        })
                      },
                    )
                  ],
                )
              ],
            ),
            // RIGHT
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${(product.price * bundle.amount).toStringAsFixed(2)}€",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text("${product.price.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
