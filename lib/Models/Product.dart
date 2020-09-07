import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  int id;
  String barcode;
  String name;
  double price;

  Product({this.id, this.barcode, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      barcode: json['barcode'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  static Future<Product> fetchById(id) async {
    dynamic config = await getHostConfig();

    final response = await http.get(config['host'] +
        ":" +
        config['port'] +
        "/products/id/" +
        id.toString());

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var fetchedProduct = Product.fromJson(jsonData[0]);
      return fetchedProduct;
    } else {
      throw Exception('Failed to load the product');
    }
  }

  static Future<Product> fetchByBarcode(barcode) async {
    dynamic config = await getHostConfig();

    final response = await http.get(config['host'] +
        ":" +
        config['port'] +
        "/products/barcode/" +
        barcode.toString());

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData.length == 0) {
        return null;
      } else {
        var fetchedProduct = Product.fromJson(jsonData[0]);
        return fetchedProduct;
      }
    } else {
      throw Exception('Failed to load the product');
    }
  }

  static Future<Product> all() async {
    final response = await http.get('http://192.168.1.78:3001/products');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var fetchedProduct = Product.fromJson(jsonData[0]);
      return fetchedProduct;
    } else {
      throw Exception('Failed to load the product');
    }
  }

  Future<Product> create() async {
    final response = await http.post(
      'http://192.168.1.78:3001/products/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': this.id,
        'barcode': this.barcode,
        'name': this.name,
        'price': this.price,
      }),
    );

    if (response.statusCode == 201) {
      // Todo cool
      var jsonData = json.decode(response.body);
      var createdProduct = Product.fromJson(jsonData);
      return createdProduct;
    } else {
      // Todo bad
      throw Exception('Failed to load album');
    }
  }

  // Esto hjay que moverlo a model
  static getHostConfig() async {
    String host =
        await rootBundle.loadString('assets/config/HostConnection.json');
    return json.decode(host);
  }
}
