import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
 
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
 

import '../../component/widget/custom_awesome_dialog.dart';

mixin MixInController {
   late BuildContext context= Get.context!;
   late data_api2 api=data_api2();
   late CustomAwesomeDialog dialog=CustomAwesomeDialog(context: context);
  late CustomBusyLoader loader=CustomBusyLoader(context: context);
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  
  
 // var statusList = <ModelStatus>[].obs;
}


mixin MixinMethod {
  void disposeController();
}