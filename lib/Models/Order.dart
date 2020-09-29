import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';

import 'Bundle.dart';
import 'MyUser.dart';

class Order {
  int id;
  MyUser user;
  double totalPrice;
  List<Bundle> bundles;

  Order({
    this.id,
    this.user,
    this.totalPrice,
    this.bundles,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['userId'],
      totalPrice: json['totalPrice'],
      bundles: json['bundles'],
    );
  }

  factory Order.fromJsonDatabase(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user_id'],
      totalPrice: json['total_price'],
    );
  }

  factory Order.fromGlobalInfo(context) {
    var newOrder = new Order();
    var myUser = MyUser.fromGoogle(FirebaseAuth.instance.currentUser);
    var myCart = Provider.of<Cart>(context, listen: false);
    var totalPrice = 0.0;
    for (var i = 0; i < myCart.bundles.length; i++) {
      totalPrice += myCart.bundles[i].product.price * myCart.bundles[i].amount;
    }

    newOrder.user = myUser;
    newOrder.bundles = myCart.bundles;
    newOrder.totalPrice = totalPrice;

    return newOrder;
  }
}
