// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../settings/config.dart';
 

class CustomSearchBox extends StatelessWidget {
  final String caption;
  final double width;
  final int maxlength;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? maxLine;
  final double? height;
  final TextAlign? textAlign;
  final Function(String value) onChange;
  final double borderRadious;
  final Color fontColor;
  final Color borderColor;
  //final Function onTap;
  final bool isFilled;
  final VoidCallback? onTap;
  final Color fillColor;
  final Color prefixIconColor;

  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderwidth;
  final Color hintTextColor;
  final Color labelTextColor;
  

  const CustomSearchBox({
    super.key,
    required this.caption,
    this.width = 65,
    this.maxlength = 6,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.maxLine = 1,
    this.height = 32,
    this.textAlign = TextAlign.start,
    required this.onChange,
    this.borderRadious = 4.0,
    this.fontColor = Colors.black87,
    this.borderColor = Colors.black38,
    this.isFilled = false,
    this.onTap,
    this.fillColor = Colors.white38,
    this.prefixIconColor = Colors.grey,
    this.focusedBorderColor = CPLineCChart,
    this.focusedBorderWidth = 0.5,
    this.enabledBorderColor = CPLineCChart,
    this.enabledBorderwidth = 0.25,
    this.hintTextColor = Colors.black,
    this.labelTextColor = Colors.black,
    
  });
  getData() {
    return '';
  }

  

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: width,
      height: height,

      // padding: const EdgeInsets.only(bottom: 12),
      // color:Colors.amber, // const Color.fromARGB(255, 255, 255, 255),

      child: TextField(
         
        onChanged: (value) => onChange(value),
        onTap: onTap,
        keyboardType: textInputType,

        inputFormatters: textInputType == TextInputType.multiline
            ? []
            : textInputType == TextInputType.text
                ? []
                : [
                    textInputType == TextInputType.number
                        ? FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d*'))
                        : FilteringTextInputFormatter.digitsOnly
                  ],
        maxLength: maxlength,
        // canRequestFocus : false,
        maxLines: maxLine,
        //   textCapitalization : TextCapitalization.none,
        // keyboardType: TextInputType.number,
        style: GoogleFonts.roboto(
            fontSize: 15, fontWeight: FontWeight.w500, color: fontColor),
        textAlignVertical: TextAlignVertical.center,

        textAlign: textAlign!,
        decoration: InputDecoration(
          fillColor:
              fillColor, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
          filled: isFilled,
          labelText: caption,
          labelStyle: TextStyle(
              color: labelTextColor, fontWeight: FontWeight.w300, fontSize: 14),
          hintStyle:
              TextStyle(color: hintTextColor, fontWeight: FontWeight.w300),
          counterText: '',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
              borderSide: const BorderSide(color: Colors.white)),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
            borderSide: BorderSide(
                color: focusedBorderColor, width: focusedBorderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadious),
            borderSide: BorderSide(
                color: enabledBorderColor, width: enabledBorderwidth),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: prefixIconColor,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        ),
        controller: controller,
      ),
    );
  }
}
