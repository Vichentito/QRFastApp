import 'dart:io';

import 'package:qrfastapp/src/models/productToBuy_model.dart';
import 'package:qrfastapp/src/models/product_model.dart';
import 'package:qrfastapp/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';




class ProductsBloc {

  final _productsController = new BehaviorSubject<List<ProductModel>>();
  final _productController = new BehaviorSubject<ProductToBuyModel>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _productsProvider   = new ProductsProvider();


  Stream<List<ProductModel>> get productosStream => _productsController.stream;
  Stream<ProductToBuyModel> get productoStream => _productController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarProductos() async {
    final products = await _productsProvider.cargarProductos();
    _productsController.sink.add( products );
  }

  void obtenerUno(int idProduct) async {
    final product = await _productsProvider.getOneProduct(idProduct);
    _productController.sink.add( product );
  }

  void agregarProducto( ProductModel product ) async {
    _cargandoController.sink.add(true);
    await _productsProvider.crearProducto(product);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto( File foto, String name) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productsProvider.uploadImageToFirebase(foto, name);
    _cargandoController.sink.add(false);
    return fotoUrl;
  }


   void editarProducto( ProductModel product ) async {

    _cargandoController.sink.add(true);
    await _productsProvider.editarProducto(product);
    _cargandoController.sink.add(false);

  }

  void borrarProducto( String id ) async {
    await _productsProvider.borrarProducto(id);
  }


  dispose() {
    _productsController?.close();
    _cargandoController?.close();
    _productController?.close();
  }

}