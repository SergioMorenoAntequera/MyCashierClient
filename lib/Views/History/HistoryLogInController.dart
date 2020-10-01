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
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser == null
        ? loggedIn = false
        : loggedIn = true;
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn ? HistoryView() : NotLogedIn();
  }
}
