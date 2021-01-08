import 'package:flutter/material.dart';
import 'package:qrfastapp/src/widgets/menu_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  static final String routeName = 'cart';
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Carrito"),
    );
  }
}