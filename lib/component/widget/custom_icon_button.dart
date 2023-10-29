
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String caption;
  final IconData icon;
  final Function onTap;
  const CustomIconButton({
    Key? key,
    required this.caption,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => onTap(),
      icon:  Icon(icon),
      label:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(caption),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 117, 117, 117)),
      ),
    );
  }
}