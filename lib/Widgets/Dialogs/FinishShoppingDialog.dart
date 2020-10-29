import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Models/History.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Models/Order.dart';

class FinishShoppingDialog extends StatelessWidget {
  final BuildContext context;

  FinishShoppingDialog({this.context});

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Ya estaría todo?",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            "\nEsto terminará la compra y la guardará para que la revises cuando quieras.",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            "\nTodo esto en el Historial.",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => {Navigator.pop(context)},
          child: Text("Espera!", style: Theme.of(context).textTheme.bodyText1),
        ),
        RaisedButton(
          onPressed: _createOrder,
          child: Text("Listo, guárdala"),
        ),
      ],
    );
  }

  // Create product in database
  void _createOrder() async {
    var newOrder = Order.fromGlobalInfo(context);
    newOrder = await newOrder.create();
    Provider.of<History>(context, listen: false).addOrder(newOrder);

    Navigator.pop(context);
    Provider.of<Cart>(context, listen: true).emptyCart();
  }
}
