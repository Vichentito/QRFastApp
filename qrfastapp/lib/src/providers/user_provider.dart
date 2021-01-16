import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:qrfastapp/src/preferences/user_preferences.dart';

class UserProvider{
  final String _firebaseToken = 'AIzaSyBcFqxAUzxefdB0TmIGT1KDv23fGfGYRbw';
  final _prefs = new UserPreferences();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String,dynamic>> login(String email, String password)async{
    // if(decodeResp.containsKey('idToken')){
    //   _prefs.token = decodeResp["idToken"];
    //   return {'ok':true,'token':decodeResp['idToken']};
    // }else{
    //   return { 'ok': false, 'mensaje': decodeResp['error']['message'] };
    // }
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      final token = await userCredential.user.getIdToken();
      _prefs.token = token;
      _prefs.userEmail = email;
      _prefs.userPassword = password;
      return {'ok':true,'token':token};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return { 'ok': false, 'mensaje': 'No se encontro el usuario' };
      } else if (e.code == 'wrong-password') {
        return { 'ok': false, 'mensaje': 'Contraseña incorrecta' };
      }
    }
  }

  Future<Map<String,dynamic>> newUser(String email, String password)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      await userCredential.user.sendEmailVerification();
      return { 'ok': true, 'mensaje': 'Verifica tu cuenta con el enlace enviado a tu correo' };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return { 'ok': false, 'mensaje': 'La contraseña es insegura.' };
      } else if (e.code == 'email-already-in-use') {
        return { 'ok': false, 'mensaje': 'Esta cuenta de correo ya esta en uso.' };
      }
    } catch (e) {
      return { 'ok': false, 'mensaje': e };
    }
  }
}