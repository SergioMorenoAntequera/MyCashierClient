import 'package:qrcode_test/Models/Model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class Bundle {
  int id;
  int orderId;
  int productId;
  int amount;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  Bundle({this.id, this.orderId, this.productId, this.amount});

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
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
