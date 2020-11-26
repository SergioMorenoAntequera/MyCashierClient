import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/History.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Views/History/HistoryLogInController.dart';
import 'ShoppingCart/ShoppingCart.dart';

class Controller extends StatefulWidget {
  Controller({Key key}) : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  /////////////////////////////////////////////////////////////////////////////
  // SESSION STUFF ////////////////////////////////////////////////////////////
  initState() {
    super.initState();
  }

  /////////////////////////////////////////////////////////////////////////////
  // NAVEGATION BAR ///////////////////////////////////////////////////////////

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ShoppingCart(),
    HistoryLoginController(),
    Center(
      child: RaisedButton(
        child: Text("Sign Out"),
        onPressed: () => {FirebaseAuth.instance.signOut()},
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_data_setting),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Usuario',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
