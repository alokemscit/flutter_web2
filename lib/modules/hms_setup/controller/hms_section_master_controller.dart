import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_department.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
 
import 'package:web_2/modules/hms_setup/model/model_hms_department.dart';
import 'package:web_2/modules/hms_setup/model/model_hrms_section_master.dart';

class HmsSectionMasterController extends GetxController {
  late BuildContext context;
  late data_api2 api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatusMaster>[].obs;
  var editTestID = ''.obs;
  var cmb_departmentID = ''.obs;
  var cmb_groupID = ''.obs;
  var cmb_headID = ''.obs;
  var cmb_statusID = ''.obs;
  final TextEditingController txt_test_name = TextEditingController();
  final TextEditingController txt_tsearch = TextEditingController();

  var department_list_all = <ModelDepartment>[].obs;

  var group_list_all = <ModelHmsDepartmentMaster>[].obs;
  var group_list_temp = <ModelHmsDepartmentMaster>[].obs;

   
  var testmain_list_all = <ModelHmsSectionMaster>[].obs;
  var testmain_list_temp = <ModelHmsSectionMaster>[].obs;

  void searchSection() {
    var x = testmain_list_all.where((p0) =>
        p0.name!.toUpperCase().contains(txt_tsearch.text.toUpperCase()) ||
        p0.hrDeptName!.toUpperCase().contains(txt_tsearch.text.toUpperCase()));
    testmain_list_temp.clear();
    testmain_list_temp.addAll(x);
  }

  void LoadGroupList() async {
    print("load hms department");
    group_list_temp.clear();
    group_list_temp.addAll(
        group_list_all.where((p0) => p0.deptId == cmb_departmentID.value));
  }

  void saveUpdateMainTest() async {
    dialog = CustomAwesomeDialog(context: context);
    // print("ok");
    if (txt_test_name.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter Section name!"
        ..show();
      return;
    }
    if (cmb_departmentID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select HR department!"
        ..show();
      return;
    }
    if (cmb_groupID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select HMS Department!"
        ..show();
      return;
    }

    if (cmb_statusID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select status!"
        ..show();
      return;
    }

    try {
      loader = CustomBusyLoader(context: context);
      loader.show();
      //@cid,@did , @id ,@name ,@status

      // print([
      //   {
      //     "tag": "49",
      //     "cid": user.value.cid,
      //     "did": cmb_groupID.value,
      //     "id": editTestID.value == '' ? "0" : editTestID.value,
      //     "name": txt_test_name.text,
      //     "status": cmb_statusID.value
      //   }
      // ]);

      api.createLead([
        {
          "tag": "49",
          "cid": user.value.cid,
          "did": cmb_groupID.value,
          "id": editTestID.value == '' ? "0" : editTestID.value,
          "name": txt_test_name.text,
          "status": cmb_statusID.value
        }
      ]).then((value) {
        loader.close();
        getStatusWithDialog(value, dialog).then((value) {
          if (editTestID.value != '') {
            testmain_list_all
                .removeWhere((element) => element.id == editTestID.value);
          }

          testmain_list_all.insert(
              0,
              ModelHmsSectionMaster(
                  hmsDeptId: cmb_groupID.value,
                  hrDeptId: cmb_departmentID.value,
                  id: value.id,
                  name: txt_test_name.text,
                  status: cmb_statusID.value,
                  hrDeptName: department_list_all
                      .where((p0) => p0.id == cmb_departmentID.value)
                      .first
                      .name,
                  hmsDeptName: group_list_all
                      .where((p0) => p0.id == cmb_groupID.value)
                      .first
                      .name));
          testmain_list_temp.clear();
          testmain_list_temp.addAll(testmain_list_all);
          editTestID.value = '';
          txt_test_name.text = '';
          cmb_statusID.value = '';
        });
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
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
        {"tag": "50", "cid": user.value.cid}
      ]);
      department_list_all
          .addAll(x.map((e) => ModelDepartment.fromJson(e)).toList());

      

      x = await api.createLead([
        {"tag": "44", "cid": user.value.cid}
      ]);

      group_list_all
          .addAll(x.map((e) => ModelHmsDepartmentMaster.fromJson(e)).toList());

      group_list_temp.clear();

      x = await api.createLead([
        {"tag": "48", "cid": user.value.cid}
      ]);

      testmain_list_all
          .addAll(x.map((e) => ModelHmsSectionMaster.fromJson(e)).toList());
      testmain_list_temp.addAll(testmain_list_all);

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }
}
