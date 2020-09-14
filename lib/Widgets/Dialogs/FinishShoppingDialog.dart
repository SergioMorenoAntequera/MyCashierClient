import 'package:flutter/material.dart';

class FinishShoppingDialog extends StatefulWidget {
  final BuildContext context;

  FinishShoppingDialog({this.context});

  @override
  _FinishShoppingDialogState createState() => _FinishShoppingDialogState();
}

class _FinishShoppingDialogState extends State<FinishShoppingDialog> {
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
              "Perfecto! \nHas terminado de comprar?",
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
            "No, falta algo",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        RaisedButton(
          onPressed: _createNewOrder,
          child: Text("Sí, está todo"),
        ),
      ],
    );
  }

  // Create product in database
  void _createNewOrder() {}
}
