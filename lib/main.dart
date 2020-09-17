import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/Cart.dart';
import 'package:qrcode_test/Models/User.dart';
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
        ChangeNotifierProvider(builder: (context) => User()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
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
        home: new FirebaseError(),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return new MaterialApp(
        title: "My Cashier",
        theme: defaultTheme,
        home: new FirebaseLoading(),
      );
    }

    return new MaterialApp(
      title: "My Cashier",
      theme: defaultTheme,
      home: new Controller(),
    );
  }
}
