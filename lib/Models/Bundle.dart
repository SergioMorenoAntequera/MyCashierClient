// import 'package:qrcode_test/Models/Model.dart';
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
      orderId: json['orderId'],
      productId: json['productId'],
      amount: json['amount'].toDouble(),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////

}
