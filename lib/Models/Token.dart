import 'package:qrcode_test/Models/Model.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  int id;
  String userId;
  String token;
  String type;
  int isRevoked;

  Token({this.id, this.userId, this.token, this.type, this.isRevoked});

  factory Token.defaultToken(MyUser user) {
    return Token(
      id: null,
      userId: user.id,
      token: user.id,
      type: "user",
      isRevoked: 0,
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      userId: json['userId'],
      token: json['token'],
      type: json['type'],
      isRevoked: json['isRevoked'],
    );
  }

  factory Token.fromJsonDatabase(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      userId: json['user_id'],
      token: json['token'],
      type: json['type'],
      isRevoked: json['is_revoked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'user_id': this.userId,
      'token': this.token,
      'type': this.type,
      'is_revoked': this.isRevoked,
    };
  }

  Map<String, dynamic> toJsonDatabase() {
    return {
      'id': this.id,
      'user_id': this.userId,
      'token': this.token,
      'type': this.type,
      'is_revoked': this.isRevoked,
    };
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////
  Future<Token> createInDatabase() async {
    var newToken = await Model.create("tokens", this);
    await this.createInStorage();
    return Token.fromJsonDatabase(newToken);
  }

  static Future<Token> checkInDatabase(MyUser user) async {
    var tokens = await Model.fetchRelationship("users", user.id, "tokens");
    if (tokens.length == 0) return null;

    var fetchedToken = Token.fromJsonDatabase(tokens.last);
    if (fetchedToken.isRevoked == 0) {
      return fetchedToken;
    } else {
      return null;
    }
  }

  Future<void> createInStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", this.userId);
  }

  static Future<String> checkInStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<String> checkAndCreateEverything(MyUser user) async {
    var token = await checkInStorage();

    if (token == null) {
      var tokenDatabase = await checkInDatabase(user);
      if (tokenDatabase != null) token = tokenDatabase.token;
    }

    if (token == null) {
      token = (await Token.defaultToken(user).createInDatabase()).token;
    }
    return token;
  }
}
