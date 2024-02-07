import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../settings/rive_config.dart';

// ignore: must_be_immutable
class Circular extends StatelessWidget {
   Circular({super.key});
late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  @override
  Widget build(BuildContext context) {
    return  Center(

child: SizedBox(
   
 width: 80,
 height: 80,
 child: 
 RiveAnimation.asset(
     "assets/RiveAssets/check.riv",
      onInit: (artboard) {
                StateMachineController controller = getRiveController(artboard);
                                               
                          },
     
     
     ),
));
 }
}