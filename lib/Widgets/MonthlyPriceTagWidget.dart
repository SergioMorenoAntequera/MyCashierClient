import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthlyPriceTagWidget extends StatelessWidget {
  final String monthName;
  final double monthPrice;

  MonthlyPriceTagWidget(this.monthName, this.monthPrice);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30),
      padding: EdgeInsets.all(10),
      child: Text(
        this.monthName + " " + this.monthPrice.toString() + " €",
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
    );
  }
}
