import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import '../../Widgets/Dialogs/FinishShoppingDialog.dart';
import '../../Widgets/Dialogs/FinishShoppingDialogLogin.dart';

class ShoppingCartAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const ShoppingCartAppBar({Key key, @required this.height}) : super(key: key);

  @override
  _ShoppingCartAppBarState createState() => _ShoppingCartAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _ShoppingCartAppBarState extends State<ShoppingCartAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 21),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 5, // soften the shadow
                    spreadRadius: 5, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
              // MAIN ROW
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TOTAL PRICE
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Consumer<Cart>(
                      builder: (context, cart, child) {
                        var value = cart.getTotalPrice().toStringAsFixed(2);
                        return Text(
                          "$value€",
                          style: Theme.of(context).textTheme.headline1,
                        );
                      },
                    ),
                  ),
                  // Finish shopping Button
                  FinishShoppingButton()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FinishShoppingButton extends StatelessWidget {
  const FinishShoppingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      child: Provider.of<Cart>(context, listen: true).bundles.length > 0
          ? RaisedButton(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              color: Colors.black,
              child: Text(
                "Terminar compra",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onPressed: () => {
                _finishShopping(context),
              },
            )
          : Container(),
    );
  }

  _finishShopping(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FinishShoppingDialog(context: context);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FinishShoppingDialogLogin(context: context);
        },
      );
    }
  }
}
