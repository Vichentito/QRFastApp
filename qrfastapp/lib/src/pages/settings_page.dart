import 'package:flutter/material.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _credentials;
  int _genero;
  String _nombre = 'Pedro';

  TextEditingController _textController;

  final _prefs = UserPreferences();
  
  @override
  void initState() {
    super.initState();
    //prefs.ultimaPagina = SettingsPage.routeName;
    //_genero = prefs.genero;
    //_colorSecundario = prefs.colorSecundario;
    _credentials = true;
    _textController = new TextEditingController( text: _nombre );
  }
  // _setSelectedRadio( int valor ) {
  //   //prefs.genero = valor;
  //   _genero = valor;
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      body: ListView(
        children: <Widget>[
          Divider(),
          SwitchListTile(
            value: _credentials,
            title: Text('Guardar credenciales al cerrar sesión'),
            onChanged: ( value ){
              setState(() {
                _credentials = value;
                if(_credentials == false){
                  _prefs.userEmail = '';
                  _prefs.userPassword = ''; 
                }
              });
            },
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20.0),
          //   child: TextField(
          //     controller: _textController,
          //     decoration: InputDecoration(
          //       labelText: 'Nombre',
          //       helperText: 'Nombre de la persona usando el teléfono',
          //     ),
          //     onChanged: ( value ) {
          //       //prefs.nombreUsuario = value;
          //     },
          //   ),
          // )



        ],
      )
    );
  }
}