import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.id,
      required this.list,
      required this.onTap,
      this.height = 35,
      required this.width,
      this.borderColor = Colors.black38,
      this.labeltext = 'Select',
      this.borderRadious = 4.0,
      this.isFilled = true,  this.dropdownColor=Colors.white});
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        // margin: const EdgeInsets.only(left: 12,top: 12),
        width: width,
        height: height,
        child: DropdownButtonFormField(
        
          value: id,
          items: list,
          onChanged: onTap,
          dropdownColor:dropdownColor,
          decoration: InputDecoration(
            
            filled: isFilled,
            fillColor: Colors.white,
            labelText: labeltext,
            labelStyle: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w300,
                fontSize: 13),
            hintStyle: TextStyle(
                color: Colors.grey.shade400, fontWeight: FontWeight.w300),
            //labelStyle: const TextStyle(fontSize: 14),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 0.5),
              borderRadius: BorderRadius.circular(borderRadious),
            ),
           // contentPadding:
               // const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          ),
          isDense: true,
          isExpanded: true,
        ),
      ),
    );
  }
}
