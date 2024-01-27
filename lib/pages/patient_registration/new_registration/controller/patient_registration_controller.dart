import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/settings/config.dart';
import '../../../../data/data_api.dart';
import '../../../../model/model_user.dart';
import '../../../hrm/employee_master_page/model/model_emp_load_master_table.dart';

class PatRegController extends GetxController{
   var elist = <ModelMasterEmpTable>[].obs;
 var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var companyName = "".obs;
  var uid = 0.obs;
  //var user=ModelUser().obs;
  var user = ModelUser().obs;

  late BuildContext context;
   @override
   void onInit() async{
    data_api2 api = data_api2();
    try {
      user.value = await getUserInfo();
      // print(user.cid);
      if (user.value == null) {
        isLoading(false);
        isError(true);
        errorMessage('You have to re login!');
      } else {
        companyName(user.value.cname);
        var x = await api.createLead([
          {"tag": "13", "cid": user.value.cid.toString()}
        ]);
        var aaa = x.map((e) => ModelMasterEmpTable.fromJson(e)).toList();
        aaa.sort((a, b) => a.name!.compareTo(
              b.name!,
            ));
        elist.addAll(aaa);
        isError(false);
        isLoading(false);

        // print(x.toString());
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errorMessage(e.toString());
    }
    super.onInit();
  }
}