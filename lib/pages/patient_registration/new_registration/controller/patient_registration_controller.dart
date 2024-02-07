import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/const_string.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/model/model_status.dart';

import '../../../../component/settings/config.dart';
import '../../../../data/data_api.dart';
import '../../../../model/model_user.dart';
import '../../../hrm/employee_master_page/model/model_emp_load_master_table.dart';

class PatRegController extends GetxController {
  late data_api2 api;
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
  
  var isSameAsPresentAddress = false.obs;
var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var companyName = "".obs;
  var uid = 0.obs;
  var hid = 0.obs;
  var staffID = ''.obs;

  var isNewBorn = false.obs;
  var isSearch = false.obs;
  var isImageUpdate = false.obs;

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

  // ignore: non_constant_identifier_names






void LoadEmployee(String v) {
 

}






  Future<void> Save() async {
    String img_path = '';

    if (validation()) {
      return;
    }
    
    if (isImageUpdate.value) {
      if (imageFile.value.path != '') {
        var img = await imageFileToBase64(imageFile.value.path);
        var x = await api.createLead([
          {"path": "img", "img": img}
        ], "save_image");
        ModelStatus s = x.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status.toString() == "1") {
          img_path = s.msg!;
        }
      }
    }
    String a = '''$CustomXmlFormat<r><a><pxid>${cmb_prefix.value}</pxid>
        <mhcn>${txt_mother_hcn.text}</mhcn><dob>${txt_dob.text}</dob><conid>${cmb_nationality.value}</conid><sex>${cmb_gender.value}</sex>
        <reli>${cmb_religion.value}</reli><mat>${cmb_maritalstatus.value}</mat><bg>${cmb_bloodgroup.value}</bg><idt>${cmb_identitytype.value}</idt>
        <idno>${txt_identity_number.text}</idno><mob>${txt_cell_phone.text}</mob><hmob>${txt_home_phone.text}</hmob>
        <email>${txt_email.text}</email><eno>${txt_emergency_number.text}</eno><ptype>${cmb_pat_type.value}</ptype>
        <corpid>${cmb_corporate_company.value}</corpid><staff>${staffID.value}</staff><eduid>${cmb_pat_education.value}</eduid>
        <occid>${cmb_pat_occupation.value}</occid><incid>${cmb_pat_income_level.value}</incid>
        <ecid>${cmb_emergency_country.value}</ecid><esid>${cmb_emergency_state.value}</esid><edid>${cmb_emergency_district.value}</edid>
        <pscid>${cmb_present_country.value}</pscid><pssid>${cmb_present_state.value}</pssid><psdid>${cmb_present_district.value}</psdid>
        <prcid>${cmb_permanent_country.value}</prcid><prsid>${cmb_permanent_state.value}</prsid><prdid>${cmb_permanent_district.value}</prdid>
        </a></r>''';
    var x = await api.createLead([
      {
        "tag": "19",
        "hid": hid.value.toString(),
        "eid": user.value.uid,
        "cid": user.value.cid,
        "name": txt_name.text,
        "fname": txt_father_name.text,
        "mname": txt_mother_name.text,
        "sname": txt_spouse_name.text,
        "gname": txt_guardian_name.text,
        "emr_add": txt_emergency_address.text,
        "pre_add": txt_present_address.text,
        "per_add": txt_permanent_address.text,
        "img_path": img_path,
        "xml": a
      }
    ]);

    ModelStatus s = x.map((e) => ModelStatus.fromJson(e)).first;
    if (s.status.toString() != "1") {
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context,
          DialogType.error,
          "Warning!",
          hid.value == 0
              ? "Error for new registration"
              : "Error to update patient information",
          () {});
      return;
    }
    isImageUpdate.value = false;
    isSearch.value = true;
    hid.value = int.parse(s.id.toString());
    txt_hcn.text = s.msg!;

    //  print(x);

    //print(a);
  }

  bool validation() {
    if (user.value == null) {
      isError(true);
      errorMessage('You have to re login!');
      return true;
    }
    if (isNewBorn.value) {
      if (txt_mother_hcn.text == '') {
        customAwesamDialodOk(context, DialogType.warning, "Warning!",
            "Please enter valid mother HCN", () {});
        return true;
      }
    }
    if (cmb_prefix.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select prefix", () {});
      return true;
    }

    if (txt_name.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select prefix", () {});
      return true;
    }
    if (txt_dob.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Date of birth required!", () {});
      return true;
    }
    if (cmb_nationality.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select country/nationality", () {});
      return true;
    }

    if (txt_father_name.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter father's name", () {});
      return true;
    }
    if (cmb_gender.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select gender", () {});
      return true;
    }
    if (cmb_religion.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select religion", () {});
      return true;
    }
    if (cmb_maritalstatus.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select marital status", () {});
      return true;
    }
    if (cmb_identitytype.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select identity type", () {});
      return true;
    }
    if (cmb_nationality.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select identity number", () {});
      return true;
    }
    if (txt_cell_phone.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Cell phone/ mobile number required", () {});
      return true;
    }
    if (txt_emergency_number.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Emergency contact number required!", () {});
      return true;
    }
    if (cmb_pat_type.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select patient type", () {});
      return true;
    }
    if (cmb_corporate_company.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select corporate type", () {});
      return true;
    }
    if (cmb_emergency_country.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Country required for emergency address", () {});
      return true;
    }
    if (cmb_emergency_state.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "State required for emergency address", () {});
      return true;
    }
    if (cmb_emergency_district.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "District required for emergency address", () {});
      return true;
    }
    if (cmb_pat_type.value == '2') {
      if (txt_empid.text == '') {
        customAwesamDialodOk(context, DialogType.warning, "Warning!",
            "Please enter valid staff employee id", () {});
        return true;
      }
    }

    return false;
  }

  Future<void> ImageUpload() async {
    
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
    api= data_api2();
    isLoading(true);
   
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
    isImageUpdate.value = false;
    isSearch.value = false;
    imageFile.value = File('');
    txt_hcn.text = '';
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
