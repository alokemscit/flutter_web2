import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  final String Theame='IS_DARK';
  //Future<SharedPreferences> ref = SharedPreferences.getInstance();
  late ThemeData _currentTheame;
  ThemeData get CurrentTheame => _currentTheame;
  void TogleTheame() async{
    SharedPreferences ref = await  SharedPreferences.getInstance();
    bool isDark=ref.getString(Theame)==null??false;
    if(isDark){

    }
  }
}
