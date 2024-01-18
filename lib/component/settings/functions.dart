// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../awesom_dialog/awesome_dialog.dart';
 

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
        String title, String message, Function onOk) =>
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


Future<Uint8List?> proxyImageRequest(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse('https://your-proxy-server.com/proxy?url=$imageUrl'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  } catch (e) {
    print('Error: $e');
  }

  return null;
}