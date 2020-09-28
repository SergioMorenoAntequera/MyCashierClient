import 'Model.dart';

class MyUser {
  final String id;
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

  factory MyUser.fromJsonDatabase(Map<String, dynamic> json) {
    return MyUser(
      id: json['id'],
      displayName: json['display_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      photoURL: json['photo_url'],
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
      'displayName': this.displayName,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'photoURL': this.photoURL,
    };
  }

  Map<String, dynamic> toJsonDatabase() {
    return {
      'id': this.id,
      'display_name': this.displayName,
      'email': this.email,
      'phone_number': this.phoneNumber,
      'photo_url': this.photoURL,
    };
  }

  static Future<MyUser> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("users", "id", id);
    if (fetchedData != null) {
      return MyUser.fromJsonDatabase(fetchedData);
    } else {
      return null;
    }
  }

  Future<MyUser> create() async {
    var newUser = await Model.create("users", this);
    return MyUser.fromJsonDatabase(newUser);
  }
}
