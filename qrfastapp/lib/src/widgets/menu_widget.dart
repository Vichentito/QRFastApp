import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/allproducts_page.dart';
import 'package:qrfastapp/src/pages/login_page.dart';
import 'package:qrfastapp/src/pages/product_page.dart';
import 'package:qrfastapp/src/pages/settings_page.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;

class MenuWidget extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings,color: utils.primaryLight,),
            title: Text("Ajustes"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.help,color: utils.primaryLight,),
            title: Text("Ayuda"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.add,color: utils.primaryLight,),
            title: Text("Agregar Productos"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, ProductPage.routeName);
            },
          ),
           ListTile(
            leading: Icon(Icons.list,color: utils.primaryLight,),
            title: Text("Todos Productos"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, AllProductsPage.routeName);
            },
          ),
           ListTile(
            leading: Icon(Icons.list,color: utils.primaryLight,),
            title: Text("Cerrar sesion"),
            onTap: ()async{
              Navigator.pop(context);
              await auth.signOut();
              Navigator.pushNamed(context, LoginPage.routeName);
            },
          ),

        ],
      ),
    );
  }
}