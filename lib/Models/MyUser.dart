import 'package:flutter/foundation.dart';
import 'Model.dart';

class MyUser extends ChangeNotifier {
  final int id;
  final String username;
  final String email;
  final String phoneNumber;
  final String photoURL;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  MyUser({this.id, this.username, this.email, this.phoneNumber, this.photoURL});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['password'],
    );
  }

  factory MyUser.fromJsonFillGoogle(dynamic googleUser) {
    return MyUser(
      id: googleUser.uid,
      username: googleUser.displayName,
      email: googleUser.email,
      phoneNumber: googleUser.phoneNumber,
      photoURL: googleUser.photoURL,
    );
  }

  // static Future<Map<String, dynamic>> fetchByIdFillProvider(id) async {
  //   var fetchedData = await Model.fetchByParameters("users", "id", id);
  //   if (fetchedData != null) {
  //     return fetchedData;
  //   } else {
  //     return null;
  //   }
  // }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////
  static Future<MyUser> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("users", "id", id);
    if (fetchedData != null) {
      return MyUser.fromJson(fetchedData);
    } else {
      return null;
    }
  }
}
