import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrfastapp/src/models/cart_model.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class PaymentButton extends StatefulWidget {
  @override
  _PaymentButtonState createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  bool isExtended = false;
  CartModel cart = CartModel();
  @override
  Widget build(BuildContext context) {
    final cartBloc = Provider.cartBloc(context);
    final _prefs = UserPreferences();
    return FloatingActionButton.extended(
        onPressed: (){
          cart = cartBloc.cartValue;
          double total = 0;
          cart.products.forEach((element) { total+=element.price; });
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                title: Text('Resumen de compra\nTotal: $total'),

                content: Container(
                  width: double.minPositive,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.products.length,
                    itemBuilder: (context, i){
                      return Text("${i+1}-${cart.products[i].name} x ${cart.products[i].quantity}");
                    }, 
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: ()=> Navigator.of(context).pop(),
                  ),
                  FlatButton(
                    child: Text("Pagar"),
                    onPressed: ()async {
                      cartBloc.borrarCarro(_prefs.userCartId);
                      _prefs.userCartId = '';
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
          );
          setState(() {
              isExtended = !isExtended;
            },
          );
        },
        label: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
            opacity: animation,
            child: SizeTransition(child:
            child,
              sizeFactor: animation,
              axis: Axis.horizontal,
            ),
          ) ,
          child: isExtended?
          Icon(Icons.attach_money):
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(Icons.attach_money),
              ),
              Text("Pagar")
            ],
          ),
        )
      );
  }
}