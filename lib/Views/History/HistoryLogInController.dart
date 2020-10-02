import 'package:firebase_auth/firebase_auth.dart';
import 'package:qrcode_test/Views/History/HistoryView.dart';
import 'package:flutter/material.dart';

class HistoryLoginController extends StatefulWidget {
  HistoryLoginController({Key key}) : super(key: key);

  @override
  _HistoryLoginControllerState createState() => _HistoryLoginControllerState();
}

class _HistoryLoginControllerState extends State<HistoryLoginController> {
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return loggedIn ? HistoryView(checkSession) : NotLoggedIn(checkSession);
  }

  checkSession() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        loggedIn = false;
      });
    } else {
      setState(() {
        loggedIn = true;
      });
    }
  }
}
