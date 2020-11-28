import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/History.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Views/UserProfile/UserProfileAppBar.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserProfileAppBar(),
      body: Center(
        child: RaisedButton(
          child: Text("Sign Out"),
          onPressed: () => {_signOut(context)},
        ),
      ),
    );
  }
}

_signOut(context) {
  FirebaseAuth.instance.signOut();
  Provider.of<History>(context, listen: false).removeAllOrders();
}
