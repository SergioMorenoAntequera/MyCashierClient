import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'ShoppingCart/ShoppingCart.dart';
// import '../Models/User.dart';

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
    // checkSession();
  }

  // Future<void> checkSession() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // int id = (prefs.getInt('sessionId'));
  //   // if (id != null) {
  //   //   var userData = await User.fetchByIdFillProvider(id);
  //   //   Provider.of<User>(context, listen: false).fromJsonFillProvider(userData);
  //   // }
  //   FirebaseAuth.instance.authStateChanges().listen((User user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  // }

  /////////////////////////////////////////////////////////////////////////////
  // NAVEGATION BAR ///////////////////////////////////////////////////////////

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  static List<Widget> _widgetOptions = <Widget>[
    ShoppingCart(),
    Text('Index 1: Estadisticas', style: optionStyle),
    Text('Index 2: Lista de la compra', style: optionStyle),
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
            icon: Icon(Icons.list),
            label: 'Inventario',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
