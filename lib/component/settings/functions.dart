// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_2/component/settings/config.dart';

import '../../model/model_status.dart';
import '../awesom_dialog/awesome_dialog.dart';

 
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
Future<void> CustomDialog(BuildContext context, Widget title,
    Widget bodyContent, void Function() onPress,
    {bool scrollable = true}) {
  final GlobalKey buttonKey = GlobalKey();
  bool isButtonDisabled = false;
  void disableButton() {
    isButtonDisabled = true;
    Future.delayed(const Duration(seconds: 1), () {
      // Enable the button after the delay
      if (buttonKey.currentContext != null) {
        isButtonDisabled = false;
      }
    });
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void _onButtonPressed() {
    if (!isButtonDisabled) {
      onPress();
      disableButton();
    }
  }

  return showDialog<void>(
    //barrierColor:Colors.white,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        surfaceTintColor: Colors.white.withOpacity(0.5),
        scrollable: scrollable,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        contentPadding: const EdgeInsets.only(top: 5.0),
        // elevation: 0,
        title: title, //AppointDialogTitle(data: data,),
        titlePadding: EdgeInsets.zero,
        // contentPadding: const EdgeInsets.all(8),
        content: bodyContent, //AppointmentDialogBody(),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            key: buttonKey,
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: _onButtonPressed,
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

void capertinoAlertDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Alert'),
      content: const Text('Proceed with destructive action?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

void customAwesamDialodOk(BuildContext context, DialogType dialogType,
        String title, String message, Function() onOk) =>
    AwesomeDialog(
      width: 400,
      context: context,
      isDense: false,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      title: title,
      desc: message,
      btnOkOnPress: () {
        onOk();
      }, // Use onOk directly as the callback
      btnOkText: 'OK',
    ).show();

// ignore: non_constant_identifier_names
void CupertinioAlertDialog(BuildContext context, String msg) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Alert'),
      content: Text(msg),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
CustomCaptionDecoration(
  [double borderWidth=0.3,Color borderColor= Colors.black]
) {
return  BoxDecorationTopRounded.copyWith(
   borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      color: backgroundColor,
      border: Border(left: BorderSide(color: borderColor.withOpacity(0.3), width: borderWidth),
      right:  BorderSide(color: borderColor.withOpacity(0.3), width: borderWidth),
      bottom: BorderSide(color: borderColor.withOpacity(0.3), width: borderWidth)
      ) //   .all(color: borderColor.withOpacity(0.3), width: borderWidth)
      );
}

// ignore: non_constant_identifier_names
CustomCaptionForContainer(String text,[Color backgroundColor=kWebHeaderColor,boxShadoColor=Colors.black38,Color textColor= Colors.black] ) => Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.13),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        //border: Border.all(color: Colors.black38, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: boxShadoColor.withOpacity(0.3),
              blurRadius: 1.05,
              spreadRadius: 0.1)
        ],

        //           gradient: LinearGradient(
        //    colors: [

        //       kWebHeaderColor.withOpacity(0.13),
        //        kWebHeaderColor.withOpacity(0.23) ,
        //    ]
        //  ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 6, bottom: 8, top: 2),
        child: Text(
          text,
          style:  customTextStyle.copyWith(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: textColor,
              color:textColor),
        ),
      ),
    );





// ignore: non_constant_identifier_names
CustomCaptionForContainerForAccordian(String text,[Color backgroundColor=kWebHeaderColor,boxShadoColor=Colors.black38,Color textColor= Colors.black] ) => Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.13),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        //border: Border.all(color: Colors.black38, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: boxShadoColor.withOpacity(0.3),
              blurRadius: 1.05,
              spreadRadius: 0.1)
        ],
 
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, bottom: 8, top: 2),
            child: Text(
              text,
              style:  customTextStyle.copyWith(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationColor: textColor,
                  color:textColor),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(Icons.keyboard_arrow_up_sharp,color: textColor,size: 24,),
          )
        ],
      ),
    );










// ignore: non_constant_identifier_names
// CustomCupertinoAlertWithYesNo(BuildContext context, Widget title,
//     Widget content, void Function() no, void Function() yes,
//     [String? noButtonCap, String? yesButtonCap]) {
//   showCupertinoDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CupertinoAlertDialog(
//         title: title,
//         content: content,
//         actions: [
//           CupertinoDialogAction(
//             child: Text(noButtonCap ?? 'No'),
//             onPressed: () {
//               // Navigator.of(context).pop(false); // Returning false when No is pressed
//               no();
//             },
//           ),
//           CupertinoDialogAction(
//             child: Text(yesButtonCap ?? 'Yes'),
//             onPressed: () {
//               yes();
//               // Returning true when Yes is pressed
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// ignore: non_constant_identifier_names
CustomCupertinoAlertWithYesNo(BuildContext context, Widget title,
    Widget content, void Function() no, void Function() yes,
    [String? noButtonCap, String? yesButtonCap]) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title,
        content: Container(
          // Wrap content in a container to allow for better layout adjustments
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: content,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(noButtonCap ?? 'No'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              no();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true, // Emphasize the primary action
            child: Text(yesButtonCap ?? 'Yes'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              yes();
            },
          ),
        ],
      );
    },
  );
}

// ignore: non_constant_identifier_names
CustomModalBusyLoader() {
 Get.dialog(
  Center(
    child:  CupertinoPopupSurface(
          child: Container(
            height: 50,
            width: 50,
            color: Colors.black,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
  ),
  transitionCurve: Curves.easeInOutBack,
  transitionDuration: const Duration(milliseconds: 200),
  barrierColor: Colors.black.withOpacity(0.2),
  barrierDismissible: false,
);
}

// ignore: non_constant_identifier_names
Future<void> customBusyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    barrierDismissible: false,
    builder: (BuildContext context) {
     return Center(
        child: CupertinoPopupSurface(
          child: Container(
            height: 50,
            width: 50,
            color: Colors.black,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    },
  );
}





// ignore: non_constant_identifier_names
bool GetStatusMessage(BuildContext context, List<dynamic> x) {
  ModelStatus st = x.map((e) => ModelStatus.fromJson(e)).first;
  if (st == null) {
    customAwesamDialodOk(
        context, DialogType.error, "Error!", "Error to save data!", () {});
    return false;
  }
  if (st.status != "1") {
    customAwesamDialodOk(context, DialogType.error, "Error!", st.msg!, () {});
    return false;
  }
  customAwesamDialodOk(context, DialogType.success, "Success!", st.msg!, () {});
  return true;
}


Future<File> getImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    return File(''); // or return File(); for an empty file
  }
}



Future<String> imageFileToBase64(String fileUrl) async {
  // Fetch the file content using an HTTP request
  if(!kIsWeb){
    File inputFile = File(fileUrl);
    List<int> fileBytes = inputFile.readAsBytesSync();
   String base64String = base64Encode(fileBytes);
   return base64String;
  }
  var response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    // Convert the file content to Base64
    String base64String = base64Encode(response.bodyBytes);
    return base64String;
  } else {
    throw Exception('Failed to load file');
  }
}