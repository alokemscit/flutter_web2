import 'package:flutter/material.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';

//  class CustomAwesomeDialog {
//   CustomAwesomeDialog({
//     this.dialogType = DialogType.info,
//    // this.message = '',
//     void Function()? onTap,
//     required this.context,
//   }) : onTap = onTap ?? (() {
//           // Default onTap function if not provided
//         }) {
//     // Call show method when the constructor is invoked
//     _show();
//   }

//    DialogType dialogType;
//    late String message;
//    void Function()? onTap;
//    BuildContext context;

//   CustomAwesomeDialog messageType(String message) {
//     this.message = message;
//     return this; // Return this for fluent interface
//   }

//   void _show() => AwesomeDialog(
//         width: 400,
//         context: context,
//         isDense: false,
//         dialogType: dialogType,
//         animType: AnimType.bottomSlide,
//         dismissOnTouchOutside: true,
//         dismissOnBackKeyPress: false,
//         title: dialogType.name.toString(),
//         desc: message,
//         btnOkOnPress: () {
//           onTap;
//          }, // Use onOk directly as the callback
//         btnOkText: 'OK',
//       ).show();

// }

class CustomAwesomeDialog {
  CustomAwesomeDialog({
    required this.context,
    this.dialogType = DialogType.info,
    this.message = '',
    this.onTap,
  });

  DialogType dialogType;
  String message;
  void Function()? onTap;
  BuildContext context;

  void show() {
    bool b = true;
    AwesomeDialog(
      width: 400,
      context: context,
      isDense: false,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      title: dialogType.name,
      desc: message,
      btnOkOnPress: () {
        if (b) {
          b = false;
          onTap?.call();
          Future.delayed(const Duration(seconds: 2)).then((value) => b=false);
          // Use onTap function if provided
        }
      },
      btnOkText: 'OK',
    ).show();
  }
}
