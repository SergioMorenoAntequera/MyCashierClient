import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Bundle.dart';
import '../../Widgets/Dialogs/FinishShoppingDialog.dart' as dialogs;

class ShoppingCartAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final double totalPrice;
  final List<Bundle> inTheTrolley;

  const ShoppingCartAppBar({
    Key key,
    @required this.height,
    @required this.totalPrice,
    this.inTheTrolley,
  }) : super(key: key);

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
                children: [
                  // TOTAL PRICE
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "${totalPrice.toStringAsFixed(2)}€",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  // Finish shopping Button
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 15),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  _finishShopping(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogs.FinishShoppingDialog(
          context: context,
        );
      },
    );
  }
}
