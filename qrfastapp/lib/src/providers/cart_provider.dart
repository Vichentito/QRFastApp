
import 'dart:convert';
//import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:qrfastapp/src/models/cart_model.dart';

class CartProvider {

  final String _url = 'https://qrfast-ef149-default-rtdb.firebaseio.com';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> crearCarrito( CartModel cart ) async {
    final url = '$_url/carts.json?auth=${ await auth.currentUser.getIdToken() }';
    final resp = await http.post( url, body: cartModelToJson(cart) );
    final decodedData = json.decode(resp.body);
    return decodedData['name'];
  }

  Future<CartModel> cargarCarro(String id) async {
    final url  = '$_url/carts/$id.json?auth=${await auth.currentUser.getIdToken()}';
    final resp = await http.get(url);
    final cart = cartModelFromJson(resp.body);
    return cart;
  }

  Future<CartModel> agregarProducto( String id, CartModel cart) async {
    final url = '$_url/carts/$id.json?auth=${await auth.currentUser.getIdToken() }';
    final cartUpdated = await http.put( url, body: cartModelToJson(cart) );
    final cartFinal = cartModelFromJson(cartUpdated.body);
    //final decodedData = json.decode(resp.body);
    //print( decodedData );
    return cartFinal;
  }

  Future<void> borrarProducto( String id ) async { 
    final url  = '$_url/carts/$id.json?auth=${await auth.currentUser.getIdToken()}';
    final resp = await http.delete(url);
    //print( resp.body );
  }


}

