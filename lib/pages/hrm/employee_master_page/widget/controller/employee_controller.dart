import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/pages/hrm/employee_master_page/model/model_emp_load_master_table.dart';
import '../../../../../component/settings/config.dart';

class EmployeeController extends GetxController {
  var isDisableID = true.obs;
  var elist = <ModelMasterEmpTable>[].obs;
  //var elist_prifix = <ModelMasterEmpTable>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  late TextEditingController txt_emp_name = TextEditingController();


   SaveData(){
    print(txt_emp_name.text);
   }

  setEnableDisableID() {
    isDisableID(!isDisableID.value);
  }

  @override
  void onInit() async {
    isLoading(true);
    data_api2 api = data_api2();
    try {
      ModelUser user = await getUserInfo();
      // print(user.cid);
      if (user == null) {
        isLoading(false);
        isError(true);
        errorMessage('You have to re login!');
      } else {
        var x = await api.createLead([
          {"tag": "13", "cid": user.cid.toString()}
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

  @override
  void onClose() {
    txt_emp_name.dispose();
    elist.close();
    super.onClose();
  }
}
