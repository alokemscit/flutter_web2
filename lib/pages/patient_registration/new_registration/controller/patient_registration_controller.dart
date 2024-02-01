import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/functions.dart';

import '../../../../component/settings/config.dart';
import '../../../../data/data_api.dart';
import '../../../../model/model_user.dart';
import '../../../hrm/employee_master_page/model/model_emp_load_master_table.dart';

class PatRegController extends GetxController {
  final Rx<File> imageFile = File('').obs;
  final TextEditingController txt_hcn = TextEditingController();

  final TextEditingController txt_mother_hcn = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_dob = TextEditingController();
  final TextEditingController txt_father_name = TextEditingController();
  final TextEditingController txt_mother_name = TextEditingController();
  final TextEditingController txt_spouse_name = TextEditingController();
  final TextEditingController txt_guardian_name = TextEditingController();
  final TextEditingController txt_identity_number = TextEditingController();
  final TextEditingController txt_cell_phone = TextEditingController();
  final TextEditingController txt_home_phone = TextEditingController();
  final TextEditingController txt_email = TextEditingController();
  final TextEditingController txt_emergency_number = TextEditingController();

  final TextEditingController txt_empid = TextEditingController();
  final TextEditingController txt_emergency_address = TextEditingController();
  final TextEditingController txt_present_address = TextEditingController();
  final TextEditingController txt_permanent_address = TextEditingController();

  var elist = <ModelMasterEmpTable>[].obs;
  var plist = <ModelMasterEmpTable>[].obs;
  var stateList_emergency = <ModelMasterEmpTable>[].obs;
  var districtList_emergency = <ModelMasterEmpTable>[].obs;
  var cmb_emergency_district = ''.obs;

  var stateList_Present = <ModelMasterEmpTable>[].obs;
  var districtList_Present = <ModelMasterEmpTable>[].obs;
  var cmb_present_district = ''.obs;

  var stateList_permanent = <ModelMasterEmpTable>[].obs;
  var districtList_permanent = <ModelMasterEmpTable>[].obs;
  var cmb_permanent_district = ''.obs;
  var isLoading = false.obs;
  var isSameAsPresentAddress = false.obs;

  var isError = false.obs;
  var errorMessage = "".obs;
  var companyName = "".obs;
  var uid = 0.obs;

  var isNewBorn = false.obs;

  var cmb_prefix = ''.obs;
  var cmb_nationality = ''.obs;
  var cmb_gender = ''.obs;
  var cmb_religion = ''.obs;
  var cmb_maritalstatus = ''.obs;
  var cmb_bloodgroup = ''.obs;
  var cmb_identitytype = ''.obs;
  var cmb_designation = ''.obs;
  var cmb_grade = ''.obs;
  var cmb_department = ''.obs;
  var cmb_section = ''.obs;
  var cmb_emptype = ''.obs;
  var cmb_jobstatus = ''.obs;
  var cmb_jobcategory = ''.obs;
  var cmb_present_country = ''.obs;
  var cmb_emergency_country = ''.obs;
  var cmb_emergency_state = ''.obs;

  var cmb_present_state = ''.obs;
  var cmb_permanent_state = ''.obs;
  var cmb_permanent_country = ''.obs;
  var cmb_pat_education = ''.obs;
  var cmb_pat_occupation = ''.obs;
  var cmb_pat_income_level = ''.obs;
  var cmb_corporate_company = ''.obs;
  var cmb_pat_type = ''.obs;
  //var user=ModelUser().obs;
  var user = ModelUser().obs;

  late BuildContext context;

  Future<void> ImageUpload() async {
    data_api2 api = data_api2();
    var img = await imageFileToBase64(imageFile.value.path);
    var x = await api.createLead([
      {"path": "img", "img": img}
    ], "save_image");
    print(x);
  }

