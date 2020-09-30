import 'package:flutter/material.dart';
import 'ShoppingCart/ShoppingCart.dart';
import 'History/HistoryView.dart';

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
  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  static List<Widget> _widgetOptions = <Widget>[
    ShoppingCart(),
    HistoryView(),
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
