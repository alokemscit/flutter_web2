import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  var imgPath = ''.obs;
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
   await uploadImage(imageFile.value);
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
    } else {
      cmb_permanent_country.value = '';
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
}
