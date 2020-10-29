import 'package:flutter/foundation.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Models/Order.dart';
import 'Order.dart';

class History extends ChangeNotifier {
  List<Order> orders;

  History({this.orders});

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
    if (this.findOrder(orderToAdd) != null) return;

    orders.insert(0, orderToAdd);
    notifyListeners();
  }

  changeAll(List<Order> ordersToAdd) {
    this.orders = ordersToAdd;
    notifyListeners();
  }

  getListAndUpdate(MyUser myUser) async {
    var myOrders = await myUser.orders();
    this.changeAll(myOrders.reversed.toList());
  }

  findOrder(Order orderToFind) {
    orders.forEach((order) {
      if (order == orderToFind) {
        return order;
      }
    });
    return null;
  }

  findById(Order orderToFind) {
    this.orders.forEach((Order order) {
      if (order.id == orderToFind.id) {
        return order;
      }
    });
    return null;
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

  removeAllOrders() {
    orders.clear();
  }
}
