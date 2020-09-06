import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Product.dart';

class ProductWidget extends StatefulWidget {
  final Product productShowing;
  final Key key;

  const ProductWidget({this.key, this.productShowing}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.productShowing.name + " // $amount"),
      subtitle: Text(widget.productShowing.price.toString() +
          " € // ${amount * widget.productShowing.price} €"),
      leading: RaisedButton(
        child: Icon(Icons.remove_circle_outline),
        onPressed: () => {
          if (amount > 0)
            {
              setState(() {
                amount--;
              })
            }
        },
      ),
      trailing: RaisedButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () => {
          setState(() {
            amount++;
          })
        },
      ),
    );
  }
}
