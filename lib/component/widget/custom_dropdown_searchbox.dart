import 'dart:async';

import '../../core/config/const.dart';
import 'searchable_dropdown/src/material/typeahead_field.dart';

class CustomDropDownSearchbox<T> extends StatelessWidget {
  //final List<T> list;
  TextEditingController controller;
  String id;
  final FocusNode? focusNode;
  void Function(String)? onChange;
  Function(String)? onSubmitted;
  void Function(T)? onSelected;
  Widget Function(BuildContext, T) itemBuilder;
  FutureOr<List<T>?> Function(String) suggestionsCallback;
  String caption;
  double width;
  int maxlength;

  TextInputType? textInputType;
  int? maxLine;
  double? height;
  TextAlign? textAlign;

  //final Function(RawKeyEvent event) onKey;
  double borderRadious;
  Color fontColor;
  Color borderColor;

  bool isFilled;
  bool isReadonly;
  bool isDisable;
  Color hintTextColor;
  Color labelTextColor;

  Color focusedBorderColor;
  double focusedBorderWidth;
  Color enabledBorderColor;
  double enabledBorderwidth;

  bool isCapitalization;
  bool iSAutoCorrected;
  Color disableBackColor;
  Color fillColor;
  String hintText;
  FontWeight fontWeight;
  bool isError;

  CustomDropDownSearchbox(
      {super.key,
      required this.id,
      // required this.list,
      this.caption = '',
      this.width = 65,
      this.maxlength = 100,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.height = 28,
      this.textAlign = TextAlign.start,
      this.borderRadious = 2.0,
      this.fontColor = Colors.black,
      this.borderColor = Colors.black,
      this.isFilled = false,
      this.isReadonly = false,
      this.isDisable = false,
      this.hintTextColor = Colors.black,
      this.labelTextColor = appColorGrayDark,
      this.focusedBorderColor = Colors.black,
      this.focusedBorderWidth = 0.4,
      this.enabledBorderColor = Colors.grey,
      this.enabledBorderwidth = 0.6,
      this.disableBackColor = appColorGrayLight,
      this.focusNode,
      this.fontWeight = FontWeight.w500,
      this.hintText = '',
      this.fillColor = Colors.white,
      this.isCapitalization = false,
      this.iSAutoCorrected = false,
      this.isError = false,
      this.onChange,
      this.onSelected,
      this.onSubmitted,
      required this.itemBuilder,
      required this.suggestionsCallback});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      controller: controller,
      suggestionsCallback: (search) => suggestionsCallback(search),
      builder: (context, controller, focusNode) {
        return CustomTextBox(
          borderColor: borderColor,
          borderRadious: borderRadious,
          caption: caption,
          disableBackColor: disableBackColor,
          enabledBorderColor: enabledBorderColor,
          enabledBorderwidth: enabledBorderwidth,
          fillColor: fillColor,
          focusedBorderColor: focusedBorderColor,
          focusedBorderWidth: focusedBorderWidth,
          fontColor: fontColor,
          fontWeight: fontWeight,
          height: height,
          hintText: hintText,
          hintTextColor: hintTextColor,
          iSAutoCorrected: iSAutoCorrected,
          isCapitalization: iSAutoCorrected,
          isDisable: isDisable,
          isError: isError,
          isFilled: isFilled,
          isReadonly: isReadonly,
          key: key,
          labelTextColor: labelTextColor,
          maxLine: maxLine,
          maxlength: maxlength,
          textAlign: textAlign,
          textInputType: textInputType,
          width: width,
          controller: controller,
          focusNode: focusNode,
          onChange: (v) {
            if (onChange != null) {
              onChange!(v);
            }
          },
          onSubmitted: (p0) {
            if (onSubmitted != null) {
              onSubmitted!(p0);
            }
          },
        );
      },
      decorationBuilder: (context, child) => Material(
        type: MaterialType.card,
        elevation: 4,
        borderRadius: BorderRadius.circular(2),
        child: child,
      ),
      itemBuilder: itemBuilder,
      onSelected: (c) {
       
        if (onSelected != null) {
          onSelected!(c);
        }
      },
    );
  }

  // List<T> _getSuggestions(String query) {
  //   return list
  //       .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }
}
