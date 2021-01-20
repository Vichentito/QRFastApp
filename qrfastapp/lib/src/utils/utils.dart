
import 'dart:math';
import 'package:flutter/material.dart';

final black = Color(0xffFF000000);
final white = Color(0xffFFFFFFFF);
final primary = Color(0xff005063);
final primaryLight = Color(0xff4facc1);
final primaryDark = Color(0xff005063);
final secondary = Color(0xff16c2de);
final secondaryLight = Color(0xff69f5ff);
final secondaryDark = Color(0xff0091ac);
final gris = Color(0xffE0E0E0);
final paypalColor = Color(0xff116ED9);
final payButton = Color(0xffC7B70A);

bool isNumeric( String s ) {

  if ( s.isEmpty ) return false;

  final n = num.tryParse(s);

  return ( n == null ) ? false : true;

}

int randomInt(){
  return Random().nextInt(1000);
}

void mostrarErrorAlert(BuildContext context, String mensaje ) {
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=> Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

void mostrarSuccesfulAlert(BuildContext context, String mensaje ) {
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Text('Informacion'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=> Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

bool isAdmin(String id){
  final admins = ['R3yZ8cqaodYnGDancvyDvFizd2c2'];
  bool result = false;
  admins.forEach((element) {
    if(id == element){
      result = true;
    }
  });
  return result;
}