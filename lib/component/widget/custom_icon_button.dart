import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String caption;
  final IconData icon;
  final Function onTap;
  final Color bgColor;
  const CustomIconButton({
    Key? key,
    required this.caption,
    required this.icon,
    required this.onTap,  this.bgColor=const Color.fromARGB(255, 221, 217, 217),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton.icon(
        onPressed: () => onTap(),
        icon: Icon(icon,size: 20,),
        label: Padding(
          padding: const EdgeInsets.all(0),
          child: Text(caption,style: const TextStyle(fontSize: 13),),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              bgColor),
        ),
      ),
    );
  }
}
