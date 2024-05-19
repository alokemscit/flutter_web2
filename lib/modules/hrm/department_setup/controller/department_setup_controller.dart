import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_status.dart';
import 'package:web_2/model/model_user.dart';

import 'package:web_2/modules/hrm/department_setup/model/model_department.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_department_category.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_section_unit.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';

class DepartmentSetupController extends GetxController {
  late data_api2 api;
  var user = ModelUser().obs;

  //var elist = <ModuleCatDeptSection>[].obs;
  final TextEditingController txt_category = TextEditingController();
  final TextEditingController txt_department = TextEditingController();
  final TextEditingController txt_section = TextEditingController();

  var category_list = <ModelDepartmentCategory>[].obs;
  var department_list_all = <ModelDepartment>[].obs;
  var department_list = <ModelDepartment>[].obs;
  var section_list = <ModelSectionUnit>[].obs;
  var cmb_catID = ''.obs;
  var cmb_catID2 = ''.obs;
  var cmb_DeptID = ''.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var companyName = "".obs;
  var isSearch = false.obs;
  var statusList = <ModelStatusMaster>[].obs;
  late BuildContext context;

  var cmb_job_catID = ''.obs;
  var cmb_deptID = ''.obs;
  var cmb_section_ID = ''.obs;
  var cmb_doc_ID = ''.obs;

  var cmb_category_statusID = '1'.obs;
  var cmb_department_statusID = '1'.obs;
  var cmb_section_statusID = '1'.obs;

  var editCategoryID = ''.obs;
  var editDepartmentID = ''.obs;
  var editSectionID = ''.obs;

  var isCategoryLoading = false.obs;
  var isDepartmentLoading = false.obs;
  var isSectionLoading = false.obs;

