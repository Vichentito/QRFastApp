//import 'dart:io';

import 'package:qrfastapp/src/models/cart_model.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/cart_provider.dart';
import 'package:rxdart/rxdart.dart';




class CartBloc {

  final _cartController = new BehaviorSubject<CartModel>();
  final _cartIdController = new BehaviorSubject<String>();

  final _cartProvider   = new CartProvider();


  Stream<CartModel> get cartStream => _cartController.stream;
  Stream<String> get cartIdStream => _cartIdController.stream;

  String get cartIdValue => _cartIdController.value;
  CartModel get cartValue => _cartController.value;

  
  final _prefs = new UserPreferences();

  void crearCarrito(CartModel cartToSave) async {
    final id = await _cartProvider.crearCarrito(cartToSave);
    _cartIdController.sink.add(id);
    _prefs.userCartId = id;
  }

  void crearCarritoFromPreferences(String id) async {
    _cartIdController.sink.add(id);
  }

  void cargarCarro() async {
    if( cartIdValue == null){
      final cart = new CartModel(date: DateTime.now(),products: List()); 
      _cartController.sink.add( cart );
    }else{
      final cart = await _cartProvider.cargarCarro(cartIdValue);
      _cartController.sink.add( cart );
    }
  }

  void actualizarCarro(CartModel cartToUpdate) async {
    final cart = await _cartProvider.agregarProducto(cartIdValue, cartToUpdate);
    _cartController.sink.add( cart );
  }

  void borrarCarro(String id)async{
    await _cartProvider.borrarProducto(id);
    final cart = new CartModel(date: DateTime.now(),products: List()); 
    _cartIdController.value = null;
    _cartController.sink.add( cart );
  }


  dispose() {
    _cartController?.close();
    _cartIdController?.close();
  }

}