import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:qrcode_test/Models/User.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qrcode_test/Models/MyUser.dart';

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
        RaisedButton(
          onPressed: () => {logOut()},
          child: Text(
            "Cancelar",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        RaisedButton(
          onPressed: _createNewOrder,
          child: Text("Iniciar Sesión"),
        ),
      ],
    );
  }

  // Create product in database
  void _createNewOrder() async {
    // Check user
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is currently signed out, Signing in!!!');
      var userCredential = await signInWithGoogle();
      var myUser = MyUser.fromGoogle(userCredential.user);
      await myUser.create();
    } else {
      print('User is signed in!');
      print(user.uid);
    }
  }

  void logOut() async {
    print("LOGING OUT");
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
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
