import 'package:flutter/material.dart';
// import 'package:qrfastapp/src/widgets/menu_widget.dart';

class AccountPage extends StatefulWidget {
  static final String routeName = 'account';
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Cuenta"),
    );
  }
}