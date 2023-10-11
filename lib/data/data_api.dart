import 'dart:convert';
import 'package:http/http.dart' as http;
class data_api{

  Future<List<dynamic>> createLead(List<dynamic> parameter) async {
    List<dynamic> apiData1 = [];
    //print(object)
    String url = 'https://web.asgaralihospital.com/api/mob/getdata';
    final response = await http.post(
      Uri.parse(url),
       headers: {'Content-Type': 'application/json',
       'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
         },
      body: jsonEncode(parameter),
      
    );
    if (response.statusCode == 200) {
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
       headers: {'Content-Type': 'application/json'},
      body: jsonEncode(parameter),
      
    );
    if (response.statusCode == 200) {
    apiData1 = jsonDecode(response.body);
    } else {
      apiData1 = [];
      
    }
    return apiData1;
  }
}
