import 'package:flutter/material.dart';
import 'package:qrfastapp/src/blocs/loging_bloc.dart';
import 'package:qrfastapp/src/blocs/products_bloc.dart';
import 'package:qrfastapp/src/providers/ui_provider.dart';
export 'package:qrfastapp/src/blocs/loging_bloc.dart';
export 'package:qrfastapp/src/blocs/products_bloc.dart';

class Provider extends InheritedWidget{
  
  final loginBloc = LoginBloc();
  final _optProvider = UiProvider();
  final _productsBloc = new ProductsBloc();

  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {
    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }
    return _instancia;
  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static UiProvider opProvider ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._optProvider;
  }

  static ProductsBloc productsBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }

}