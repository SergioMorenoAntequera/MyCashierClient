import 'package:qrcode_test/Models/Model.dart';

class Token {
  int id;
  String userId;
  String token;
  String type;
  bool isRevoken;

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

  Future<Token> createRandomToken() async {
    var newToken = await Model.create("tokens", this);
    return Token.fromJsonDatabase(newToken);
  }
}
