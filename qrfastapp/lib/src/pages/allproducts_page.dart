import 'package:flutter/material.dart';
import 'package:qrfastapp/src/blocs/products_bloc.dart';
import 'package:qrfastapp/src/models/product_model.dart';
import 'package:qrfastapp/src/pages/product_page.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class AllProductsPage extends StatefulWidget {
  static final String routeName = 'allProducts';

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);
    productsBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos')
      ),
      body: RefreshIndicator(
        onRefresh: refreshPage,
        color: Colors.deepPurpleAccent,
        child: _crearListado(productsBloc),
      ),
      floatingActionButton: _crearBoton( context ),
    );
  }

  Widget _crearListado(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productosStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context,productsBloc,productos[i] ),
          );
        } else {
          return Center( child: CircularProgressIndicator(backgroundColor: Colors.deepPurpleAccent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),));
        }
      },
    );
  }

  Widget _crearItem(BuildContext context,ProductsBloc productsBloc ,ProductModel product ) {
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
      onDismissed: ( direccion )=> productsBloc.borrarProducto(product.id),
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
                    title: Text('${ product.name } - ${ product.price }'),
                    subtitle: Text( product.id ),
                    onTap: () => Navigator.pushNamed(context, 
                    ProductPage.routeName, arguments: product ).then((value){
                      setState(() {
                      });
                    })
                  ),
                ),
              ],
            )
          ],
        )
      )
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurpleAccent,
      onPressed: (){
        Navigator.pushNamed(context, ProductPage.routeName).then((value){
          setState(() {
          });
        });
      }
    );
  }

  Future<Null> refreshPage() async{
    final duration = new Duration(seconds: 1);
    setState(() {});
    return Future.delayed(duration);
  }
}