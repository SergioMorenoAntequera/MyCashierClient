import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HistoryViewAppBar.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HistoryViewAppBar(height: 90),
      body: Column(
        children: [
          Center(child: Text("u in boy")),
          RaisedButton(
            child: Text("salir"),
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}

// What shows when u are not logged in
class NotLogedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HistoryViewAppBar(height: 90),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aquí puedes ver todas tus compras",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text("Pero para verlas tienes que guardar iniciar sesión\n"),
          RaisedButton(
            child: Text("PRA"),
            onPressed: () => {FirebaseAuth.instance.signOut()},
          ),
        ],
      ),
    );
  }
}
