import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/allproducts_page.dart';
import 'package:qrfastapp/src/pages/product_page.dart';
import 'package:qrfastapp/src/pages/settings_page.dart';

class MenuWidget extends StatelessWidget {
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
            leading: Icon(Icons.settings,color: Colors.deepPurpleAccent,),
            title: Text("Ajustes"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.help,color: Colors.deepPurpleAccent,),
            title: Text("Ayuda"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.add,color: Colors.deepPurpleAccent,),
            title: Text("Agregar Productos"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, ProductPage.routeName);
            },
          ),
           ListTile(
            leading: Icon(Icons.list,color: Colors.deepPurpleAccent,),
            title: Text("Todos Productos"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, AllProductsPage.routeName);
            },
          ),

        ],
      ),
    );
  }
}