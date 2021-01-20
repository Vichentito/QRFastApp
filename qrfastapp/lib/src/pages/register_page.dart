import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/login_page.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/providers/user_provider.dart';
import 'package:qrfastapp/src/utils/utils.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;

class RegisterPage extends StatelessWidget {
  static final String routeName = 'register';
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
            utils.primary,
            utils.secondary
          ]
        )
      ),
    );
    final circles = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.25)
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
                Text("Sing in",style: TextStyle(fontSize: 20.0),),
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
            child: Text('¿Ya tienes cuenta?'),
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
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
            child: Text("Ingresar"),
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
       mostrarSuccesfulAlert( context, info['mensaje'] );
       await Future.delayed(new Duration(seconds: 3));
       Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      mostrarErrorAlert( context, info['mensaje'] );
    }
  }
}