  Future<void> setPermanentPresentSame(bool b) async {
    if (b) {
      cmb_permanent_country.value = cmb_present_country.value;
      //cmb_permanent_state.value = '';
      //cmb_permanent_district.value = '';
      // stateList_permanent.clear();
      stateList_permanent = stateList_Present;
      cmb_permanent_state.value = cmb_present_state.value;
      // districtList_permanent.clear();
      districtList_permanent = districtList_Present;
      //
      cmb_permanent_district.value = cmb_present_district.value;
      txt_permanent_address.text = txt_present_address.text;
    } else {
      cmb_permanent_country.value = '';
      txt_permanent_address.text = '';
      stateList_permanent.clear();
      districtList_permanent.clear();
    }
    //await getSate(v.toString(), 'permanent');
  }

  Future<void> setSateEvent(String v, String tp) async {
    if (tp == 'emergency') {
      cmb_emergency_state.value = v.toString();
      districtList_emergency.clear();
      cmb_emergency_district.value = '';
      getDistrict(cmb_emergency_country.value, v.toString(), "emergency");
    }
    if (tp == 'present') {
      cmb_present_state.value = v.toString();
      districtList_Present.clear();
      cmb_present_district.value = '';
      getDistrict(cmb_present_country.value, v.toString(), "present");
    }
    if (tp == 'permanent') {
      cmb_permanent_state.value = v.toString();
      districtList_permanent.clear();
      cmb_permanent_district.value = '';
      getDistrict(cmb_permanent_country.value, v.toString(), "permanent");
    }
  }

  Future<void> setCountryEvent(String v, String tp) async {
    if (tp == 'present') {
      cmb_present_country.value = v.toString();
      stateList_Present.clear();
      districtList_Present.clear();
      await getSate(v.toString(), 'present');

      cmb_present_state.value = '';
      cmb_present_district.value = '';
    }
    if (tp == 'emergency') {
      cmb_emergency_country.value = v.toString();
      stateList_emergency.clear();
      districtList_emergency.clear();
      await getSate(v.toString(), 'emergency');

      cmb_emergency_state.value = '';
      cmb_emergency_district.value = '';
    }

    if (tp == 'permanent') {
      cmb_permanent_country.value = v.toString();
      stateList_permanent.clear();
      districtList_permanent.clear();
      await getSate(v.toString(), 'permanent');

      cmb_permanent_state.value = '';
      cmb_permanent_district.value = '';
    }
  }

  Future<void> getDistrict(String countryID, String stateID, String tp) async {
    //  isLoading(true);
    data_api2 api = data_api2();
    if (user.value == null) {
      //isLoading(false);
      isError(true);
      errorMessage('You have to re login!');
    }
    try {
      var x = await api.createLead([
        {
          "tag": "17",
          "cid": user.value.cid.toString(),
          "country_id": countryID,
          "state_id": stateID
        }
      ]);
      print(x);
      var aaa = x.map((e) => ModelMasterEmpTable.fromJson(e)).toList();
      aaa.sort((a, b) => a.name!.compareTo(
            b.name!,
          ));
      if (tp == 'emergency') {
        districtList_emergency.addAll(aaa);
      } else if (tp == "present") {
        districtList_Present.addAll(aaa);
      } else if (tp == "permanent") {
        districtList_permanent.addAll(aaa);
      }
      // isLoading(false);
      isError(false);
    } catch (e) {
      // isLoading(false);
      isError(true);
      errorMessage(e.toString());
    }
  }

  Future<void> getSate(String countryID, String tp) async {
    //  isLoading(true);
    data_api2 api = data_api2();
    if (user.value == null) {
      //isLoading(false);
      isError(true);
      errorMessage('You have to re login!');
    }
    try {
      var x = await api.createLead([
        {"tag": "16", "cid": user.value.cid.toString(), "country_id": countryID}
      ]);
      print(x);
      var aaa = x.map((e) => ModelMasterEmpTable.fromJson(e)).toList();
      aaa.sort((a, b) => a.name!.compareTo(
            b.name!,
          ));
      if (tp == 'emergency') {
        stateList_emergency.addAll(aaa);
      } else if (tp == "present") {
        stateList_Present.addAll(aaa);
      } else if (tp == "permanent") {
        stateList_permanent.addAll(aaa);
      }
      // isLoading(false);
      isError(false);
    } catch (e) {
      // isLoading(false);
      isError(true);
      errorMessage(e.toString());
    }
  }

