import 'dart:convert';
 
import 'dart:ui';

 
 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/model/model_user.dart';
 

 



// List<BoxShadow> myboxShadow = [
//   const BoxShadow(
//     color: Color.fromARGB(255, 230, 229, 229),
//     offset: Offset(2, 2),
//     blurRadius: 2,
//     spreadRadius: 1,
//   ),
//   const BoxShadow(
//     color: Color.fromARGB(31, 255, 255, 255),
//     offset: Offset(-10, -10),
//     blurRadius: 2,
//     spreadRadius: 1,
//   ),
// ];

// // ignore: non_constant_identifier_names
// BoxDecoration BoxDecorationTopRounded = const BoxDecoration(
//     color: kBgLightColor, //.withOpacity(0.8),
//     // color: Color.fromARGB(255, 252, 251, 251),
//     borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.white,
//         blurRadius: 15.1,
//         spreadRadius: 3.1,
//       )
//     ]);

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

// ButtonStyle customButtonStyle = ButtonStyle(
//     foregroundColor:
//         MaterialStateProperty.all<Color>(Colors.white), // Set button text color
//     backgroundColor: MaterialStateProperty.all<Color>(appColorBlue),
//     textStyle: MaterialStateProperty.all<TextStyle>(
//       const TextStyle(
//           fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
//     ));

// BoxDecoration customBoxDecoration = BoxDecoration(
//   // color: appColorBlue.withOpacity(0.05),
//   borderRadius:
//       const BorderRadius.all(Radius.circular(12)), // Uncomment this line
//   border: Border.all(
//       color: appColorBlue,
//       width: 0.108,
//       strokeAlign: BorderSide.strokeAlignCenter),
//   boxShadow: [
//     BoxShadow(
//       color: appColorBlue.withOpacity(0.0085),
//       spreadRadius: 0.1,
//       blurRadius: 5.2,
//       offset: const Offset(0, 1),
//     ),
//     BoxShadow(
//       color: appColorBlue.withOpacity(0.0085),
//       spreadRadius: 0.2,
//       blurRadius: 3.2,
//       offset: const Offset(1, 0),
//     ),
//   ],
// );

// TextStyle customTextStyle = GoogleFonts.lato(
//   color: Colors.black,
//   fontSize: 14,
//   fontWeight: FontWeight.bold, //height:0.6
// );

// Widget headerCloseButton() => const Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 55,
//         ),
//         CustomAppBarCloseButton(),
//       ],
//     );
// // ignore: non_constant_identifier_names
// TableBorder CustomTableBorder() =>
//     TableBorder.all(width: 0.5, color: const Color.fromARGB(255, 89, 92, 92));

// // ignore: non_constant_identifier_names
// CustomTableCell(String text,
//         [TextStyle style =
//             const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)]) =>
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//       ),
//     );

// // ignore: non_constant_identifier_names
// Decoration CustomTableHeaderRowDecoration() => BoxDecoration(
//         color: kBgDarkColor,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(8),
//         ),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 2,
//               blurRadius: 3)
//         ]);
