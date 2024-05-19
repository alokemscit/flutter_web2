import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';

mixin MixInController{
   late BuildContext context;
   late data_api2 api;
   late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatusMaster>[].obs;
}