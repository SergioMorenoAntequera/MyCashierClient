import 'package:flutter/foundation.dart';
import 'Model.dart';

class MyUser extends ChangeNotifier {
  final int id;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoURL;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  MyUser({
    this.id,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      id: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
    );
  }

  factory MyUser.fromGoogle(dynamic googleUser) {
    return MyUser(
      id: googleUser.uid,
      displayName: googleUser.displayName,
      email: googleUser.email,
      phoneNumber: googleUser.phoneNumber,
      photoURL: googleUser.photoURL,
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'barcode': this.displayName,
      'name': this.email,
      'price': this.phoneNumber,
      'photoURL': this.photoURL,
    };
  }

  static Future<MyUser> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("users", "id", id);
    if (fetchedData != null) {
      return MyUser.fromJson(fetchedData);
    } else {
      return null;
    }
  }
}
