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

  // This cant be a factory bc it cant be async
  static fromJsonDatabase(Map<String, dynamic> json) async {
    var fetchedProduct = await Product.fetchById(json['product_id']);

    return Bundle(
      id: json['id'],
      product: fetchedProduct,
      amount: json['amount'],
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // EXTRA ///////////////////////////////////////////////////////////////////
  static Future<Bundle> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("bundles", "id", id);
    if (fetchedData != null) {
      return Bundle.fromJson(fetchedData);
    } else {
      return null;
    }
  }

  // TO JSON DATABASE //////////////////////////////////////////////////////////
  Map<String, dynamic> toJsonDatabase() {
    return {
      'id': this.id,
      'order_id': this.order.id,
      'product_id': this.product.id,
      'amount': this.amount,
    };
  }

  Future<Bundle> create() async {
    var newBundle = await Model.create("bundles", this);
    return await Bundle.fromJsonDatabase(newBundle);
  }
}
