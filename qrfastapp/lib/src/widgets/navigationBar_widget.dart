import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/qrHome_page.dart';
import 'package:qrfastapp/src/pages/shoppingCart_page.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    final optProvider = Provider.opProvider(context);
    final _prefs = new UserPreferences();
    var currentIndex = optProvider.opt;
    return StreamBuilder(
      stream: optProvider.optSteam,
      initialData: 1,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        currentIndex = snapshot.data;
        return BottomNavigationBar(
          onTap: (int i ){
            optProvider.changeOpt(i);
            setState(() {
              switch (i) {
                case 0:
                  _prefs.ultimoTab = ShoppingCartPage.routeName;
                  break;
                case 1:
                  _prefs.ultimoTab = QrHomePage.routeName;
                  break;
                default:
                  _prefs.ultimoTab = QrHomePage.routeName;
              }
            });
          },
          elevation: 0,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Lista de compras'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Cuenta'
            ),
            
          ],
        );
      },
    );
  }
}