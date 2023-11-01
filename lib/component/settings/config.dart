import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_2/model/user_model.dart';

const Color backgroundColor = Color.fromARGB(255, 245, 250, 252);

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color(0xFFEE376E);
const kGrayColor = Color(0xFF8793B2);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);

const kDefaultPadding = 20.0;

List<BoxShadow> myboxShadow = [
  const BoxShadow(
    color: Color.fromARGB(255, 230, 229, 229),
    offset: Offset(2, 2),
    blurRadius: 2,
    spreadRadius: 1,
  ),
  const BoxShadow(
    color: Color.fromARGB(31, 255, 255, 255),
    offset: Offset(-10, -10),
    blurRadius: 2,
    spreadRadius: 1,
  ),
];

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Future<Image> base64StringToImage() async {
  SharedPreferences ref = await SharedPreferences.getInstance();
  String? image =  ref.getString('iMAGE');
  Uint8List bytes = base64.decode(image!);
  return Image.memory(bytes);
}

Future<User_Model> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final eMPID = prefs.getString('eMPID');
    final eMPNAME = prefs.getString('eMPNAME');
    final dEPTID = prefs.getString('dEPTID');
    final dEPTNAME = prefs.getString('dEPTNAME');
    final uID = prefs.getString('uID');
    final uNAME = prefs.getString('uNAME');
    final dSGID = prefs.getString('dSGID');
    final dSGNAME = prefs.getString('dSGNAME');
    final iMAGE = prefs.getString('iMAGE');
    Uint8List bytes = base64.decode(iMAGE!);
   
    return User_Model(
      eMPID:eMPID,
      eMPNAME:eMPNAME,
      dEPTID:dEPTID,
      dEPTNAME:dEPTNAME,
      uID:uID,
      uNAME:uNAME,
      dSGID:dSGID,
      dSGNAME:dSGNAME,
      iMAGE:iMAGE,
      pHOTO: Image.memory(bytes)
      );
  }
