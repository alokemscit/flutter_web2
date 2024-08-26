import 'package:flutter/material.dart';
import 'package:web_2/core/config/colors.dart';
import 'package:web_2/core/config/const.dart';
 
 

 
 

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.id,
      required this.list,
      required this.onTap,
      this.height = 28,
       this.width=100,
      this.borderColor = Colors.black38,
      this.labeltext = 'Select',
      this.borderRadious = 2,
      this.fontColor = Colors.black,
      this.isFilled = true,
      this.dropdownColor = Colors.white,
      this.fillColor = Colors.white,
      this.focusedBorderColor=Colors.black, 
      this.focusedBorderWidth=0.3, 
      this.enabledBorderColor=Colors.grey,
       this.enabledBorderwidth= 0.4, 
       this.hintTextColor= Colors.black,
        this.labelTextColor= appColorGrayDark,
       this.focusNode
      });

   
                     
                                  
                                      
                                      
                                      
                                     
              


 final FocusNode? focusNode;
  final double? height;
  final double? width;
  final String? id;
  final List<DropdownMenuItem<String>>? list;
  final void Function(String? value) onTap;
  final String? labeltext;
  final Color borderColor;
  final double borderRadious;
  final bool isFilled;
  final Color dropdownColor;
  final Color fontColor;
 final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderwidth;
  final Color hintTextColor;
  final Color labelTextColor;
final Color fillColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadious),
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 0,
          //     spreadRadius: 0.01,
          //     color: borderColor
          //   )
          // ]
        ),
      // margin: const EdgeInsets.only(left: 12,top: 12),
      width: width,
      height: height,
      child: DropdownButtonFormField(
        padding: EdgeInsets.zero,
        focusNode: focusNode,
         style:customTextStyle.copyWith(
          fontSize: 12, fontWeight: FontWeight.w500, color: fontColor),
        value: id==''?null:id,
        items: list,
        onChanged: onTap,
        dropdownColor: dropdownColor,
        decoration: InputDecoration(
          filled: isFilled,
          fillColor:
            fillColor,
          focusColor: Colors.white,
          labelText: labeltext,
            labelStyle:  customTextStyle.copyWith(
                    color: labelTextColor.withOpacity(0.8) ,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
                hintStyle:   customTextStyle.copyWith(color:hintTextColor, fontWeight: FontWeight.normal),
          //labelStyle: const TextStyle(fontSize: 14),
          //border: const OutlineInputBorder(),
    
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: borderColor, width: 0.5),
          //   borderRadius: BorderRadius.circular(borderRadious),
          // ),
    
          //  border: OutlineInputBorder(
          //         borderRadius:
          //             BorderRadius.all(Radius.circular(borderRadious)),
          //          borderSide: const BorderSide(color: Colors.white)
          //       ),
    
                 border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
            borderSide: const BorderSide(color: Colors.white),
            gapPadding :0,
            ),
    
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadious),
          borderSide:  BorderSide(color: focusedBorderColor, width: focusedBorderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadious),
          borderSide:  BorderSide(color:enabledBorderColor , width:enabledBorderwidth),
        ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        ),
        isDense: true,
        isExpanded: true,
      ),
    );
  }
}
