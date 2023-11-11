
import 'package:flutter/material.dart';
 

class CustomButton extends StatelessWidget {
  final String text;
 
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
      margin: const EdgeInsets.all(0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey,foregroundColor: Colors.black,textStyle: TextStyle(fontSize: 13)),
            
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
