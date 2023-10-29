import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.id,
      required this.list,
      required this.onTap,
      this.height = 35,
     required  this.width, this.labeltext='Select'});
  final double? height;
  final double? width;
  final String? id;
  final List<DropdownMenuItem<String>>? list;
  final void Function(String? value) onTap;
  final String?labeltext;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.only(left: 12,top: 12),
      width: width,
      height: height,
      child: DropdownButtonFormField(
        value: id,
        items: list,
        onChanged: onTap,
        decoration:  InputDecoration(
          labelText: labeltext,
           labelStyle: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w500,fontSize: 14),
          //labelStyle: const TextStyle(fontSize: 14),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        ),
        isDense: true,
        isExpanded: true,
      ),
    );
  }
}
