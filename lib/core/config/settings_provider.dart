import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final String Theame='IS_DARK';
  //Future<SharedPreferences> ref = SharedPreferences.getInstance();
  late ThemeData _currentTheame;
  ThemeData get CurrentTheame => _currentTheame;
  // ignore: non_constant_identifier_names
  void TogleTheame() async{
    SharedPreferences ref = await  SharedPreferences.getInstance();
    bool isDark=ref.getString(Theame)==null??false;
    if(isDark){

    }
  }
}
