import 'package:flutter/foundation.dart';
import 'Model.dart';

class User extends ChangeNotifier {
  final int id;
  final String username;
  final String email;
  final String password;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  User({this.id, this.username, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  fromJsonFillProvider(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  static Future<Map<String, dynamic>> fetchByIdFillProvider(id) async {
    var fetchedData = await Model.fetchByParameters("users", "id", id);
    if (fetchedData != null) {
      return fetchedData;
    } else {
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////
  static Future<User> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("users", "id", id);
    if (fetchedData != null) {
      return User.fromJson(fetchedData);
    } else {
      return null;
    }
  }
}
