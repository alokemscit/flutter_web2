// auth_provider.dart

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
 

import '../../../model/model_user.dart';
 


class AuthProvider with ChangeNotifier {
  ModelUser? _user;

  ModelUser? get user => _user;


  Future<void> loadUser() async {
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
_user = null;
    // print('aaaaaaa'+id.toString());
    if (uid != null && name != null) {
      _user = ModelUser(
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
      notifyListeners();
    }
    // notifyListeners();
  }

  // Log in a user and store their data in SharedPreferences.
  Future<void> login(
      
        String  uid,
        String cid,
        String  depId,
        String  desigId,
        String  name,
        String  img,
         String code,
        String  cname,
        String  dpname,
        String  dgname,
         String face1,
        String  face2,
        String  mob,
      
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('cid', cid);
    await prefs.setString('depId', depId);
    await prefs.setString('desigId', desigId);
    await prefs.setString('name', name);
    await prefs.setString('img', img);
    await prefs.setString('code', code);
    await prefs.setString('cname', cname);
    await prefs.setString('dpname', dpname);
    await prefs.setString('dgname', dgname);
    await prefs.setString('face1', face1);
    await prefs.setString('face2', face2);
    await prefs.setString('mob', mob);
    
    _user =await ModelUser(
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
          face1: face1,
          face2: face2,
          mob: mob,
        );
    notifyListeners();
  }

  // Log out a user and clear their data from SharedPreferences.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    await prefs.remove('cid');
    await prefs.remove('depId');
    await prefs.remove('desigId');
    await prefs.remove('name');
    await prefs.remove('img');
    await prefs.remove('code');
    await prefs.remove('cname');
    await prefs.remove('dpname');
    await prefs.remove('dgname');
    await prefs.remove('face1');
    await prefs.remove('face2');
    await prefs.remove('mob');
    await prefs.clear();
    _user = null;
    notifyListeners();
  }
}

Future<ModelUser> loadUserInfo() async {
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

  if (uid != null && name != null) {
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
          face1: face1,
          face2: face2,
          mob: mob,
        );
  } else {
    return null!;
  }
}



// class AuthProvider with ChangeNotifier {
//   User_Model? _user;

//   User_Model? get user => _user;

//   // Load user data from SharedPreferences when the app starts.
//   Future<void> loadUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final eMPID = prefs.getString('eMPID');
//     final eMPNAME = prefs.getString('eMPNAME');

//     final dEPTID = prefs.getString('dEPTID');
//     final dEPTNAME = prefs.getString('dEPTNAME');
//     final uID = prefs.getString('uID');
//     final uNAME = prefs.getString('uNAME');
//     final dSGID = prefs.getString('dSGID');
//     final dSGNAME = prefs.getString('dSGNAME');
//     final iMAGE = prefs.getString('iMAGE');

//     if (eMPID != null && eMPNAME != null) {
//       _user = User_Model(eMPID:eMPID,
//       eMPNAME:eMPNAME,
//       dEPTID:dEPTID,
//       dEPTNAME:dEPTNAME,
//       uID:uID,
//       uNAME:uNAME,
//       dSGID:dSGID,
//       dSGNAME:dSGNAME,
//       iMAGE:iMAGE
//       );
//       notifyListeners();
//     }
//   }

//   // Log in a user and store their data in SharedPreferences.
//   Future<void> login(
//   String eMPID,
//   String eMPNAME,
//   String dEPTID,
//   String dEPTNAME,
//   String uID,
//   String uNAME,
//   String dSGID,
//   String dSGNAME,
//   String iMAGE) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('eMPID', eMPID);
//     await prefs.setString('eMPNAME', eMPNAME);
//     await prefs.setString('dEPTID', dEPTID);
//     await prefs.setString('dEPTNAME', dEPTNAME);
//     await prefs.setString('uID', uID);
//     await prefs.setString('uNAME', uNAME);
//     await prefs.setString('dSGID', dSGID);
//     await prefs.setString('dSGNAME', dSGNAME);
//     await prefs.setString('iMAGE', iMAGE);

//     _user = User_Model(eMPID:eMPID,
//       eMPNAME:eMPNAME,
//       dEPTID:dEPTID,
//       dEPTNAME:dEPTNAME,
//       uID:uID,
//       uNAME:uNAME,
//       dSGID:dSGID,
//       dSGNAME:dSGNAME,
//       iMAGE:iMAGE);
//     notifyListeners();
//   }

//   // Log out a user and clear their data from SharedPreferences.
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('eMPID');
//     await prefs.remove('eMPNAME');
//     await prefs.remove('dEPTID');
//     await prefs.remove('dEPTNAME');
//     await prefs.remove('uID');
//     await prefs.remove('uNAME');
//     await prefs.remove('dSGID');
//     await prefs.remove('dSGNAME');
//     await prefs.remove('iMAGE');
//     _user = null;
//     notifyListeners();
//   }
// }
