import 'package:flutter/material.dart';
import 'package:fooddelivery/themes/DarkMode.dart';
import 'package:fooddelivery/themes/LightMode.dart';
class Themeprovider with ChangeNotifier{
  ThemeData _themeData=lightMode; //default
  ThemeData get themeData=>_themeData;//get the current theme
  bool get isDarkMode=>_themeData==darkMode;//if it is darkMode return true
  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if(_themeData==lightMode){
      themeData=darkMode;
    }else{
      themeData=lightMode;
    }
  }
}