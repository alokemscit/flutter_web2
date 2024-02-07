 
import 'package:flutter/material.dart';
 
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
 

height([double height = 8]) => SizedBox(
      height: height,
    );
width([double width = 8]) => SizedBox(
      width: width,
    );
// ignore: non_constant_identifier_names
roundedButton(void Function() Function, IconData icon, [double iconSize = 18]) {
  bool b = true;
  return InkWell(
    onTap: () {
      if (b) {
        b = false;
        Function();
        Future.delayed(const Duration(seconds: 2), () {
          b = true;
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: kWebBackgroundDeepColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 1,
            ),
          ]),
      child: Icon(
        icon,
        size: iconSize,
        color: kWebHeaderColor,
      ),
    ),
  );
}

customFixedHeightContainer(String headerName, List<Widget> children,
        [double height = 350]) =>
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCaptionForContainer(headerName),
          Container(
              decoration: customBoxDecoration.copyWith(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: kWebBackgroundDeepColor,
              ),
              height: height,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: children,
                  )))
        ]);




