import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import 'package:qrcode_test/Models/Cart.dart';

class ConfirmDeleteBundleDialog extends StatefulWidget {
  final BuildContext context;
  final Bundle bundleToRemove;
  final int order;

  ConfirmDeleteBundleDialog({
    this.context,
    @required this.order,
    this.bundleToRemove,
  });

  @override
  _ConfirmDeleteBundleDialogState createState() =>
      _ConfirmDeleteBundleDialogState();
}

class _ConfirmDeleteBundleDialogState extends State<ConfirmDeleteBundleDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.order == 0
                  ? "¿Quieres borrar " +
                      widget.bundleToRemove.product.name +
                      "\nde tu lista de la compra?"
                  : "Has quitado todos estos productos.\n¿Lo quitamos de la lista?",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => {Navigator.pop(context)},
          child: Text(
            "No, quiero comprar esto",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        RaisedButton(
          onPressed: deleteBundle,
          child: Text("Sí, bórralo"),
        ),
      ],
    );
  }

  // Create product in database
  void deleteBundle() {
    Navigator.pop(context);
    Provider.of<Cart>(context, listen: false)
        .removeBundle(widget.bundleToRemove);
  }
}
