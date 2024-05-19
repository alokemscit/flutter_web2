 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/settings/responsive.dart';
 
 

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
           CustomCaptionForContainer( headerName,),
        
        height>0?  Container(
              decoration: CustomCaptionDecoration().copyWith(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
                color: kWebBackgroundDeepColor,
              ),
              height: height,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: children,
                  ))):Expanded(
            child: Container(
                decoration: CustomCaptionDecoration().copyWith(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                    color: kWebBackgroundDeepColor,
                ),
                //height: height,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: children,
                    ))),
          )


        ]);



customChildrenContainer(String headerName, List<Widget> children) =>
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCaptionForContainer(headerName),
        
          Container(
              decoration: CustomCaptionDecoration().copyWith(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    
                    ),
                color: kWebBackgroundDeepColor,
               ),
              
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: children.isEmpty?[height()]:children,
                  ))) 
          ]);



// ignore: non_constant_identifier_names
CustomCommonBody(bool isLoading, bool isError, String errorMessage, Widget mobile,
    Widget tablet, Widget desktop) {
  if (isLoading) {
    return const Center(child: CupertinoActivityIndicator());
  }
  if (isError) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }
  return Responsive(
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}



// ignore: non_constant_identifier_names

// CustomContainerExpandedChildren(String headerName, List<Widget> children,
//         [double height = 350]) =>
//     Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomCaptionForContainer(headerName),
//           Expanded(
//             child: Container(
//                 decoration: CustomCaptionDecoration().copyWith(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(8),
//                       bottomRight: Radius.circular(8)),
//                     color: kWebBackgroundDeepColor,
//                 ),
//                 height: height,
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: children,
//                     ))),
//           )
//         ]);
