import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qrfastapp/src/preferences/user_preferences.dart';

class UserProvider{
  final String _firebaseToken = 'AIzaSyBcFqxAUzxefdB0TmIGT1KDv23fGfGYRbw';
  final _prefs = new UserPreferences();

  Future<Map<String,dynamic>> login(String email, String password)async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode( authData )
    );
    Map<String,dynamic> decodeResp = json.decode(resp.body);
    if(decodeResp.containsKey('idToken')){
      _prefs.token = decodeResp["idToken"];
      return {'ok':true,'token':decodeResp['idToken']};
    }else{
      return { 'ok': false, 'mensaje': decodeResp['error']['message'] };
    }
  }

  Future<Map<String,dynamic>> newUser(String email, String password)async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode( authData )
    );
    Map<String,dynamic> decodeResp = json.decode(resp.body);
    if(decodeResp.containsKey('idToken')){
      _prefs.token = decodeResp["idToken"];
      return {'ok':true,'token':decodeResp['idToken']};
    }else{
      return {'ok':false,'mensaje':decodeResp['message']};
    }
  }
}