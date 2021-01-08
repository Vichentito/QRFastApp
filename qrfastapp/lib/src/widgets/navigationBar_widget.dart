import 'package:flutter/material.dart';
import 'package:qrfastapp/src/providers/provider.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    final optProvider = Provider.opProvider(context);
    //final uiProvider = Provider.of<UiProvider>(context);
    var currentIndex = optProvider.opt;
    return BottomNavigationBar(
        onTap: (int i ){
          optProvider.changeOpt(i);
          currentIndex = optProvider.opt;
          setState(() {
          });
        },
        elevation: 0,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
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
  }
}