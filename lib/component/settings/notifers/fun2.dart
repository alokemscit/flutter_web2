// import 'dart:convert';
// // Import 'dart:html' for web-specific functionalities
// import 'package:http/http.dart' as http;

// Future<String> fileToBase64(String fileUrl) async {
//   // Fetch the file content using an HTTP request
//   var response = await http.get(Uri.parse(fileUrl));

//   if (response.statusCode == 200) {
//     // Convert the file content to Base64
//     String base64String = base64Encode(response.bodyBytes);
//     return base64String;
//   } else {
//     throw Exception('Failed to load file');
//   }
// }