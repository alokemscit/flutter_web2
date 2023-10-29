
import 'package:flutter/material.dart';
class ShowButton extends StatelessWidget {
  final VoidCallback onTab;
  const ShowButton({
    Key? key,
    required this.onTab,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 35,
      child: ElevatedButton(
        onPressed: onTab,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.grey.shade700),
        ),
        child: const Text("Show"),
      ),
    );
  }
}