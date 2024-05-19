import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';

import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

class LabServiceCategoryHeadController extends GetxController {
  //LabServiceCategoryHeadController({required this.context});
  late BuildContext context;
  late data_api2 api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatusMaster>[].obs;
  var service_urgency_List = <ModelCommonMaster>[].obs;
  var service_head_List = <ModelCommonMaster>[].obs;

  
  // var department_list_all = <ModelDepartment>[].obs;
  var cmb_service_cat_status = ''.obs;
  var cmb_head_status = ''.obs;
  var editServiceCatID = ''.obs;
  var editHeadID = ''.obs;

  final TextEditingController txt_ServiceCatName = TextEditingController();
  final TextEditingController txt_HeadName = TextEditingController();
  final TextEditingController txt_HeadName_search = TextEditingController();

   

  void saveUpdateHead() {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_HeadName.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter Charge Name"
        ..show();
      return;
    }
    if (cmb_head_status.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select valid status"
        ..show();
      return;
    }
    try {
      loader = CustomBusyLoader(context: context);
      loader.show();
      api.createLead([
        {
          "tag": "43",
          "id": editHeadID.value,
          "cid": user.value.cid,
          "name": txt_HeadName.text,
          "status": cmb_head_status.value
        }
      ]).then((value) {
        loader.close();
        getStatusWithDialog(value, dialog).then((value) {
          if (value.status == "1") {
            service_head_List
                .removeWhere((element) => element.id == editHeadID.value);
            service_head_List.insert(
                0,
                ModelCommonMaster(
                    id: value.id,
                    name: txt_HeadName.text,
                    status: cmb_head_status.value));
            txt_HeadName.text = '';
            editHeadID.value = '';
            cmb_head_status.value = '1';

             
          }
        });
      });
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      loader.close();
    }
  }

  void saveUpdateServiceUrgebcy() {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_ServiceCatName.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid Service of Urgency Name"
        ..show();
      return;
    }
    if (cmb_service_cat_status.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select valid status for Service of Urgency Name"
        ..show();
      return;
    }

    try {
      loader = CustomBusyLoader(context: context);
      loader.show();
      //@id,@cid ,@name ,@status
      api.createLead([
        {
          "tag": "42",
          "id": editServiceCatID.value,
          "cid": user.value.cid,
          "name": txt_ServiceCatName.text,
          "status": cmb_service_cat_status.value
        }
      ]).then((value) {
        loader.close();
        getStatusWithDialog(value, dialog).then((value) {
          if (value.status == "1") {
            service_urgency_List
                .removeWhere((element) => element.id == editServiceCatID.value);
            service_urgency_List.insert(
                0,
                ModelCommonMaster(
                    id: value.id,
                    name: txt_ServiceCatName.text,
                    status: cmb_service_cat_status.value));
            txt_ServiceCatName.text = '';
            editServiceCatID.value = '';
            cmb_service_cat_status.value = "1";
          }
        });
      });
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      loader.close();
    }
  }

  @override
  void dispose() {
    // Use the saved reference to the ancestor widget
    // This ensures that the ancestor widget is still accessible during dispose

    super.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    // dialog = CustomAwesomeDialog(context: context);
    // loader = CustomBusyLoader(context: context);
    api = data_api2();
    isLoading.value = true;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      if (user.value == null) {
        isLoading.value = false;
        isError.value = true;
        errorMessage.value = 'You have to re-login again';
        return;
      }
      var x = await api.createLead([
        {"tag": "40", "cid": user.value.cid}
      ]);
      service_urgency_List
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "41", "cid": user.value.cid}
      ]);
      service_head_List
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());

     
      isLoading.value = false;
      isError.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }
}
