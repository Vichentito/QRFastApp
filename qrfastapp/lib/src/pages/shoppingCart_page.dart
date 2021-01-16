import 'package:flutter/material.dart';
import 'package:qrfastapp/src/blocs/cart_bloc.dart';
import 'package:qrfastapp/src/models/cart_model.dart';
import 'package:qrfastapp/src/models/product_model.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;

class ShoppingCartPage extends StatefulWidget {
  static final String routeName = 'cart';
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
  final cartBloc = Provider.cartBloc(context);
  cartBloc.cargarCarro();

  return RefreshIndicator(
    onRefresh: refreshPage,
    color: utils.primaryLight,
    child: _crearListado(cartBloc),
  );
  }
  Widget _crearListado(CartBloc cartBloc) {
    return StreamBuilder(
      stream: cartBloc.cartStream ,
      builder: (BuildContext context, AsyncSnapshot<CartModel> snapshot){
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          if(productos.products.length == 0){
            return Center(
              child: Text("Escanea tus productos para agregarlos al carrito"),
            );
          }else{
            return ListView.builder(
              itemCount: productos.products.length,
              itemBuilder: (context, i) => _crearItem(context,cartBloc,productos.products[i] ),
            );
          }
        } else {
          return Center( child: CircularProgressIndicator(backgroundColor: utils.primaryLight,
          valueColor: new AlwaysStoppedAnimation<Color>(utils.primaryLight),));
        }
      },
    );
  }

  Widget _crearItem(BuildContext context,CartBloc cartBloc ,ProductModel product ) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(left: 20.0),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Text(
            'Borrar',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Text(
            'Borrar',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white),
        ),
      ),
      //onDismissed: ( direccion )=> productsBloc.borrarProducto(product.id),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: ( product.image == null ) 
                  ? Image(image: AssetImage('assets/no-image.png'),height: 100.0,)
                  : FadeInImage(
                    image: NetworkImage( product.image ),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 100.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('${ product.name }'),
                    subtitle: Text('Precio \$${product.price}'),
                    trailing: Text("Cantidad"),
                    onTap: ()=> _mostrarAlert(context,product)
                  ),
                ),
              ],
            )
          ],
        )
      )
    );
  }

  void _mostrarAlert(BuildContext context,ProductModel product){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          title: Text('${product.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${product.description}'),
              Container(
                  child: ( product.image == null ) 
                  ? Image(image: AssetImage('assets/no-image.png'),height: 100.0,)
                  : FadeInImage(
                    image: NetworkImage( product.image ),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 100.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
              _crearPrecio()
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Guardar"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  
  Widget _crearPrecio() {
    return TextFormField(
      initialValue: '1',
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(
        labelText: 'Cantidad'
      ),
      onSaved: null,
      validator: (value) {
        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
    );
  }


  Future<Null> refreshPage() async{
    final duration = new Duration(seconds: 1);
    setState(() {});
    return Future.delayed(duration);
  }

}