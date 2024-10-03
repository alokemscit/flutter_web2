// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'colors.dart';
import 'const_string.dart';

TextStyle customTextStyle = const TextStyle(
  color: Colors.black, fontFamily: appFontMuli,
  fontSize: 14,
  fontWeight: FontWeight.bold, //height:0.6
);

BoxDecoration CustomBoxDecorationTopRounded = const BoxDecoration(
    color: appColorPista, //.withOpacity(0.8),
    // color: Color.fromARGB(255, 252, 251, 251),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 15.1,
        spreadRadius: 3.1,
      )
    ]);

TextStyle customTextStyleDefault = const TextStyle(
    fontFamily: appFontMuli, fontSize: 9, fontWeight: FontWeight.w400);

ButtonStyle customButtonStyle = ButtonStyle(
    foregroundColor:
        WidgetStateProperty.all<Color>(Colors.white), // Set button text color
    backgroundColor: WidgetStateProperty.all<Color>(appColorBlue),
    textStyle: WidgetStateProperty.all<TextStyle>(
      const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    ));

BoxDecoration customBoxDecoration = BoxDecoration(
  // color: appColorBlue.withOpacity(0.05),
  color: kWebBackgroundColor,
  borderRadius:
      const BorderRadius.all(Radius.circular(8)), // Uncomment this line
  border: Border.all(
      color: appColorGrayDark,
      width: 0.108,
      strokeAlign: BorderSide.strokeAlignCenter),
  boxShadow: [
    BoxShadow(
      color: appColorBlue.withOpacity(0.0085),
      spreadRadius: 0.1,
      blurRadius: 5.2,
      //offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: appColorBlue.withOpacity(0.0085),
      spreadRadius: 0.2,
      blurRadius: 3.2,
      //offset: const Offset(1, 0),
    ),
  ],
);

// Widget headerCloseButton() => const Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 55,
//         ),
//         CustomAppBarCloseButton(),
//       ],
//     );

TableBorder CustomTableBorder() =>
    TableBorder.all(width: 0.5, color: const Color.fromARGB(255, 89, 92, 92));

TableBorder CustomTableBorderNew =
    TableBorder.all(width: 0.4, color: appColorGrayDark);

CustomTableCell(String text,
        [TextStyle style =
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)]) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        text,
        style: style,
      ),
    );

Decoration CustomTableHeaderRowDecoration() => BoxDecoration(
        color: kBgDarkColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3)
        ]);

BoxDecoration CustomTableHeaderRowDecorationnew = BoxDecoration(
    color: appColorGrayDark.withOpacity(0.08),
    borderRadius: const BorderRadius.all(
      Radius.circular(4),
    ),
    boxShadow: [
      BoxShadow(
          color: appColorGrayDark.withOpacity(0.08),
          spreadRadius: .2,
          blurRadius: .1)
    ]);

CustomCaptionDecoration(
    [double borderWidth = 0.3, Color borderColor = Colors.black]) {
  return BoxDecorationTopRounded.copyWith(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      color: backgroundColor,
      border: Border(
          left: BorderSide(
              color: borderColor.withOpacity(0.3), width: borderWidth),
          right: BorderSide(
              color: borderColor.withOpacity(0.3), width: borderWidth),
          bottom: BorderSide(
              color: borderColor.withOpacity(0.3),
              width:
                  borderWidth)) //   .all(color: borderColor.withOpacity(0.3), width: borderWidth)
      );
}

BoxDecoration BoxDecorationTopRounded = const BoxDecoration(
    color: kBgLightColor, //.withOpacity(0.8),
    // color: Color.fromARGB(255, 252, 251, 251),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 15.1,
        spreadRadius: 3.1,
      )
    ]);

Widget oneColumnCellBody(String leftString,
        [double fontSize = 12,
        Alignment alignment = Alignment.centerLeft,
        FontWeight? fontWeight = FontWeight.w400,
        EdgeInsets? padding = const EdgeInsets.all(4)]) =>
    Row(children: [
      Expanded(
        child: Container(
            decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(0),
                // color: Colors.white,
                border: Border(
                    // top: BorderSide(color: borderColor, width: 0.2),
                    right: BorderSide(color: appColorGrayDark, width: 0.5))),
            padding: padding,
            child: Align(
                alignment: alignment,
                child: Text(
                  leftString,
                  style: customTextStyle.copyWith(
                      fontSize: fontSize, fontWeight: fontWeight),
                ))),
      ),
    ]);
