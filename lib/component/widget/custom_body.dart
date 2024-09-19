// ignore_for_file: non_constant_identifier_names

 
import 'package:flutter/cupertino.dart';
 
import 'package:web_2/core/config/const.dart';

 
import '../../core/config/responsive.dart';

CustomCommonBody(bool isLoading, bool isError, String errorMessage,
    Widget mobile, Widget tablet, Widget desktop) {
  if (isLoading) {
    return const Center(child: CupertinoActivityIndicator());
  }
  if (isError) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_sharp,
            color: Colors.red,
            size: 24,
          ),
          Text(
            errorMessage,
            style: customTextStyle.copyWith(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  return Responsive(
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}

_CustomCommonBody(
    bool isLoading, bool isError, String errorMessage, Widget desktop) {
  if (isLoading) {
    return Container(
      decoration: const BoxDecoration(color:kWebBackgroundColor,),
      child: const Center(child: CupertinoActivityIndicator( )));
  }
  if (isError) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_sharp,
            color: Colors.red,
            size: 24,
          ),
          Text(
            errorMessage,
            style: customTextStyle.copyWith(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  return desktop;
}

// Widget CommonBody(dynamic controller,

//    Widget mobile,
//    Widget tablet,
//    Widget desktop,
//  [ EdgeInsetsGeometry padding=const EdgeInsets.only(top: 8, left: 8, right: 8)]
//    )=>Scaffold(
//       body: Padding(
//         padding: padding,
//         child: Obx(() => CustomCommonBody(
//             controller.isLoading.value,
//             controller.isError.value,
//             controller.errorMessage.value,
//             mobile,
//            tablet,
//            desktop)),
//       ),
//     );


// Widget CommonBody2(
//         dynamic controller, Widget widget,
//         [EdgeInsetsGeometry padding =
//             const EdgeInsets.only(top: 8, left: 8, right: 8,bottom: 8)]) =>
//     Scaffold(
//       body: Padding(
//         padding: padding,
//         child: _CustomCommonBody(
//             controller.isLoading.value,
//             controller.isError.value,
//             controller.errorMessage.value,
            
//             widget),
//       ),
//     );



// Widget CommonBody(
//         dynamic controller, Widget mobile, Widget tablet, Widget desktop,
//         [EdgeInsetsGeometry padding =
//             const EdgeInsets.only(top: 8, left: 8, right: 8)]) =>
//     Scaffold(
//       body: Padding(
//         padding: padding,
//         child: CustomCommonBody(
//             controller.isLoading.value,
//             controller.isError.value,
//             controller.errorMessage.value,
//             mobile,
//             tablet,
//             desktop),
//       ),
//     );


Widget CommonBody2(
        dynamic controller, Widget widget,
        [EdgeInsetsGeometry padding =
            const  EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 1)]) =>
    Scaffold(
      backgroundColor:Colors.transparent,
      body: Padding(
        padding: padding,
        child: _CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            
            widget),
      ),
    );



Widget CommonBody(
        dynamic controller, Widget mobile, Widget tablet, Widget desktop,
        [EdgeInsetsGeometry padding =
            const EdgeInsets.only(top: 8, left: 8, right: 8)]) =>
    Scaffold(
      body: Padding(
        padding: padding,
        child: CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            mobile,
            tablet,
            desktop),
      ),
    );


