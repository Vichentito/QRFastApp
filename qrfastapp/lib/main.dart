import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qrfastapp/src/pages/login_page.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/routes/routes.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  final Color _themeColor = Colors.deepPurpleAccent;
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
        initialRoute: LoginPage.routeName,
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
}