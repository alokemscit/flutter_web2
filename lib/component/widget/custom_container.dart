// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../settings/config.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    this.child = const SizedBox(),
    this.width = double.infinity,
    this.height = double.infinity,
    this.label = "",
    this.labelColor = Colors.grey,
    this.labelToChildDistance = 30,
    this.padding = const EdgeInsets.only(left: 4),
    this.decoration =  const BoxDecoration(
    color: kBgLightColor, //.withOpacity(0.8),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 5.1,
        spreadRadius: 3.1,
      )
    ]),
  }) : super(key: key);

  final Widget child;
  final double width;
  final double height;
  final String label;
  final Color labelColor;
  final double labelToChildDistance;
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;



  @override
  Widget build(BuildContext context) {
    return Container(
     //width: width,
     // height: height,
      margin: const EdgeInsets.all(8),
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(
            height: labelToChildDistance,
          ),
          child,
        ],
      ),
    );
  }
}
 