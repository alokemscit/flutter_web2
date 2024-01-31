import 'package:flutter/material.dart';
import '../settings/config.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, this.style, required this.child, this.onTap});

  getStyle() {
    return customButtonStyle.copyWith(
        backgroundColor:
            MaterialStateProperty.all<Color>(kWebHeaderColor.withOpacity(0.6)));
  }
  final ButtonStyle? style;
  final Widget child;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    bool b = true;
    return ElevatedButton(
      onPressed: () {
        if (b) {
          b = false;
          // Disable the button temporarily
          onTap!();

          // Enable the button after the specified debounce duration
          Future.delayed(const Duration(seconds: 2), () {
            b = true;
          });
        }
      }, // Corrected line
      style: style ?? getStyle(),
      child: child,
    );
  }
}
