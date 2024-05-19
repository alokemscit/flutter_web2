
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
      width: 85,
      height: 32,
      child: ElevatedButton(
      
        onPressed: onTab,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 119, 118, 118)),
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromARGB(255, 224, 223, 223)),
        ),
        child: const Text("Show"),
      ),
    );
  }
}