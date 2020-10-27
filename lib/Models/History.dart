import 'package:flutter/foundation.dart';
import 'package:qrcode_test/Models/Order.dart';
import 'Order.dart';

class Cart extends ChangeNotifier {
  List<Order> orders;

  Cart({this.orders});

  double getTotalPrice() {
    double totalPrice = 0;
    if (orders.isNotEmpty) {
      orders.forEach((order) {
        totalPrice += order.totalPrice * order.totalPrice;
      });
    }
    return totalPrice;
  }

  addOrder(Order orderToAdd) {
    Order foundOrder = this.findOrder(orderToAdd);
    orders.add(orderToAdd);
    notifyListeners();
  }

  findOrder(Order orderToFind) {
    var orderFound;

    orders.forEach((order) {
      if (order == orderToFind) {
        return orderFound;
      }
    });
    return;
  }

  removeOrder(Order orderToRemove) {
    Order foundOrder = this.findOrder(orderToRemove);
    if (foundOrder != null) {
      orders.remove(orderToRemove);
    } else {
      return null;
    }
    notifyListeners();
  }
}
