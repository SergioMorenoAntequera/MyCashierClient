import 'package:qrcode_test/Models/Model.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  int id;
  String userId;
  String token;
  String type;
  int isRevoken;

  Token({this.id, this.userId, this.token, this.type, this.isRevoken});

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
  Future<Token> create() async {
    var newToken = await Model.create("tokens", this);
    return Token.fromJsonDatabase(newToken);
  }

  static Future<Token> check(MyUser user) async {
    var tokens = await Model.fetchRelationship("users", user.id, "tokens");
    if (tokens.last.isRevoked == 0) {
      return Token.fromJsonDatabase(tokens.last);
    } else {
      return null;
    }
  }

  Future<Token> createInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", this.userId);
  }

  Future<Token> checkInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("token");
  }
}
