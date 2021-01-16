import 'package:flutter/material.dart';
import 'package:qrfastapp/src/pages/account_page.dart';
import 'package:qrfastapp/src/pages/qrHome_page.dart';
import 'package:qrfastapp/src/pages/shoppingCart_page.dart';
import 'package:qrfastapp/src/preferences/user_preferences.dart';
import 'package:qrfastapp/src/providers/provider.dart';
import 'package:qrfastapp/src/widgets/menu_widget.dart';
import 'package:qrfastapp/src/widgets/navigationBar_widget.dart';
import 'package:qrfastapp/src/widgets/qrScanButton_widget.dart';
import 'package:qrfastapp/src/utils/utils.dart' as utils;

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    final optProvider = Provider.opProvider(context);
    final _prefs = new UserPreferences();
    if(_prefs.ultimoTab != ''){
      switch (_prefs.ultimoTab) {
        case 'cart':
          optProvider.changeOpt(0);
          break;
        case 'qrhome':
          optProvider.changeOpt(1);
          break;
        default:
          optProvider.changeOpt(1);
      }
    }else{
      optProvider.changeOpt(1);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('QRFast',style: TextStyle(color: utils.white),),
        iconTheme: IconThemeData(color: utils.white),
      ),
      body: _HomePageBody(),
      drawer: MenuWidget(),
      bottomNavigationBar: NavigationBar(),
      floatingActionButton: QrScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final optProvider = Provider.opProvider(context);
    return StreamBuilder(
      stream: optProvider.optSteam ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          child: _screen(snapshot.data),
        );
      },
    );
  }

  Widget _screen(int currentIndex){
    switch( currentIndex ) {
      case 0:
        return ShoppingCartPage();
      case 1: 
        return QrHomePage();
      case 2: 
        return AccountPage();
      default:
        return QrHomePage();
    }
  }

  
}
