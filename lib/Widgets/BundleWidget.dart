import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'Dialogs/ConfirmDeleteBundleDialog.dart' as dialogs;

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
      leading: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10),
        child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () => {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialogs.ConfirmDeleteBundleDialog(
                  bundleToRemove: bundle,
                  context: context,
                  order: 0,
                );
              },
            )
          },
          icon: Icon(
            Icons.delete,
            size: 50,
          ),
        ),
      ),
      //Content in the middle and Right
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // MIDDLE
          Flexible(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of product
                Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Text(
                    "${product.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                // Restar, sumar, cantidad
                Row(
                  children: [
                    // REMOVE
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.remove_circle),
                      color: Theme.of(context).buttonColor,
                      iconSize: 40,
                      onPressed: () => {
                        setState(() {
                          if (bundle.amount > 0) {
                            bundle.amount--;
                            Provider.of<Cart>(context, listen: false)
                                .overrideBundle(bundle);
                          } else {
                            // Show modal to confirm delete item
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return dialogs.ConfirmDeleteBundleDialog(
                                  bundleToRemove: bundle,
                                  context: context,
                                  order: 1,
                                );
                              },
                            );
                          }
                        })
                      },
                    ),
                    Text(
                      "${bundle.amount}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    // ADD
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.add_circle),
                      color: Theme.of(context).buttonColor,
                      iconSize: 40,
                      onPressed: () => {
                        setState(() {
                          bundle.amount++;
                          Provider.of<Cart>(context, listen: false)
                              .overrideBundle(bundle);
                        })
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          // RIGHT
          Flexible(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${(product.price * bundle.amount).toStringAsFixed(2).length < 6 ? (product.price * bundle.amount).toStringAsFixed(2) : (product.price * bundle.amount).toStringAsFixed(1)}€",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    "${product.price.toStringAsFixed(2)}€",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
