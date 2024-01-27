// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/const_string.dart';

import 'package:web_2/component/settings/functions.dart';

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
  var uid = 0.obs;
  //var user=ModelUser().obs;
  var user = ModelUser().obs;

  late BuildContext context;

  final TextEditingController txt_emp_id = TextEditingController();
  final FocusNode f_emp_id = FocusNode();
  final TextEditingController txt_emp_name = TextEditingController();
  final TextEditingController txt_emp_dob = TextEditingController();
  var cmb_prefix = ''.obs;
  var cmb_nationality = ''.obs;

  final TextEditingController txt_emp_father = TextEditingController();
  final FocusNode f_emp_father = FocusNode();
  final TextEditingController txt_emp_mother = TextEditingController();
  final FocusNode f_emp_mother = FocusNode();
  final TextEditingController txt_emp_spouse = TextEditingController();
  final TextEditingController txt_emp_note = TextEditingController();
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
  var cmb_jobcategory = ''.obs;
  final TextEditingController txt_emp_doj = TextEditingController();

  Undo() {
    txt_emp_id.text = '';
    txt_emp_name.text = '';
    txt_emp_dob.text = '';
    cmb_prefix.value = '';
    cmb_gender.value = '';
    cmb_religion.value = '';
    cmb_department.value = '';
    cmb_section.value = '';
    cmb_emptype.value = '';
    cmb_nationality.value = '';
    txt_emp_father.text = '';
    txt_emp_mother.text = '';
    txt_emp_spouse.text = '';
    txt_emp_note.text = '';
    cmb_maritalstatus.value = '';
    cmb_bloodgroup.value = '';
    cmb_identitytype.value = '';
    txt_emp_identityname.text = '';
    cmb_designation = ''.obs;
    cmb_grade.value = '';
    cmb_department.value = '';
    cmb_section.value = '';
    cmb_emptype.value = '';
    cmb_jobstatus.value = '';
    cmb_jobcategory.value = '';
    txt_emp_doj.text = '';
    uid.value = 0;
  }

  EditEmployee() {
    if (!isDisableID.value) {
      isDisableID.value = true;
      uid.value = 0;
      txt_emp_id.text = '';
      return;
    }
//isDisableID.value = false;
    CustomCupertinoAlertWithYesNo(
      context,
      const Text("Alert"),
      const Text("Are you sure to edit employee"),
      () {
        //  print("No");
        //Get.back();
      },
      () {
        txt_emp_id.text = '';
        Undo();
        isDisableID.value = false;
        //  FocusScope.of(context).requestFocus(f_emp_id);
        // Navigator.pop(context);

        //print("Yes");
      },
    );
  }

  SaveData() async {
    if (cmb_prefix.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select prefix", () {});
      return;
    }

    if (txt_emp_name.text.isEmpty) {
      customAwesamDialodOk(
          context, DialogType.warning, "Warning!", "Please enter name", () {});
      return;
    }

    if (txt_emp_dob.text.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter date of birth", () {});
      return;
    }
    if (cmb_nationality.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select nationality", () {});
      return;
    }
    if (txt_emp_father.text.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter father's name", () {});
      return;
    }
    if (txt_emp_mother.text.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter mother's name", () {});
      return;
    }
    if (cmb_gender.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select gender", () {});
      return;
    }
    if (cmb_religion.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select religion", () {});
      return;
    }
    if (cmb_maritalstatus.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select marital status", () {});
      return;
    }
    if (cmb_bloodgroup.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select blood group", () {});
      return;
    }
    if (cmb_identitytype.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select identity type", () {});
      return;
    }
    if (txt_emp_identityname.text.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter identity number", () {});
      return;
    }
    if (cmb_designation.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select designation", () {});
      return;
    }
    if (cmb_grade.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select grade", () {});
      return;
    }
    if (cmb_department.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select department", () {});
      return;
    }
    if (cmb_section.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select section", () {});
      return;
    }
    if (cmb_emptype.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select type of employeement", () {});
      return;
    }
    if (cmb_jobstatus.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select job status", () {});
      return;
    }
    if (txt_emp_doj.text.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter date of join", () {});
      return;
    }
    if (cmb_jobcategory.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please selct job category", () {});
      return;
    }

    String s =
        '''$CustomXmlFormat<r><a><id>${txt_emp_id.text}</id><uid>${uid.value}</uid><prefix>${cmb_prefix.value}</prefix><name>${txt_emp_name.text}</name>
    <dob>${txt_emp_dob.text}</dob><nationality>${cmb_nationality.value}</nationality>
    <fname>${txt_emp_father.text}</fname><mname>${txt_emp_mother.text}</mname>
    <sname>${txt_emp_spouse.text}</sname><gender>${cmb_gender.value}</gender><religion>${cmb_religion.value}</religion>
    <mstatus>${cmb_maritalstatus.value}</mstatus><bg>${cmb_bloodgroup.value}</bg><itype>${cmb_identitytype.value}</itype>
    <ino>${txt_emp_identityname.text}</ino><designation>${cmb_designation.value}</designation><grade>${cmb_grade.value}</grade>
    <dept>${cmb_department.value}</dept><section>${cmb_section.value}</section><etype>${cmb_emptype.value} </etype>
    <jstatus>${cmb_jobstatus.value}</jstatus><doj>${txt_emp_doj.text}</doj><jcat>${cmb_jobcategory.value}</jcat>
    <note>${txt_emp_note.text}</note>
    </a></r>''';
    //print(s);

    data_api2 api = data_api2();
    try {
      // print(user.cid);

// @cid int,
// @entry_by nvarchar(10),
// @name nvarchar(150),
// @fname nvarchar(150),
// @mname nvarchar(150),
// @sname nvarchar(150),
// @ino nvarchar(25),
// @note nvarchar(250),
// @xml text

      // CustomModalBusyLoader();
      isLoading.value = true;

      var x = await api.createLead([
        {
          "tag": "14",
          "cid": user.value.cid.toString(),
          "entry_by": user.value.uid.toString(),
          "name": txt_emp_name.text,
          "fname": txt_emp_father.text,
          "mname": txt_emp_mother.text,
          "sname": txt_emp_spouse.text,
          "ino": txt_emp_identityname.text,
          "note": txt_emp_note.text,
          "xml": s
        }
      ]);
      // Get.back();
      //print(x);
      // ignore: use_build_context_synchronously
      isLoading.value = false;
      bool b = GetStatusMessage(context, x);
      if (b) {
        Undo();
      }
    } catch (e) {
      isLoading.value = true;
      //Get.back();
      //errorMessage(e.toString());
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
    }
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

  @override
  void onClose() {
    f_emp_id.dispose();
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
    cmb_jobcategory.close();
    txt_emp_note.dispose();
    elist.close();

    super.dispose();
    print("super call dispose");
    super.onClose();
  }
}
