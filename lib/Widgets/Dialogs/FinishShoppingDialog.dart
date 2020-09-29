import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:qrcode_test/Models/User.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Models/Order.dart';

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
              "\nAquí puedes gardar los tickets para verlos cuando quieras y más!",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "\nInicia sesión con google para empezar.",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => {Navigator.pop(context)},
          child: Text("Cancelar", style: Theme.of(context).textTheme.bodyText1),
        ),
        RaisedButton(
          onPressed: _loginOrRegister,
          child: Text("Iniciar Sesión"),
        ),
      ],
    );
  }

  // Create product in database
  void _loginOrRegister() async {
    // Check user
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User not logged in, checking or creating new one
      var userCredential = await signInWithGoogle();

      var fetchedUser = await MyUser.fetchById(userCredential.user.uid);
      if (fetchedUser == null) {
        await MyUser.fromGoogle(userCredential.user).create();
      }
    } else {
      // Create the order and the bundles in the database
      var newOrder = Order.fromGlobalInfo(context);
      print(newOrder.totalPrice);

      // Show modal or breadcrum telling people to go to History menu

    }
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
