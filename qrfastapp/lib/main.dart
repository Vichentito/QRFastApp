import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qrfastapp/src/pages/home_page.dart';
import 'package:qrfastapp/src/pages/login_page.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/routes/routes.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  final Color _themeColor = utils.primaryLight;
  final prefs = new UserPreferences();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
        ],
        title: 'QRFast',
        debugShowCheckedModeBanner: false,
        initialRoute: _getInitialRoute(),
        routes: getAppRoutes(),
        onGenerateRoute: (RouteSettings settings){
          print("ruta desconocida");
          return MaterialPageRoute(
            builder: (BuildContext context)=> LoginPage()
          );
        },
        theme: ThemeData(
          primaryColor: _themeColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: _themeColor
          )
        ),
      ),
    );

  }

  _getInitialRoute(){
    if(auth.currentUser != null){
      return HomePage.routeName;
    }else{
      return LoginPage.routeName;
    }
  }
}