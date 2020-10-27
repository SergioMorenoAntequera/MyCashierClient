import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Models/History.dart';
import 'package:qrcode_test/themes.dart';
import 'Views/Controller.dart';
import 'Views/FirebaseError.dart';
import 'Views/FirebaseLoading.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => Cart(bundles: [])),
        ChangeNotifierProvider(builder: (context) => History(orders: [])),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return new MaterialApp(
        title: "My Cashier",
        theme: defaultTheme,
        home: FirebaseError(),
      );
    }

    if (!_initialized) {
      return new MaterialApp(
        title: "My Cashier",
        theme: defaultTheme,
        home: FirebaseLoading(),
      );
    }

    return new MaterialApp(
      title: "My Cashier",
      theme: defaultTheme,
      home: Controller(),
    );
  }
}
