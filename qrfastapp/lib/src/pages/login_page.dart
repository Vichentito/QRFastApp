import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/home_page.dart';
import 'package:qrfastapp/src/pages/register_page.dart';
import 'package:qrfastapp/src/pages/settings_page.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/providers/user_provider.dart';
import 'package:qrfastapp/src/utils/utils.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = 'login';

  final userProvider = new UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _createBackground(context),
          _logingForm(context),
        ],
      )
    );
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backGround = Container(
      height: size.height * .4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );
    final circles = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: [
        backGround,
        Positioned(top: 90.0,left: 30.0,child: circles),
        Positioned(top: -40.0,right: -30.0,child: circles),
        Positioned(top: 120.0,right: -10.0,child: circles),
        Positioned(top: 240.0,left: 5.0,child: circles),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle,color: Colors.white,size: 100.0,),
              SizedBox(height: 10.0,width: double.infinity,),
              Text("QRFast",style: TextStyle(color: Colors.white,fontSize: 25.0),)
            ],
          ),
        )
      ],
    );
  }

  Widget _logingForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * .85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text("Login",style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0,),
                _createEmail(bloc),
                SizedBox(height: 30.0,),
                _createPassword(bloc),
                SizedBox(height: 30.0,),
                _createButton(bloc)
              ],
            ),
          ),
          FlatButton(
            child: Text('Crear una nueva cuenta'),
            onPressed: ()=> Navigator.pushReplacementNamed(context, RegisterPage.routeName),
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,color: Colors.deepPurpleAccent,),
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
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,color: Colors.deepPurpleAccent,),
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
            child: Text("Ingresar"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurpleAccent,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=>_login(bloc,context) :null,
        );
      }
    );
  }

  _login(LoginBloc bloc, BuildContext context)async{
    Map info = await userProvider.login(bloc.email, bloc.password);

    if ( info['ok'] ) {
       Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      mostrarAlerta( context, info['mensaje'] );
    }
  }
}