Widget CustomTableColumnCellBody(String leftString,
        [double fontSize = 12,
        Alignment alignment = Alignment.centerLeft,
        FontWeight? fontWeight = FontWeight.w400,
        EdgeInsets? padding = const EdgeInsets.all(4)]) =>
    Row(children: [
      Expanded(
        child: Container(
            decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(0),
                // color: Colors.white,
                border: Border(
                    // top: BorderSide(color: borderColor, width: 0.2),
                    right: BorderSide(color: appColorGrayDark, width: 0.5))),
            padding: padding,
            child: Align(
                alignment: alignment,
                child: Text(
                  leftString,
                  style: customTextStyle.copyWith(
                      fontSize: fontSize, fontWeight: fontWeight),
                ))),
      ),
    ]);

Widget twoColumnCellBody(String leftString, String rightString,
        [double fontSize = 12]) =>
    Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
              decoration: const BoxDecoration(
                  //  color: Colors.white,
                  border: Border(
                      // top: BorderSide(color: borderColor, width: 0.2),
                      right: BorderSide(color: appColorGrayDark, width: 0.5))),
              padding: const EdgeInsets.all(4),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    leftString,
                    style: customTextStyle.copyWith(
                        fontSize: fontSize, fontWeight: FontWeight.w400),
                  ))),
        ),
        Expanded(
          flex: 5,
          child: Container(
              decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                      //  top: BorderSide(color: borderColor, width: 0.2),
                      right: BorderSide(color: appColorGrayDark, width: 0.5))),
              padding: const EdgeInsets.all(4),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    rightString,
                    style: customTextStyle.copyWith(
                        fontSize: fontSize, fontWeight: FontWeight.w400),
                  ))),
        )
      ],
    );

Widget tableBodyGenerator(List<int> col, List<TableRow> children) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: appColorGrayDark, width: 0.5)),
      child: Table(
        // border: CustomTableBorderNew,
        columnWidths: customColumnWidthGenarator(col),
        children: children,
      ),
    );

Map<int, TableColumnWidth> customColumnWidthGenarator(List<int> columnWidth) {
  final Map<int, TableColumnWidth> columnWidthMap = {};

  for (int i = 0; i < columnWidth.length; i++) {
    columnWidthMap[i] = FlexColumnWidth(columnWidth[i].toDouble());
  }

  return columnWidthMap;
}

Widget CustomTableClumnHeader(String text,
        [Alignment alignment = Alignment.centerLeft,
        bool isBorderRight = true,
        double fontSize = 12,
        FontWeight fontWeight = FontWeight.w600,
        EdgeInsets padding = const EdgeInsets.all(6)]) =>
    Row(children: [
      Expanded(
        child: Container(
            decoration: BoxDecoration(
                border: !isBorderRight
                    ? const Border()
                    : const Border(
                        // top: BorderSide(color: borderColor, width: 0.2),
                        right:
                            BorderSide(color: appColorGrayDark, width: 0.5))),
            padding: padding,
            child: Align(
                alignment: alignment,
                child: Text(
                  text,
                  style: customTextStyle.copyWith(
                      fontSize: fontSize, fontWeight: fontWeight),
                ))),
      ),
    ]);

List<BoxShadow> myboxShadow = [
  const BoxShadow(
    color: Color.fromARGB(255, 230, 229, 229),
    offset: Offset(2, 2),
    blurRadius: 2,
    spreadRadius: 1,
  ),
  const BoxShadow(
    color: Color.fromARGB(31, 255, 255, 255),
    offset: Offset(-10, -10),
    blurRadius: 2,
    spreadRadius: 1,
  ),
];

BoxDecoration BoxDecorationForAccordian = BoxDecoration(
  color: kWebHeaderColor.withOpacity(0.01),
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  ),
  //border: Border(left: BorderSide(width: 0.2)),
  //border: Border.all(color: Colors.black38, width: 0.1),
  boxShadow: [
    BoxShadow(
        color: Colors.black38.withOpacity(0.1),
        blurRadius: 1.05,
        spreadRadius: 0.1)
  ],
);

TextStyle CustomDropdownTextStyle =
    customTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500);
