import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/User.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Se acabaron los tickets sueltos",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "\nEsto guardará para que puedas verla cuando quieras y más!",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "\nSolo tienes que iniciar sesión o ",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
      actions: [
        RaisedButton(
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
  void _createNewOrder() {
    var currentUser = Provider.of<User>(context);
    if (currentUser.id == null) {
      print("You need to log in");
    } else {
      print("creando orden con los productos");
    }
  }
}
