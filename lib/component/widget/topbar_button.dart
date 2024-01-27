// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
 

class TopbarButton extends StatelessWidget {
  final String caption;
  final Function() fun;
  final IconData icon;
  final Color backcolor;
  final double blurRadius;
  final Color fontColor;
  const TopbarButton({
    Key? key,
    required this.caption,
    required this.fun,
    required this.icon,
    this.backcolor = const Color.fromARGB(255, 39, 99, 79),
    this.blurRadius = 0.5,
     this.fontColor= const Color.fromARGB(255, 233, 232, 232),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: fun,
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 2, right: 2, bottom: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                    color: backcolor,
                    blurRadius: blurRadius,
                    spreadRadius: 0.1,
                    offset: Offset(0, -1))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: const Color.fromARGB(255, 3, 221, 250),
              ),
              //Spacer(),
               const SizedBox(
                width: 5,
              ),
              Text(
                caption,
                style:  TextStyle(
                    fontSize: 14, color:fontColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
