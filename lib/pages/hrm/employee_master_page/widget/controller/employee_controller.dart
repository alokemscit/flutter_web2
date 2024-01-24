// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
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
  var companyName = "".obs;

  final TextEditingController txt_emp_id = TextEditingController();
  final TextEditingController txt_emp_name = TextEditingController();
  final TextEditingController txt_emp_dob = TextEditingController();
  var cmb_prefix = ''.obs;
  var cmb_nationality = ''.obs;

  final TextEditingController txt_emp_father = TextEditingController();
  final TextEditingController txt_emp_mother = TextEditingController();
  final TextEditingController txt_emp_spouse = TextEditingController();
  var cmb_gender = ''.obs;
  var cmb_religion = ''.obs;
  var cmb_maritalstatus = ''.obs;
  var cmb_bloodgroup = ''.obs;
  var cmb_identitytype = ''.obs;
  final TextEditingController txt_emp_identityname = TextEditingController();

  var cmb_designation = ''.obs;
  var cmb_grade = ''.obs;
  var cmb_department = ''.obs;
  var cmb_section = ''.obs;
  var cmb_emptype = ''.obs;

  var cmb_jobstatus = ''.obs;
  final TextEditingController txt_emp_doj = TextEditingController();

  SaveData() async {
    print(txt_emp_name.text);
    Get.dialog(
      transitionCurve: Curves.easeInOutBack,
      transitionDuration: const Duration(seconds: 1),
      barrierColor: Colors.black.withOpacity(0.2),
      Center(
        child: CupertinoPopupSurface(
          child: Container(
            color: Colors.black,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                  //SizedBox(height: 16),
                  //Text('Loading...'),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    await Future.delayed(const Duration(seconds: 4));
    Get.back();
    // customAwesamDialodOk(
    //     Get.context!, DialogType.question, "Testing", "ABCD", () {});
  }

  setEnableDisableID() {
    isDisableID(!isDisableID.value);
  }

  @override
  void onInit() async {
    print("init call");
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
        companyName(user.cname);
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
    txt_emp_id.dispose();
    cmb_prefix.close();
    txt_emp_dob.dispose();
    cmb_nationality.close();
    companyName.close();
    txt_emp_father.dispose();
    txt_emp_mother.dispose();
    txt_emp_spouse.dispose();
    cmb_gender.close();
    cmb_religion.close();
    cmb_maritalstatus.close();
    cmb_bloodgroup.close();
    cmb_identitytype.close();
    txt_emp_identityname.dispose();
    cmb_designation.close();
    cmb_grade.close();
    cmb_department.close();
    cmb_section.close();
    cmb_emptype.close();
    cmb_jobstatus.close();
    txt_emp_doj.dispose();
    elist.close();
    super.dispose();
    print("super call dispose");
    super.onClose();
  }
}
