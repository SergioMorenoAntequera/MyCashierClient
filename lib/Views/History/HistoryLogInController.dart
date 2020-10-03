import 'package:firebase_auth/firebase_auth.dart';
import 'package:qrcode_test/Views/History/HistoryView.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_test/Views/History/HistoryViewAppBar.dart';

class HistoryLoginController extends StatefulWidget {
  HistoryLoginController({Key key}) : super(key: key);

  @override
  _HistoryLoginControllerState createState() => _HistoryLoginControllerState();
}

class _HistoryLoginControllerState extends State<HistoryLoginController> {
  bool loggedIn = true;

  @override
  Widget build(BuildContext context) {
    checkSession();

    return Scaffold(
      appBar: HistoryViewAppBar(height: 90),
      body: loggedIn ? HistoryView(checkSession) : NotLoggedIn(checkSession),
    );
  }

  checkSession() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (this.mounted) {
        setState(() {
          loggedIn = false;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
          loggedIn = true;
        });
      }
    }
  }
}
