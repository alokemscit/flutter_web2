import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../core/config/functions.dart';

class data_api {
  Future<List<dynamic>> createLead(List<dynamic> parameter,
      [String methods = "getdata"]) async {
    List<dynamic> apiData1 = [];

    //print(object)
    String url = 'https://web.asgaralihospital.com/api/mob/$methods';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      body: jsonEncode(parameter),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      apiData1 = jsonDecode(response.body);
    } else {
      apiData1 = [];
    }
    return apiData1;
  }

  Future<List<dynamic>> otp(List<dynamic> parameter) async {
    List<dynamic> apiData1 = [];
    String url = 'https://web.asgaralihospital.com/api/mob/generate_otp';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      body: jsonEncode(parameter),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      apiData1 = jsonDecode(response.body);
      //  print(apiData1);
    } else {
      apiData1 = [];
    }
    return apiData1;
  }
}

// ignore: camel_case_types
class data_api2 {
  Future<List<dynamic>> createLead(List<dynamic> parameter,
      [String methods = "getdata"]) async {
    //List<dynamic> apiData1 = [];
    String jsonString = jsonEncode(parameter);
    // print(jsonString);
    String d = base64Encode(utf8.encode(jsonString));
   // print(encryptText(d, ));
    // var k = [
    //   {"data": d}
    // ];
    // print(d);

    var key = '*erphub.top*';
    var key2 = 'RG-V2ZWxvcGVyIH/Byb2R1Y3Rpdml0eS-BpcyBtZWFzd:;XJlZCBpbiBj=!';
    //print(object)
   // String url = 'http://localhost:26031/mob/$methods';
     String url = 'https://erphub.top/mob/$methods';
    //print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        // "Access-Control-Allow-Methods":
        //  "Origin, X-Requested-With, Content-Type, Accept",
        'url-proxy': key,
        'Api-Key': key2,
      },
      body: jsonEncode([
      {"data": d}
    ]),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      //apiData1 = jsonDecode( base64Decode(response.body.toString()).toString()  );
      String decodedJsonString = utf8.decode(base64Decode(response.body));
      var apiData1 = jsonDecode(decodedJsonString);

      // print(apiData1);

      return apiData1;
    } else {
      print(response.body);
      return [];
    }
    //return apiData1;
  }
}


 


//Future<void> uploadImage(File imageFile) async {
// final String apiUrl = 'https://erphub.top/img.ashx';
// try {
//   var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
//   request.fields["pid"] = "img";
//   request.files
//       .add(await http.MultipartFile.fromPath('file', imageFile.path));

//   var response = await request.send();

//   if (response.statusCode == 200) {
//     print('Image uploaded successfully');
//     // Handle success
//   } else {
//     print('Failed to upload image. Status code: ${response.statusCode}');
//     // Handle error
//   }
// } catch (e) {
//   print('Error uploading image: $e');
// }

// Future<String> convertFileToBase64(File file) async {
//   try {
//     List<int> imageBytes = await file.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     return base64Image;
//   } catch (e) {
//     print(e);
//     return '';
//   }
// }

// Future<void> uploadImage(File imageFile) async {
//   var x = await convertFileToBase64(imageFile);
//   print(x);

//   // final String apiUrl = 'https://erphub.top/img.ashx';
//   // try {
//   //   var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
//   //     ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
//   //   //request.fields["pid"] = "img";
//   //   print("before call");
//   //   var response = await request.send();
//   //   print(response.reasonPhrase);

//   //   if (response.statusCode == 200) {
//   //     print('Image uploaded successfully');
//   //   } else {
//   //     print('Failed to upload image. Status code: ${response.statusCode}');
//   //   }
//   // } catch (e) {
//   //   print('Error uploading image: $e');
//   // }
// }
// //}
