// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/employee_master_page/model/model_emp_load_master_table.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

class AttributeSetupHrController extends GetxController {
  late data_api2 api;
  var user = ModelUser().obs;
  late BuildContext context;

  final TextEditingController txt_designation = TextEditingController();
  final TextEditingController txt_grade = TextEditingController();
  final TextEditingController txt_gender = TextEditingController();
  final TextEditingController txt_religion = TextEditingController();
  final TextEditingController txt_marital = TextEditingController();
  final TextEditingController txt_blood = TextEditingController();
  final TextEditingController txt_identity = TextEditingController();
  final TextEditingController txt_emptype = TextEditingController();
  final TextEditingController txt_jobstatus = TextEditingController();
  final TextEditingController txt_prefix = TextEditingController();

  var cmb_designation_statusID = ''.obs;
  var cmb_grade_statusID = ''.obs;
  var cmb_gender_statusID = ''.obs;
  var cmb_religion_statusID = ''.obs;
  var cmb_marital_statusID = ''.obs;
  var cmb_blood_statusID = ''.obs;
  var cmb_identity_statusID = ''.obs;
  var cmb_emptype_statusID = ''.obs;
  var cmb_jobstatus_statusID = ''.obs;
  var cmb_prefix_statusID = ''.obs;

  var isLoading = false.obs;
  var is_designationLoading = false.obs;
  var is_gradeLoading = false.obs;
  var is_genderLoading = false.obs;
  var is_religionoading = false.obs;
  var is_maritalLoading = false.obs;
  var is_bloodLoading = false.obs;
  var is_iddentityLoading = false.obs;
  var is_emptypeLoading = false.obs;
  var is_jobstatusLoading = false.obs;
  var is_prefixLoading = false.obs;

  var edit_designationID = ''.obs;
  var edit_gradeID = ''.obs;
  var edit_genderID = ''.obs;
  var edit_religionID = ''.obs;
  var edit_maritalID = ''.obs;
  var edit_bloodlID = ''.obs;
  var edit_identityID = ''.obs;
  var edit_emptypeID = ''.obs;
  var edit_jobstatusID = ''.obs;
  var edit_prefixID = ''.obs;

  var isError = false.obs;
  var errorMessage = "".obs;
 
  var statusList = <ModelStatusMaster>[].obs;

  var designation_list = <ModelCommonMaster>[].obs;
  var grade_list = <ModelCommonMaster>[].obs;
  var gender_list = <ModelCommonMaster>[].obs;
  var religion_list = <ModelCommonMaster>[].obs;
  var marital_list = <ModelCommonMaster>[].obs;
  var blood_list = <ModelCommonMaster>[].obs;
  var identity_list = <ModelCommonMaster>[].obs;
  var emptype_list = <ModelCommonMaster>[].obs;
  var jobstatus_list = <ModelCommonMaster>[].obs;
  var prefix_list = <ModelCommonMaster>[].obs;

  @override
  Future<void> onInit() async {
    api = data_api2();
    isError.value = false;
    isLoading.value = true;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      var x = await api.createLead([
        {"tag": "13", "cid": user.value.cid.toString()}
      ]);
      var aaa = x.map((e) => ModelMasterEmpTable.fromJson(e)).toList();
      aaa.sort((a, b) => a.name!.compareTo(
            b.name!,
          ));

      designation_list.addAll(getList(aaa, "designation"));
      grade_list.addAll(getList(aaa, "grade"));
      gender_list.addAll(getList(aaa, "gender"));
      religion_list.addAll(getList(aaa, "religion"));
      marital_list.addAll(getList(aaa, "marital"));
      blood_list.addAll(getList(aaa, "bloodgroup"));
      identity_list.addAll(getList(aaa, "identitytype"));
      emptype_list.addAll(getList(aaa, "employementtype"));
      jobstatus_list.addAll(getList(aaa, "jobstatus"));

      prefix_list.addAll(getList(aaa, "prefix"));

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
      isLoading.value = false;
    }

    super.onInit();
  }

  List<ModelCommonMaster> getList(
          List<ModelMasterEmpTable> a, String filter) =>
      a
          .where((element) => element.tp == filter)
          .map((e) =>
              ModelCommonMaster(id: e.id, name: e.name, status: e.status))
          .toList();
}
