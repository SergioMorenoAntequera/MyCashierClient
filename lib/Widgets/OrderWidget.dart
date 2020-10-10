import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/Order.dart';
import 'package:qrcode_test/Widgets/BundleInOrderWidget.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  OrderWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: 30, top: 10, bottom: 10),
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.totalPrice.toString()}€",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    _formatDate(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: RaisedButton(
                  child: Text("MÁS DETALLES"),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        ),
        Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: order.bundles.length,
            itemBuilder: (context, index) {
              final bundle = order.bundles[index];
              return BundleInOrderWidget(bundle);
            },
          ),
        ),
      ],
    );
  }

  String _formatDate() {
    var formatedDate = order.createdAt.day.toString() + " ";
    switch (order.createdAt.month) {
      case 1:
        formatedDate += "Enero";
        break;
      case 2:
        formatedDate += "Febrero";
        break;
      case 3:
        formatedDate += "Marzo";
        break;
      case 4:
        formatedDate += "Abril";
        break;
      case 5:
        formatedDate += "Mayo";
        break;
      case 6:
        formatedDate += "Junio";
        break;
      case 7:
        formatedDate += "Julio";
        break;
      case 8:
        formatedDate += "Agosto";
        break;
      case 9:
        formatedDate += "Septiembre";
        break;
      case 10:
        formatedDate += "Octubre";
        break;
      case 11:
        formatedDate += "Noviembre";
        break;
      case 12:
        formatedDate += "Diciembre";
        break;
      default:
    }
    return formatedDate;
  }
}
