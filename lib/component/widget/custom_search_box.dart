
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final Color borderBolor;


  const CustomSearchBox(
      {Key? key,
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
      this.borderBolor = Colors.black38,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return   Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: width,
          height: height,

          // padding: const EdgeInsets.only(bottom: 12),
          // color:Colors.amber, // const Color.fromARGB(255, 255, 255, 255),
      
              child: TextField(
                onChanged: (value) => onChange(value),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: fontColor),
                textAlignVertical: TextAlignVertical.center,

                textAlign: textAlign!,
                decoration: InputDecoration(
                  labelText: caption,
                  labelStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w300,
                      fontSize: 13),
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.w300),
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadious)),
                    // borderSide: const BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadious),
                    borderSide: BorderSide(color: borderBolor, width: 0.5),
                  ),
                  prefixIcon:  const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                ),
                controller: controller,
              ),),);
  }
}

      


