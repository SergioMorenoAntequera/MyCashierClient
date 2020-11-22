import 'package:qrcode_test/Models/Model.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  int id;
  String userId;
  String token;
  String type;
  int isRevoken;

  final storage = new FlutterSecureStorage();

  Token({this.id, this.userId, this.token, this.type, this.isRevoken});

  factory Token.newToken(MyUser user) {
    return Token(
      id: null,
      userId: user.id,
      token: user.id,
      type: "user",
      isRevoken: 0,
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      userId: json['userId'],
      token: json['token'],
      type: json['type'],
      isRevoken: json['isRevoken'],
    );
  }

  factory Token.fromJsonDatabase(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      userId: json['user_id'],
      token: json['token'],
      type: json['type'],
      isRevoken: json['is_revoken'],
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////
  Future<Token> createInDatabase() async {
    var newToken = await Model.create("tokens", this);
    await this.createInPreferences();
    return Token.fromJsonDatabase(newToken);
  }

  static Future<Token> checkInDatabase(MyUser user) async {
    var tokens = await Model.fetchRelationship("users", user.id, "tokens");
    if (tokens.last.isRevoked == 0) {
      return Token.fromJsonDatabase(tokens.last);
    } else {
      return null;
    }
  }

  Future<void> createInStorage() async {
    await storage.write(key: "token", value: this.userId);
  }

  Future<String> checkInStorage() async {
    return storage.read(key: "token");
  }
}
