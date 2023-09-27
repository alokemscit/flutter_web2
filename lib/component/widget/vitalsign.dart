// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CapWithTextFields extends StatelessWidget {
  final String caption;
  final double width;
  final int maxlength ;
  final TextEditingController controller;
  const CapWithTextFields({
    Key? key,
    required this.caption,
    this.width = 65,
     this.maxlength= 6,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            caption,
            style: GoogleFonts.roboto(
                color: Colors.black,
                backgroundColor: Colors.transparent,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: width,
            height: 25,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: TextField(
              maxLength: maxlength,
              // canRequestFocus : false,
              maxLines: 1,
              //   textCapitalization : TextCapitalization.none,
              // keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                  //  labelText: 'Enter text',
                  counterText: '',
                  border: OutlineInputBorder()),
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
