import 'package:qrcode_test/Models/Model.dart';

import 'Order.dart';
import 'Product.dart';

class Bundle {
  int id;
  Order order;
  Product product;
  int amount;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  Bundle({this.id, this.order, this.product, this.amount});

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'],
      order: json['order'],
      product: json['product'],
      amount: json['amount'],
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////
  static Future<Bundle> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("bundles", "id", id);
    if (fetchedData != null) {
      return Bundle.fromJson(fetchedData);
    } else {
      return null;
    }
  }
}
