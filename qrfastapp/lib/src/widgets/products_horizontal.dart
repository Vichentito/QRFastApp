import 'package:flutter/material.dart';
import 'package:qrfastapp/src/models/product_model.dart';


class ProductsHorizontal extends StatelessWidget {

  final List<ProductModel> productos;
  final Function siguientePagina;

  ProductsHorizontal({ @required this.productos, @required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        siguientePagina();
      }

    });


    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: productos.length,
        itemBuilder: ( context, i ) => _tarjeta(context, productos[i] ),
      ),
    );


  }

  Widget _tarjeta(BuildContext context, ProductModel producto) {

    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: producto.idProduct,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( producto.image ),
                  placeholder: AssetImage('assets/no-image.png'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              producto.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
      },
    );

  }


  List<Widget> _tarjetas(BuildContext context) {

    return productos.map( (producto) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( producto.image ),
                placeholder: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              producto.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );


    }).toList();

  }

}
