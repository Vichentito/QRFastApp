import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qrfastapp/src/models/cart_model.dart';
import 'package:qrfastapp/src/models/productToBuy_model.dart';
import 'package:qrfastapp/src/providers/products_provider.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class QrScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = ProductsProvider();
    final optProvider = Provider.opProvider(context);
    final cartProvider = Provider.cartBloc(context);
    final cartModel = new CartModel();
    StreamSubscription subscription;
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async{ 
        subscription = FlutterBarcodeScanner.scanBarcode(
          '#FF0000','Cerrar',false,ScanMode.QR,).asStream().transform(
          StreamTransformer.fromHandlers(
            handleData: (data, sink) {
              var timer;
              if (timer == null) {
                sink.add(data);
                // Set desirable interval in Duration.
                timer = Timer(Duration(seconds: 1), () {
                  timer = null;
                });
              }
            },
          ),
        ).listen((barcode) async{
          if ((barcode ?? '').isEmpty || barcode == '-1') {
            subscription.cancel();
            return;
          }
          int idProduct = int.parse(barcode.split(':')[1]);
          ProductToBuyModel product = await productsProvider.getOneProduct(idProduct);
          if(cartProvider.cartIdValue == null){
            final List<ProductToBuyModel> products = new List();
            products.add(product);
            cartModel.date = DateTime.now();
            cartModel.products = products;
            cartProvider.crearCarrito(cartModel);
            await Future.delayed(new Duration(seconds: 2));
            optProvider.changeOpt(0);
          }else{
            if(cartProvider.cartValue == null){
              cartProvider.cargarCarro();
            }
            cartModel.date = cartProvider.cartValue.date;
            final tempProducts = cartProvider.cartValue.products;
            tempProducts.add(product);
            cartModel.products = tempProducts;
            cartProvider.actualizarCarro(cartModel);
          }
          
        });
       },
    );
  }
}