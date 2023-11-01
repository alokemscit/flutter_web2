 import 'package:rive/rive.dart';

StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

   SMITrigger initSMI(Artboard artboard,String name)=>  getRiveController(artboard).findSMI(name) as SMITrigger;
   // StateMachineController controller =
     
                                                
  
  