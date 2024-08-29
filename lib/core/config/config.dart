import 'dart:convert';
 
//import 'dart:ui';

 
 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_2/core/config/const.dart';
 
 
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
  final desigId = await prefs.getString('desigId');
  final name = await prefs.getString('name');
  final img = await prefs.getString('img');
  final code = await prefs.getString('code');
  final cname = await prefs.getString('cname');
  final dpname = await prefs.getString('dpname');
  final dgname = await prefs.getString('dgname');
  final face1 = await prefs.getString('face1');
  final face2 = await prefs.getString('face2');
  final mob = await prefs.getString('mob');
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

 
}
 