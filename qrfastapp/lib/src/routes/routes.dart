
import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/allproducts_page.dart';
import 'package:qrfastapp/src/pages/home_page.dart';
import 'package:qrfastapp/src/pages/login_page.dart';
import 'package:qrfastapp/src/pages/product_page.dart';
import 'package:qrfastapp/src/pages/register_page.dart';
import 'package:qrfastapp/src/pages/settings_page.dart';

Map<String, WidgetBuilder> getAppRoutes(){
  return <String, WidgetBuilder>{
        HomePage.routeName : (BuildContext context) => HomePage(),
        SettingsPage.routeName : (BuildContext context) => SettingsPage(),
        LoginPage.routeName : (BuildContext context) => LoginPage(),
        ProductPage.routeName : (BuildContext context) => ProductPage(),
        AllProductsPage.routeName : (BuildContext context) => AllProductsPage(),
        RegisterPage.routeName : (BuildContext context) => RegisterPage(),
      };
}