  void saveUpdateSection() async {
    if (cmb_catID2.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select deprtment category!", () {});
      return;
    }
    if (cmb_DeptID.value == '') {
      customAwesamDialodOk(
          context, DialogType.warning, "Warning!", "Please deprtment!", () {});
      return;
    }
    if (txt_section.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please enter valid section name!", () {});
      return;
    }
    try {
      // isSectionLoading.value = true;
      customBusyDialog(context);

      var x = await api.createLead([
        {
          "tag": "27",
          "cid": user.value.cid,
          "id": editSectionID.value,
          "name": txt_section.text,
          "did": cmb_DeptID.value,
          "status": cmb_section_statusID.value
        }
      ]);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      var m = x.map((e) => ModelStatus.fromJson(e)).first;
      //isSectionLoading.value = false;
      if (m == null) {
        // ignore: use_build_context_synchronously
        customAwesamDialodOk(context, DialogType.error, "Error!",
            "Faullure to save data!", () {});
        return;
      }
      if (m.status != '1') {
        // ignore: use_build_context_synchronously
        customAwesamDialodOk(
            context, DialogType.error, "Error!", m.msg!, () {});
        return;
      }
      section_list.removeWhere((element) => element.id == editSectionID.value);
      section_list.add(ModelSectionUnit(
          catId: cmb_catID2.value,
          catname:
              category_list.where((p0) => p0.id == cmb_catID2.value).first.name,
          depId: cmb_DeptID.value,
          depName: department_list_all
              .where((p0) => p0.id == cmb_DeptID.value)
              .first
              .name,
          id: m.id,
          name: txt_section.text,
          status: cmb_section_statusID.value));
      cmb_section_statusID.value = '1';
      txt_section.text = '';
      editSectionID.value = '';
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.success, "Success!", m.msg!, () {});
      //cmb_catID2.value = '';
      //cmb_DeptID.value = '';
     
    } catch (e) {
       // ignore: use_build_context_synchronously
       Navigator.pop(context);
     // isSectionLoading.value = false;
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
      return;
    }
  }

  void saveUpdateDeprtment() async {
    if (cmb_catID.value == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select deprtment category!", () {});
      return;
    }
    if (txt_department.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please eneter valid department name!", () {});
      return;
    }
    try {
      customBusyDialog(context);
      // isDepartmentLoading.value = true;
      var x = await api.createLead([
        {
          "tag": "26",
          "cid": user.value.cid,
          "id": editDepartmentID.value,
          "name": txt_department.text,
          "catid": cmb_catID.value,
          "status": cmb_department_statusID.value
        }
      ]);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      var m = x.map((e) => ModelStatus.fromJson(e)).first;
      //isDepartmentLoading.value = false;
      if (m == null) {
        // ignore: use_build_context_synchronously
        customAwesamDialodOk(context, DialogType.error, "Error!",
            "Faullure to save data!", () {});
        return;
      }

      if (m.status != '1') {
        // ignore: use_build_context_synchronously
        customAwesamDialodOk(
            context, DialogType.error, "Error!", m.msg!, () {});
        return;
      }

      department_list_all.removeWhere(
        (element) => element.id == editDepartmentID.value,
      );
      department_list_all.add(ModelDepartment(
          id: m.id,
          name: txt_department.text,
          status: cmb_department_statusID.value,
          catId: cmb_catID.value,
          catname: category_list
              .where((p0) => p0.id == cmb_catID.value)
              .first
              .name!));
      // ignore: use_build_context_synchronously
      txt_department.text = '';
      // cmb_catID.value = '';
      cmb_department_statusID.value = "1";
      editDepartmentID.value = '';
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.success, "Success!", m.msg!, () {});

      // ignore: use_build_context
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //isDepartmentLoading.value = false;
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
      return;
    }
  }

  Future saveUpdateCategory() async {
    if (txt_category.text == '') {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please eneter valid category name!", () {});
      return;
    }
    if (txt_category.text == '') {
      return;
    }
    //customBusyDialog(context);
    //customBusyDialog(context)
    customBusyDialog(context);
    //return;
    // Future.delayed(Duration(seconds: 10));
    try {
      // isCategoryLoading.value = true;
      var x = await api.createLead([
        {
          "tag": "25",
          "cid": user.value.cid,
          "id": editCategoryID.value,
          "name": txt_category.text,
          "status": cmb_category_statusID.value
        }
      ]);
      var m = x.map((e) => ModelStatus.fromJson(e)).first;
      // isCategoryLoading.value = false;
      if (m == null) {
        // ignore: use_build_context_synchronously
        customAwesamDialodOk(context, DialogType.error, "Error!",
            "Faullure to save data!", () {});
        return;
      }

      if (m.status != '1') {
        // ignore: use_build_context_synchronously
        customAwesamDialodOk(
            context, DialogType.error, "Error!", m.msg!, () {});
        return;
      }

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      if (txt_category.text == '') {
        return;
      }

      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.success, "Success!", m.msg!, () {});
      category_list
          .removeWhere((element) => element.id == editCategoryID.value);
      category_list.add(ModelDepartmentCategory(
          id: m.id!,
          name: txt_category.text,
          status: cmb_category_statusID.value));
      txt_category.text = '';
      editCategoryID.value = '';
      // ignore: use_build_context_synchronously

      cmb_category_statusID.value = "1";
    } catch (e) {
      isCategoryLoading.value = false;
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
      return;
    }
  }

  void setDepartmet(String catid) async {
    try {
      // var  x = await api.createLead([
      //     {"tag": "23", "cid": user.value.cid}
      //   ]);
      department_list.addAll(department_list_all
          .where((element) => element.catId.toString() == catid)
          .toList());
    } catch (e) {}
  }

  @override
  void onInit() async {
    api = data_api2();
    isLoading.value = true;
    try {
      cmb_category_statusID.value = '1';
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      if (user.value == null) {
        isLoading.value = false;
        isError.value = true;
        errorMessage.value = 'You have to re-login again';
        return;
      }
      var x = await api.createLead([
        {"tag": "22", "cid": user.value.cid}
      ]);
      // var dl = x.map((e) => ModelDepartmentCategory.fromJson(e)).toList();
      // dl.sort((a, b) => a.name!.compareTo(
      //       b.name!,
      //     ));

      category_list
          .addAll(x.map((e) => ModelDepartmentCategory.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "23", "cid": user.value.cid}
      ]);
      department_list_all
          .addAll(x.map((e) => ModelDepartment.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "24", "cid": user.value.cid}
      ]);

      section_list.addAll(x.map((e) => ModelSectionUnit.fromJson(e)).toList());

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'You have to re-login again';
    }
    super.onInit();
  }
}
