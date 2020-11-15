import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_test/Models/History.dart';
import 'package:qrcode_test/Models/MyUser.dart';
import 'package:qrcode_test/Widgets/OrderWidget.dart';
import 'package:qrcode_test/Widgets/MonthlyPriceTagWidget.dart';

class HistoryView extends StatefulWidget {
  final Function checkSession;

  HistoryView(this.checkSession);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  MyUser myUser = MyUser.fromGoogle(FirebaseAuth.instance.currentUser);

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      widget.checkSession();
    });

    var orders = Provider.of<History>(context, listen: true).orders;
    var prevMonth = 0;

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        if (order.createdAt.month != prevMonth || index == 0) {
          prevMonth = order.createdAt.month;
          var newMonth = OrderWidget.formatDate(order);
          newMonth = newMonth.substring(newMonth.indexOf(" ") + 1);

          var monthPrice = 0.0;
          for (int i = index; i < orders.length; i++) {
            if (orders[i].createdAt.month == prevMonth) {
              monthPrice += orders[i].totalPrice;
            } else {
              break;
            }
          }

          return Column(
            children: [
              SizedBox(height: 20),
              MonthlyPriceTagWidget(newMonth, monthPrice),
              OrderWidget(order),
            ],
          );
        } else {
          return OrderWidget(order);
        }
      },
    );
  }

  getAllOrders() async {
    Provider.of<History>(context, listen: false).getListAndUpdate(myUser);
    // Provider.of<History>(context, listen: false).removeAllOrders();
  }
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// What shows when u are not logged in ///////////////////////////////////////
class NotLoggedIn extends StatelessWidget {
  final Function checkSession;

  NotLoggedIn(this.checkSession);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      checkSession();
    });

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aquí podrás ver todas tus compras\n",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30),
            child: Text(
              "Para poder verlas tienes\nque iniciar sesión",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            child: Text("ENTRAR CON GOOGLE"),
            onPressed: () => {MyUser.loginOrRegister(context)},
          ),
        ],
      ),
    );
  }
}
