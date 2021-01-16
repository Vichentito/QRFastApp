import 'package:flutter/material.dart';
import 'package:qrfastapp/src/blocs/cart_bloc.dart';
import 'package:qrfastapp/src/models/cart_model.dart';
import 'package:qrfastapp/src/models/productToBuy_model.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/products_provider.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;
import 'package:qrfastapp/src/widgets/paymentButton_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  static final String routeName = 'cart';
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final formKey = GlobalKey<FormState>();
  CartModel cart = CartModel();
  ProductToBuyModel productToUpdate = ProductToBuyModel();
  final productsProvider = ProductsProvider();
  @override
  Widget build(BuildContext context) {
    final cartBloc = Provider.cartBloc(context);
    final _prefs = UserPreferences();
    if(_prefs.userCartId != ''){
      cartBloc.crearCarritoFromPreferences(_prefs.userCartId);
    }
    cartBloc.cargarCarro();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshPage,
        color: utils.primaryLight,
        child: _crearListado(cartBloc),
      ),
      floatingActionButton: PaymentButton(),
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

  Widget _crearItem(BuildContext context,CartBloc cartBloc ,ProductToBuyModel product ) {
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
                    trailing: Text("Cantidad\n ${product.quantity}"),
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

  void _mostrarAlert(BuildContext context, ProductToBuyModel product){
    final cartProvider = Provider.cartBloc(context);
    productToUpdate = product;
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
              Form(
                key: formKey,
                child: _crearCantidad()
              )
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Guardar"),
              onPressed: ()async {
                if ( !formKey.currentState.validate() ) return;
                formKey.currentState.save();
                cart.date = cartProvider.cartValue.date;
                final tempProducts = cartProvider.cartValue.products;
                List<ProductToBuyModel> tempList = [];
                tempProducts.forEach((element) {
                  if(element.idProduct != product.idProduct){
                    tempList.add(element);
                  }
                });
                ProductToBuyModel productReference = await productsProvider.getOneProduct(productToUpdate.idProduct);
                productToUpdate.price = productReference.price * productToUpdate.quantity;
                tempList.add(productToUpdate);
                cart.products = tempList;
                cartProvider.actualizarCarro(cart);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  
  Widget _crearCantidad() {
    return TextFormField(
      initialValue: productToUpdate.quantity.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(
        labelText: 'Cantidad'
      ),
      onSaved: (value) => productToUpdate.quantity = int.parse(value),
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