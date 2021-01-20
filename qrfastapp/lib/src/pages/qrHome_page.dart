import 'package:flutter/material.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/widgets/products_horizontal.dart';

class QrHomePage extends StatefulWidget {
  static final String routeName = 'qrhome';
  @override
  _QrHomePageState createState() => _QrHomePageState();
}

class _QrHomePageState extends State<QrHomePage> {
  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);
    productsBloc.cargarProductos();
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cardInicio(),
            _footer(context,productsBloc)
          ],
        ),
      );
  }
  
  _cardInicio(){
    final card = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FadeInImage(
          //   image: Asset,
          //   placeholder: AssetImage('assets/jar-loading.gif'),
          //   fadeInDuration: Duration(milliseconds: 200),
          //   fit: BoxFit.cover
          // ),
          Image(
            image: AssetImage('assets/qrImage.jpeg'),
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10 ),
            child: Text("QRFast")
          )
        ],
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300.0,
          child: ClipRRect(
            child: card,
            borderRadius: BorderRadius.circular(30.0),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0,10.0)
              )
            ]
          ),
        ),
      ],
    );
  }

  _footer(BuildContext context, ProductsBloc productsBloc){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead  )
          ),
          SizedBox(height: 5.0),

          StreamBuilder(
            stream: productsBloc.productosStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if ( snapshot.hasData ) {
                return ProductsHorizontal(
                  productos: snapshot.data,
                  siguientePagina: productsBloc.cargarProductos,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );
  }
}