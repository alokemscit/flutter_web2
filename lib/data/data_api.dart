import 'dart:convert';
 
import 'package:http/http.dart' as http;

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
      print(response.body);
      apiData1 = jsonDecode(response.body);
      print(apiData1);
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
    List<dynamic> apiData1 = [];
    //print(object)
    String url = 'https://erphub.top/mob/$methods';
    //print(url);
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
      apiData1 = jsonDecode(response.body.toString());
     // print(apiData1.length);
      
      return apiData1;
    } else {
      return [];
    }
    //return apiData1;
  }
}
