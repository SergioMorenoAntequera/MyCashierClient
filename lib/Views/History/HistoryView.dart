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
      body: Center(
        child: Text("VISTA DE HISTORIAL"),
      ),
    );
  }
}
