import 'package:qrcode_test/Models/Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  int id;
  String barcode;
  String name;
  double price;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  Product({this.id, this.barcode, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      barcode: json['barcode'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////
  static Future<Product> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("products", "id", id);
    if (fetchedData != null) {
      return Product.fromJson(fetchedData);
    } else {
      return null;
    }
  }

  static Future<Product> fetchByBarcode(barcode) async {
    var fetchedData =
        await Model.fetchByParameters("products", "barcode", barcode);
    if (fetchedData != null) {
      return Product.fromJson(fetchedData);
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> all() async {
    var fetchedData = await Model.all("products");
    List<dynamic> productList = [];
    fetchedData.forEach((element) {
      productList.add(new Product.fromJson(element));
    });
    return productList;
  }

  Future<Product> create() async {
    var hostConfig = await Model.getHostConfig();
    var url = 'http://' + hostConfig['host'] + ":" + hostConfig['port'];

    final response = await http.post(url + '/products',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': this.id,
          'barcode': this.barcode,
          'name': this.name,
          'price': this.price,
        }));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Todo cool
      var jsonData = json.decode(response.body);
      var createdProduct = Product.fromJson(jsonData);
      return createdProduct;
    } else {
      // Todo bad
      print(response.statusCode);
      throw Exception('Failed to load album');
    }
  }
}
