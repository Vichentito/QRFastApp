import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qrfastapp/src/models/cart_model.dart';
import 'package:qrfastapp/src/models/productToBuy_model.dart';
import 'package:qrfastapp/src/providers/products_provider.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 0,
      icon: Icon(Icons.attach_money),
      label: Text("Pagar"),
      onPressed: () async{ 
      },
    );
  }
}