import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;
  final bool isPading;
  final double height;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isPading = true,this.height=32});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: isPading
          ? const EdgeInsets.symmetric(horizontal: 2, vertical: 2)
          : EdgeInsets.zero,
      margin: const EdgeInsets.all(0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 207, 207, 207),
            foregroundColor: const Color.fromARGB(255, 75, 75, 75),
            textStyle: const TextStyle(fontSize: 13)),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
