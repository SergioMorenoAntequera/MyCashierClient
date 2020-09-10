import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    String url = "http://" + config['host'] + ":" + config['port'];
    url += "/" + table + "/" + parameter + "/" + value;

    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.body == "false") {
        return null;
      } else {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return jsonData;
      }
    } else {
      throw Exception('Error 500');
    }
  }

  static Future<List> all(table) async {
    dynamic config = await Model.getHostConfig();
    String url = "http://" + config['host'] + ":" + config['port'];
    url += "/" + table;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load the product');
    }
  }
}
