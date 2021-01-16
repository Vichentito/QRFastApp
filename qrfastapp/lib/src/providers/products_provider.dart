
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:http/http.dart' as http;
import 'package:qrfastapp/src/models/productToBuy_model.dart';
import 'package:qrfastapp/src/models/product_model.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';

class ProductsProvider {

  final String _url = 'https://qrfast-ef149-default-rtdb.firebaseio.com';
  final _prefs = new UserPreferences();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> crearProducto( ProductModel product ) async {
    final url = '$_url/products.json?auth=${ await auth.currentUser.getIdToken() }';
    await http.post( url, body: productModelToJson(product) );
    //final decodedData = json.decode(resp.body);
    //print( decodedData );
    return true;

  }

  Future<bool> editarProducto( ProductModel product ) async {
    final url = '$_url/products/${ product.id }.json?auth=${ await auth.currentUser.getIdToken() }';
    await http.put( url, body: productModelToJson(product) );
    //final decodedData = json.decode(resp.body);
    //print( decodedData );
    return true;
  }

  Future<ProductToBuyModel> getOneProduct(int idProduct ) async {
    List<ProductModel> products = await cargarProductos();
    ProductToBuyModel product;
    products.forEach((element) {
      if(element.idProduct == idProduct){
       product = ProductToBuyModel(
         id: element.id,idProduct: element.idProduct,description: element.description,
         image: element.image, name: element.name,price: element.price
       );
      }
    });
    //print( decodedData );
    return product;

  }

  Future<List<ProductModel>> cargarProductos() async {
    final url  = '$_url/products.json?auth=${ await auth.currentUser.getIdToken() }';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    //print(decodedData);
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
    final url  = '$_url/products/$id.json?auth=${ await auth.currentUser.getIdToken() }';
    await http.delete(url);
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

