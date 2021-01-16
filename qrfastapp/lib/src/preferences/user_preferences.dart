import 'package:shared_preferences/shared_preferences.dart';
/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class UserPreferences {

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }
  // GET y SET de email
  get userEmail {
    return _prefs.getString('userEmail') ?? '';
  }
  set userEmail( String value ) {
    _prefs.setString('userEmail', value);
  }
  // GET y SET de password
  get userPassword {
    return _prefs.getString('userPassword') ?? '';
  }

  set userPassword( String value ) {
    _prefs.setString('userPassword', value);
  }
  // GET y SET de id de carrito activo
  get userCartId {
    return _prefs.getString('userCartId') ?? '';
  }

  set userCartId( String value ) {
    _prefs.setString('userCartId', value);
  } 


}
