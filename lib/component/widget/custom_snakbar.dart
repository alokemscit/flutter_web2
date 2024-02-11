import 'package:flutter/material.dart';

enum MsgType {
  error,
  warning,
  success

  // Add other message types here if needed
}

class CustomSnackbar {
  final BuildContext context;
  final String message;
  final MsgType type;
  
  CustomSnackbar(
      {required this.context,
      required this.message,
      this.type = MsgType.success,
      }) {
    //Size size = MediaQuery.of(context).size;
    showCustomSnackbar();
  }

  void showCustomSnackbar() {
    Size size = MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type.name == "error"
            ? Colors.red
            : type.name == "warning"
                ? Colors.yellow
                : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: size.height - 100,
            left: size.width * .4,
            right: size.width * .4),
        content: Text(message,
            style: TextStyle(
                color: type.name == "warning"
                    ? const Color.fromARGB(255, 32, 2, 201)
                    : Colors.black)),
        duration: const Duration(seconds: 2),
        
      ),
    );
  }
}


//  ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.red,
//               behavior: SnackBarBehavior.floating,
//               margin: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).size.height - 100,
//                   left: MediaQuery.of(context).size.width * .4,
//                   right: MediaQuery.of(context).size.width * .4),
//               content: const Text("Please selct the required dropdown field"),
//             ),
//           )