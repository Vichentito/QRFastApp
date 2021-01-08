
import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:http/http.dart' as http;
import 'package:qrfastapp/src/models/product_model.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';

class ProductsProvider {

  final String _url = 'https://qrfast-ef149-default-rtdb.firebaseio.com';
  final _prefs = new UserPreferences();

  Future<bool> crearProducto( ProductModel product ) async {
    final url = '$_url/products.json?auth=${ _prefs.token }';
    final resp = await http.post( url, body: productModelToJson(product) );
    final decodedData = json.decode(resp.body);
    //print( decodedData );
    return true;

  }

  Future<bool> editarProducto( ProductModel product ) async {
    final url = '$_url/products/${ product.id }.json?auth=${ _prefs.token }';
    final resp = await http.put( url, body: productModelToJson(product) );
    final decodedData = json.decode(resp.body);
    //print( decodedData );
    return true;
  }

  Future<ProductModel> getOneProduct( ProductModel product ) async {
    List<ProductModel> products = await cargarProductos();
    products.forEach((element) {
      print(element);
    });
    //print( decodedData );
    return products[0];

  }

  Future<List<ProductModel>> cargarProductos() async {
    final url  = '$_url/products.json?auth=${ _prefs.token }';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = new List();
    if ( decodedData == null ) return [];

    if(decodedData['error'] != null) return [];
    //print(decodedData);
    decodedData.forEach( ( id, prod ){
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;
      products.add( prodTemp );
    });
    //print( products[0].id );
    return products;
  }


  Future<int> borrarProducto( String id ) async { 
    final url  = '$_url/products/$id.json?auth=${ _prefs.token }';
    final resp = await http.delete(url);
    //print( resp.body );
    return 1;
  }

  Future uploadImageToFirebase(File imageFile,String name) async {
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
      .ref('images/${name.toLowerCase()}.png')
      .putFile(imageFile);
    try {
      firebase_storage.TaskSnapshot snapshot = await task;
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } on firebase_core.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
  }


}

