import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/model/user_model.dart';

import '../widget/custom_app_bar_close_button.dart';

const Color backgroundColor = Color.fromARGB(255, 245, 250, 252);

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color(0xFFEE376E);
const kGrayColor = Color(0xFF8793B2);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);
const kTextBgColor = Color.fromARGB(255, 253, 253, 255);
const kMarkupColor = Color.fromARGB(255, 245, 244, 244);

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
const Color kHeaderolor = Color(0xFF129AE8);

const Color kBgColorG = Color(0xFFF8FBFF);
const Color kFontCapColor = Color(0xFF4887F1);
const Color kBannerbgColor = Color(0xFFEAF9FF);
const Color kProfileBgColor = Color(0xFFCBDEFE);
const Color kFrontPageColor = Color(0xFF78CEEF);
const Color kBgNewColor = Color(0xFFF6F6F6);

const appColorPrimary = Color(0xFF1157FA);

const appColorBlue = Color(0xFF129AE8);

const kWebBackgroundColor = Color(0xFFf8fafb);
const kWebBackgroundDeepColor = Color(0xFFedf2f5);
const kWebHeaderColor = Color(0xFF1d94ee);
const kWebButtonPrimaryColor = Color(0xFF389ef7);
// ignore: constant_identifier_names
const CPLineCChart1 = Color(0xFF02d39a);
// ignore: constant_identifier_names
const CPLineCChart = Color(0xFF23b6e6);

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

// ignore: non_constant_identifier_names
BoxDecoration BoxDecorationTopRounded = const BoxDecoration(
    color: kBgLightColor, //.withOpacity(0.8),
    // color: Color.fromARGB(255, 252, 251, 251),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 15.1,
        spreadRadius: 3.1,
      )
    ]);

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Future<Image> base64StringToImage() async {
  SharedPreferences ref = await SharedPreferences.getInstance();
  String? image = ref.getString('iMAGE');
  Uint8List bytes = base64.decode(image!);
  return Image.memory(bytes);
}

Future<ModelUser> getUserInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final uid = await prefs.getString('uid');

  final cid = await prefs.getString('cid');
  final depId = await prefs.getString('depId');
  final desigId =await prefs.getString('desigId');
  final name =await prefs.getString('name');
  final img =await prefs.getString('img');
  final code =await prefs.getString('code');
  final cname =await prefs.getString('cname');
  final dpname =await prefs.getString('dpname');
  final dgname =await prefs.getString('dgname');
  final face1 =await prefs.getString('face1');
  final face2 =await prefs.getString('face2');
  final mob =await prefs.getString('mob');
//_user = null;
  // print('aaaaaaa'+id.toString());
  if (uid != null && name != null) {
    print(name);
    return ModelUser(
      uid: uid,
      cid: cid,
      depId: depId,
      desigId: desigId,
      name: name,
      img: img,
      code: code,
      cname: cname,
      dpname: dpname,
      dgname: dgname,
      face1: face1!,
      face2: face2!,
      mob: mob,
    );
  } else {
    return null!;
  }

  // final prefs = await SharedPreferences.getInstance();
  // final eMPID = prefs.getString('eMPID');
  // final eMPNAME = prefs.getString('eMPNAME');
  // final dEPTID = prefs.getString('dEPTID');
  // final dEPTNAME = prefs.getString('dEPTNAME');
  // final uID = prefs.getString('uID');
  // final uNAME = prefs.getString('uNAME');
  // final dSGID = prefs.getString('dSGID');
  // final dSGNAME = prefs.getString('dSGNAME');
  // final iMAGE = prefs.getString('iMAGE');
  // Uint8List bytes = base64.decode(iMAGE!);

  // return User_Model(
  //     eMPID: eMPID,
  //     eMPNAME: eMPNAME,
  //     dEPTID: dEPTID,
  //     dEPTNAME: dEPTNAME,
  //     uID: uID,
  //     uNAME: uNAME,
  //     dSGID: dSGID,
  //     dSGNAME: dSGNAME,
  //     iMAGE: iMAGE,
  //     pHOTO: Image.memory(bytes));
}

ButtonStyle customButtonStyle = ButtonStyle(
    foregroundColor:
        MaterialStateProperty.all<Color>(Colors.white), // Set button text color
    backgroundColor: MaterialStateProperty.all<Color>(appColorBlue),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    ));

BoxDecoration customBoxDecoration = BoxDecoration(
  // color: appColorBlue.withOpacity(0.05),
  borderRadius:
      const BorderRadius.all(Radius.circular(12)), // Uncomment this line
  border: Border.all(
      color: appColorBlue,
      width: 0.108,
      strokeAlign: BorderSide.strokeAlignCenter),
  boxShadow: [
    BoxShadow(
      color: appColorBlue.withOpacity(0.0085),
      spreadRadius: 0.1,
      blurRadius: 5.2,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: appColorBlue.withOpacity(0.0085),
      spreadRadius: 0.2,
      blurRadius: 3.2,
      offset: const Offset(1, 0),
    ),
  ],
);

TextStyle customTextStyle = GoogleFonts.lato(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.bold, //height:0.6
);

Widget headerCloseButton() => const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
        ),
        CustomAppBarCloseButton(),
      ],
    );
// ignore: non_constant_identifier_names
TableBorder CustomTableBorder()=>TableBorder.all(
                        width: 0.5,
                        color: const Color.fromARGB(255, 89, 92, 92));

                        // ignore: non_constant_identifier_names
   CustomTableCell(String text, [TextStyle  style=  const TextStyle(fontSize: 12,fontWeight: FontWeight.w400)])=> Padding(
     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
     child: Text(text,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
  );