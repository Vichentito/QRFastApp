import 'package:flutter/material.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class QrHomePage extends StatefulWidget {
  @override
  _QrHomePageState createState() => _QrHomePageState();
}

class _QrHomePageState extends State<QrHomePage> {
  
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${ bloc.email }'),
            Divider(),
            Text('Password: ${ bloc.password }')
          ],
      );
  }
}