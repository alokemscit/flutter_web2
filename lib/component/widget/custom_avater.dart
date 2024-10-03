
import 'package:flutter/material.dart';

class CustomAvater extends StatelessWidget {
  final double size;
  const CustomAvater({
    super.key,
    required this.size,
    required this.backgroundImage,
  });

  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        //backgroundColor: Colors.transparent,
        radius: 150,
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: CircleAvatar(
            radius: 220,
            backgroundImage: backgroundImage,
          ),
        ),
      ),
    );
  }
}
