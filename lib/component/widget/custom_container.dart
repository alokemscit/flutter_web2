
import 'package:flutter/material.dart';

import '../settings/config.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child = const SizedBox(),  this.width=double.infinity,  this.height=double.maxFinite,
  });

  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          border: Border.all(color: Colors.grey, width: 0.3),
          color: kBgLightColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 5.1,
              spreadRadius: 3.1,
            )
          ]),
      child: child,
    );
  }
}
