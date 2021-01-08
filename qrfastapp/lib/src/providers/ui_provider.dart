import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class UiProvider extends ChangeNotifier{
  final _selectedMenuOpt = BehaviorSubject<int>();

  Stream<int> get optSteam => _selectedMenuOpt.stream;

  void changeOpt(int i){
    _selectedMenuOpt.sink.add(i);
  }


  int get opt => _selectedMenuOpt.value;

  // ignore: must_call_super
  dispose(){
    _selectedMenuOpt?.close();
  }
}