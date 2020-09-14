import 'package:flutter/material.dart';

class ShoppingCartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double totalPrice;

  const ShoppingCartAppBar({
    Key key,
    @required this.height,
    @required this.totalPrice,
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
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "${totalPrice.toStringAsFixed(2)}€",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
