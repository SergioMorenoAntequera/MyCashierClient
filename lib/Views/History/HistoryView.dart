import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'HistoryViewAppBar.dart';

class HistoryView extends StatefulWidget {
  final Function checkSession;

  HistoryView(this.checkSession);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  MyUser myUser = MyUser.fromGoogle(FirebaseAuth.instance.currentUser);

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      widget.checkSession();
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("u in boy")),
        RaisedButton(
          child: Text("salir"),
          onPressed: () => {
            FirebaseAuth.instance.signOut(),
          },
        ),
        RaisedButton(
          child: Text("get orders"),
          onPressed: () async => {print(await myUser.orders())},
        ),
      ],
    );
  }

  getAllOrders() async {
    var orders = await myUser.orders();
    print(orders);
  }
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// What shows when u are not logged in ///////////////////////////////////////
class NotLoggedIn extends StatelessWidget {
  final Function checkSession;

  NotLoggedIn(this.checkSession);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      checkSession();
    });

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aquí podrás ver todas tus compras\n",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30),
            child: Text(
              "Para poder verlas tienes\nque iniciar sesión",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            child: Text("ENTRAR CON GOOGLE"),
            onPressed: () => {MyUser.loginOrRegister()},
          ),
        ],
      ),
    );
  }
}
