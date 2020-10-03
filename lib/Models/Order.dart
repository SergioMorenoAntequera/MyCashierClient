import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Models/Model.dart';

import 'Bundle.dart';
import 'MyUser.dart';

class Order {
  int id;
  MyUser user;
  double totalPrice;
  List<Bundle> bundles;
  DateTime createdAt;

  Order({
    this.id,
    this.user,
    this.totalPrice,
    this.bundles,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['userId'],
      totalPrice: json['totalPrice'],
      bundles: json['bundles'],
    );
  }

  // This cant be a factory bc it cant be async
  static fromJsonDatabase(Map<String, dynamic> json) async {
    var fetchedUser = await MyUser.fetchById(json['user_id']);

    return Order(
      id: json['id'],
      user: fetchedUser,
      totalPrice: json['total_price'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  static fromJsonDatabaseWithUser(Map<String, dynamic> json, user) async {
    return Order(
      id: json['id'],
      user: user,
      totalPrice: json['total_price'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  factory Order.fromGlobalInfo(context) {
    var newOrder = new Order();
    var myUser = MyUser.fromGoogle(FirebaseAuth.instance.currentUser);
    var myCart = Provider.of<Cart>(context, listen: false);
    var totalPrice = 0.0;
    for (var i = 0; i < myCart.bundles.length; i++) {
      totalPrice += myCart.bundles[i].product.price * myCart.bundles[i].amount;
      myCart.bundles[i].order = newOrder;
    }

    newOrder.user = myUser;
    newOrder.bundles = myCart.bundles;
    newOrder.totalPrice = totalPrice;

    return newOrder;
  }

  //////////////////////////////////////////////////////////////////////////////
  // EXTRA /////////////////////////////////////////////////////////////////////

  // GET BY ID /////////////////////////////////////////////////////////////////
  static Future<Order> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("orders", "id", id);
    if (fetchedData != null) {
      return Order.fromJsonDatabase(fetchedData);
    } else {
      return null;
    }
  }

  // TO JSON DATABASE //////////////////////////////////////////////////////////
  Map<String, dynamic> toJsonDatabase() {
    return {
      'id': this.id,
      'user_id': this.user.id,
      'total_price': this.totalPrice,
    };
  }

  // CREATE ////////////////////////////////////////////////////////////////////
  Future<Order> create() async {
    // The info in grabbed from ToJSONDatabase inside Model
    // To get the new ID so we can use it in the bundles
    var newOrderJSON = await Model.create("orders", this);
    Order newOrder = await Order.fromJsonDatabase(newOrderJSON);
    newOrder.bundles = this.bundles;

    // // Crear los bundles con la ip de arriba y los productos
    newOrder.bundles.forEach((bundle) async {
      bundle.order = newOrder;
      await bundle.create();
    });

    return newOrder;
  }
}
