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
  final uid = prefs.getString('uid');

  final cid = prefs.getString('cid');
  final depId = prefs.getString('depId');
  final desigId = prefs.getString('desigId');
  final name = prefs.getString('name');
  final img = prefs.getString('img');
  final code = prefs.getString('code');
  final cname = prefs.getString('cname');
  final dpname = prefs.getString('dpname');
  final dgname = prefs.getString('dgname');
  final face1 = prefs.getString('face1');
  final face2 = prefs.getString('face2');
  final mob = prefs.getString('mob');
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
    return ModelUser();
  }

 
}
 