import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Models/Order.dart';

class LoginFinishShoppingDialog extends StatelessWidget {
  final BuildContext context;

  LoginFinishShoppingDialog({this.context});

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Se acabaron los tickets sueltos",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            "\nAquí puedes gardar los tickets para verlos cuando quieras y más!",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            "\nInicia sesión con google para empezar.",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => {Navigator.pop(context)},
          child: Text("Cancelar", style: Theme.of(context).textTheme.bodyText1),
        ),
        RaisedButton(
          onPressed: _loginOrRegister,
          child: Text("Iniciar Sesión"),
        ),
      ],
    );
  }

  // Create product in database
  void _loginOrRegister() async {
    await MyUser.loginOrRegister();
    var newOrder = Order.fromGlobalInfo(context);
    newOrder = await newOrder.create();

    Navigator.pop(context);
    Provider.of<Cart>(context, listen: true).emptyCart();
  }
}
