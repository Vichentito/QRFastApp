import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qrfastapp/src/models/product_model.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  static final String routeName = 'product';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductsBloc productsBloc;

  ProductModel product = new ProductModel();

  bool _guardando = false;

  File photo;

  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.productsBloc(context);
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      product = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearId(),
                _crearNombre(),
                _crearPrecio(),
                _crearDescripcion(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: product.name,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
      onSaved: (value) => product.name = value,
      
    );
  }

  Widget _crearId() {
    return TextFormField(
      initialValue: product.idProduct.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(
        labelText: 'Id de producto'
      ),
      validator: (value) {
        if ( value.length < 0 ) {
          return 'Ingrese el id del producto';
        } else {
          return null;
        }
      },
      onSaved: (value) => product.idProduct = int.parse(value),
      
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      initialValue: product.description,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripcion'
      ),
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese la descripcion del producto';
        } else {
          return null;
        }
      },
      onSaved: (value) => product.description = value,
      
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => product.price = double.parse(value),
      validator: (value) {
        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: ( _guardando ) ? null : _submit,
    );
  }

  _mostrarFoto() {
    if (product.image != null) {
      return FadeInImage(
        image: NetworkImage( product.image ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if( photo != null ){
        return Image.file(
          photo,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  void _submit() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    setState(() {_guardando = true; });
    //print("Nombre: ${product.name}, Precio: ${product.price}, Descripcion: ${product.description},Descripcion: ${product.idProduct}");
    if ( photo != null ) {
      String imageUrl = await productsBloc.subirFoto(photo,product.name);
      product.image = imageUrl;
    }
    if ( product.id == null ) {
      productsBloc.agregarProducto(product);
    }else {
      productsBloc.editarProducto(product);
    }
    setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _seleccionarFoto() async {
    _processImage( ImageSource.gallery );
  }
  
  _tomarFoto() async {
    _processImage( ImageSource.camera );
  }

  _processImage(ImageSource origin) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: origin,
    );
    photo = File(pickedFile.path);
    if (photo != null) {
      product.image = null;
    }
    setState(() {});
  }
}