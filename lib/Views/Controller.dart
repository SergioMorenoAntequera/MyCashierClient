import 'package:flutter/material.dart';
import 'package:qrcode_test/Views/History/HistoryLogInController.dart';
import 'package:qrcode_test/Views/UserProfile/UserProfile.dart';
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
    UserProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*if (FirebaseAuth.instance.currentUser != null) {
      Provider.of<History>(context, listen: false).getListAndUpdate(
          MyUser.fromGoogle(FirebaseAuth.instance.currentUser));
    }*/

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
