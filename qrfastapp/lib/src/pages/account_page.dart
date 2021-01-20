import 'package:flutter/material.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/providers/user_provider.dart';
// import 'package:qrfastapp/src/widgets/menu_widget.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;

class AccountPage extends StatefulWidget {
  static final String routeName = 'account';
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final userProvider = new UserProvider();
  final _prefs = new UserPreferences();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _logingForm(context),
    );
  }

  Widget _logingForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    if(_prefs.userEmail != '' && _prefs.userPassword != ''){
      _emailController = new TextEditingController(text: _prefs.userEmail);
      _passwordController = new TextEditingController(text: _prefs.userPassword);
    }else{
      _emailController = new TextEditingController(text: bloc.email);
      _passwordController = new TextEditingController(text: bloc.password);
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Text("Informacion de la cuenta",style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 60.0,),
              _createEmail(bloc),
              SizedBox(height: 30.0,),
              _createPassword(bloc),
              SizedBox(height: 30.0,),
              _createButton(bloc)
            ],
          ),
          SizedBox( height: 100.0 )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,color: utils.primaryLight,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,color: utils.primaryLight,),
              hintText: 'password',
              labelText: 'Contraseña',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 15.0),
            child: Text("Guardar"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 0.0,
          color: utils.primaryLight,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=>_register(bloc,context) :null,
        );
      }
    );
  }

  _register(LoginBloc bloc, BuildContext context)async{
    final info = await userProvider.newUser(bloc.email, bloc.password);
    if ( info['ok'] ) {
       utils.mostrarSuccesfulAlert( context, info['mensaje'] );
       await Future.delayed(new Duration(seconds: 3));
       //Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      utils.mostrarErrorAlert( context, info['mensaje'] );
    }
  }
  
}