  @override
  void onInit() async {
    isLoading(true);
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

        x = await api.createLead([
          {"tag": "15", "cid": user.value.cid.toString()}
        ]);
        aaa = x.map((e) => ModelMasterEmpTable.fromJson(e)).toList();
        aaa.sort((a, b) => a.name!.compareTo(
              b.name!,
            ));
        plist.addAll(aaa);

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

  void SetUndo() {
    imageFile.value = File('');
    txt_mother_hcn.text = '';
    txt_name.text = '';
    txt_dob.text = '';
    txt_father_name.text = '';
    txt_mother_name.text = '';
    txt_spouse_name.text = '';
    txt_guardian_name.text = '';
    txt_identity_number.text = '';
    txt_cell_phone.text = '';
    txt_home_phone.text = '';
    txt_email.text = '';
    txt_emergency_number.text = '';
    txt_empid.text = '';
    txt_emergency_address.text = '';
    txt_permanent_address.text = '';
    stateList_emergency.clear();
    districtList_emergency.clear();
    cmb_emergency_district.value = '';
    stateList_Present.clear();
    districtList_Present.clear();
    cmb_present_district.value = '';
    stateList_permanent.clear();
    districtList_permanent.clear();
    cmb_permanent_district.value = '';
    isLoading.value = false;
    isSameAsPresentAddress.value = false;
    isError.value = false;
    errorMessage.value = '';

    uid.value = 0;

    isNewBorn.value = false;
    cmb_prefix.value = '';
    cmb_nationality.value = '';
    cmb_gender.value = '';
    cmb_religion.value = '';
    cmb_maritalstatus.value = '';
    cmb_bloodgroup.value = '';
    cmb_identitytype.value = '';
    cmb_designation.value = '';
    cmb_grade.value = '';
    cmb_department.value = '';
    cmb_section.value = '';
    cmb_emptype.value = '';
    cmb_jobstatus.value = '';
    cmb_jobcategory.value = '';
    cmb_present_country.value = '';
    cmb_emergency_country.value = '';
    cmb_emergency_state.value = '';
    cmb_present_state.value = '';
    cmb_permanent_state.value = '';
    cmb_permanent_country.value = '';
    cmb_pat_education.value = '';
    cmb_pat_occupation.value = '';
    cmb_pat_income_level.value = '';
    cmb_corporate_company.value = '';
    cmb_pat_type.value = '';
  }

  @override
  void onClose() {
    imageFile.close();
    txt_mother_hcn.dispose();
    txt_name.dispose();
    txt_dob.dispose();
    txt_father_name.dispose();
    txt_mother_name.dispose();
    txt_spouse_name.dispose();
    txt_guardian_name.dispose();
    txt_identity_number.dispose();
    txt_cell_phone.dispose();
    txt_home_phone.dispose();
    txt_email.dispose();
    txt_emergency_number.dispose();
    txt_empid.dispose();
    txt_emergency_address.dispose();
    txt_permanent_address.dispose();
    stateList_emergency.close();
    districtList_emergency.close();
    cmb_emergency_district.close();
    stateList_Present.close();
    districtList_Present.close();
    cmb_present_district.close();
    stateList_permanent.close();
    districtList_permanent.close();
    cmb_permanent_district.close();
    isLoading.close();
    isSameAsPresentAddress.close();
    isError.close();
    errorMessage.close();
    companyName.close();
    uid.close();
    isNewBorn.close();
    cmb_prefix.close();
    cmb_nationality.close();
    cmb_gender.close();
    cmb_religion.close();
    cmb_maritalstatus.close();
    cmb_bloodgroup.close();
    cmb_identitytype.close();
    cmb_designation.close();
    cmb_grade.close();
    cmb_department.close();
    cmb_section.close();
    cmb_emptype.close();
    cmb_jobstatus.close();
    cmb_jobcategory.close();
    cmb_present_country.close();
    cmb_emergency_country.close();
    cmb_emergency_state.close();
    cmb_present_state.close();
    cmb_permanent_state.close();
    cmb_permanent_country.close();
    cmb_pat_education.close();
    cmb_pat_occupation.close();
    cmb_pat_income_level.close();
    cmb_corporate_company.close();
    cmb_pat_type.close();
    super.onClose();
  }
}
