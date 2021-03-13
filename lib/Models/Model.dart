import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qrcode_test/Models/Token.dart';

class Model {
  // Get connection data
  static getHostConfig() async {
    var configPath = 'assets/config/HostConnection.json';
    String configContent = await rootBundle.loadString(configPath);
    Map<String, dynamic> config = jsonDecode(configContent);

    return (config);
  }

  // Get Info from database thought params
  static Future<Map<String, dynamic>> fetchByParameters(
      table, parameter, value) async {
    dynamic config = await Model.getHostConfig();
    String url = config['host'] + ":" + config['port'];
    String path = "";
    if (parameter == "id")
      path += "/" + table + "/" + value.toString();
    else
      path += "/" + table + "/" + parameter + "/" + value.toString();

    String authToken = await Token.checkInStorage();
    final response = await http.get(
      new Uri.https(url, path),
      headers: {HttpHeaders.authorizationHeader: authToken},
    );

    if (response.statusCode == 200) {
      if (response.body == "false") {
        return null;
      } else {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return jsonData;
      }
    } else {
      if (response.statusCode == 204) {
        // No content
        return null;
      } else {
        throw Exception('Error 500');
      }
    }
  }

  static Future<List> fetchRelationship(table, id, relationship) async {
    dynamic config = await Model.getHostConfig();
    String url = config['host'] + ":" + config['port'];
    String path = "/" + table + "/" + id + "/" + relationship;
    String authToken = await Token.checkInStorage();

    final response = await http.get(
      new Uri.https(url, path),
      headers: {HttpHeaders.authorizationHeader: authToken},
    );

    if (response.statusCode == 200) {
      if (response.body == "false") {
        return null;
      } else {
        var jsonData = json.decode(response.body);
        return jsonData;
      }
    } else {
      if (response.statusCode == 204) {
        // No content
        return null;
      } else {
        throw Exception('Error 500');
      }
    }
  }

  // Get all in a table
  static Future<List> all(table) async {
    dynamic config = await Model.getHostConfig();
    String url = config['host'] + ":" + config['port'];
    String path = "/" + table;
    final response = await http.get(new Uri.https(url, path));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load the product');
    }
  }

  // Create register in a table
  static Future<dynamic> create(table, object) async {
    var hostConfig = await Model.getHostConfig();
    var url = 'http://' + hostConfig['host'] + ":" + hostConfig['port'];
    String authToken = await Token.checkInStorage();

    var data;
    try {
      data = jsonEncode(object.toJsonDatabase());
    } catch (e) {
      print(
          "********* ERROR MIO LOCO *********\n A $object le falta el metodo toJsonDatabase");
    }

    final response = await http.post(
      new Uri.https(url, "/$table"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: authToken
      },
      body: data,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Todo cool
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      // Todo bad
      print(response.statusCode);
      print(data);
      throw Exception('Failed to create the new register');
    }
  }
}
