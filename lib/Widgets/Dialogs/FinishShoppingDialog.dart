import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:qrcode_test/Models/User.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FinishShoppingDialog extends StatefulWidget {
  final BuildContext context;

  FinishShoppingDialog({this.context});

  @override
  _FinishShoppingDialogState createState() => _FinishShoppingDialogState();
}

class _FinishShoppingDialogState extends State<FinishShoppingDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Se acabaron los tickets sueltos",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "\nEsto guardará para que puedas verla cuando quieras y más!",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "\nSolo tienes que iniciar sesión o ",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
      actions: [
        RaisedButton(
          onPressed: () => {Navigator.pop(context)},
          child: Text(
            "No, falta algo",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        RaisedButton(
          onPressed: _createNewOrder,
          child: Text("Sí, está todo"),
        ),
      ],
    );
  }

  // Create product in database
  void _createNewOrder() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        var userCredential = signInWithGoogle();
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
