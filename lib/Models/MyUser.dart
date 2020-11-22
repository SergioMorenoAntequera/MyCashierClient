import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/History.dart';
import 'package:qrcode_test/Models/Order.dart';
import 'package:qrcode_test/Models/Token.dart';

import 'Model.dart';

class MyUser {
  final String id;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoURL;

  ////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTORS ////////////////////////////////////////////////////////////
  MyUser({
    this.id,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      id: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
    );
  }

  factory MyUser.fromJsonDatabase(Map<String, dynamic> json) {
    return MyUser(
      id: json['id'],
      displayName: json['display_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      photoURL: json['photo_url'],
    );
  }

  factory MyUser.fromGoogle(dynamic googleUser) {
    return MyUser(
      id: googleUser.uid,
      displayName: googleUser.displayName,
      email: googleUser.email,
      phoneNumber: googleUser.phoneNumber,
      photoURL: googleUser.photoURL,
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  // METHODS /////////////////////////////////////////////////////////////////

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'displayName': this.displayName,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'photoURL': this.photoURL,
    };
  }

  Map<String, dynamic> toJsonDatabase() {
    return {
      'id': this.id,
      'display_name': this.displayName,
      'email': this.email,
      'phone_number': this.phoneNumber,
      'photo_url': this.photoURL,
    };
  }

  Future<List> orders() async {
    var fetchedOrders =
        await Model.fetchRelationship("users", this.id, "orders");

    List<Order> formatedOrders = new List();

    for (var fetchedOrder in fetchedOrders) {
      var orderFetch = await Order.fromJsonDatabaseWithUser(fetchedOrder, this);
      formatedOrders.add(orderFetch);
    }

    return formatedOrders;
  }

  Future<List> ordersLastMoth() async {
    var fetchedOrders =
        await Model.fetchRelationship("users", this.id, "orders");

    List<Order> formatedOrders = new List();

    for (var fetchedOrder in fetchedOrders) {
      Order orderFetch =
          await Order.fromJsonDatabaseWithUser(fetchedOrder, this);
      var today = DateTime.now();
      if (orderFetch.createdAt
          .isAfter(DateTime(today.year, today.month - 1, today.day))) {
        formatedOrders.add(orderFetch);
      }
    }

    return formatedOrders;
  }

  static Future<MyUser> fetchById(id) async {
    var fetchedData = await Model.fetchByParameters("users", "id", id);
    if (fetchedData != null) {
      return MyUser.fromJsonDatabase(fetchedData);
    } else {
      return null;
    }
  }

  Future<MyUser> create() async {
    var newUser = await Model.create("users", this);
    return MyUser.fromJsonDatabase(newUser);
  }

  //  SESSION STUFF ///////////////////////////////
  static Future<UserCredential> _signInWithGoogle() async {
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

  static Future<MyUser> loginOrRegister(context) async {
    // Check user
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      //Not logged in
      var userCredential = await MyUser._signInWithGoogle();

      var fetchedUser = await MyUser.fetchById(userCredential.user.uid);
      if (fetchedUser != null) {
        // User registered Log in
        Token.checkandCreateEverything(fetchedUser);

        return fetchedUser;
      } else {
        // User not registered, register and logged in
        var myUser = MyUser.fromGoogle(userCredential.user);
        Provider.of<History>(context, listen: false).getListAndUpdate(myUser);
        await myUser.create();
        await Token.defaultToken(myUser).createInDatabase();
        return myUser;
      }
    } else {
      // Logged in
      var myUser = MyUser.fromGoogle(user);
      Provider.of<History>(context, listen: false).getListAndUpdate(myUser);
      Token.checkandCreateEverything(myUser);

      return myUser;
    }
  }
}
