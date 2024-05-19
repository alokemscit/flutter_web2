import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web_2/component/widget/custom_awesome_dialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';

import 'package:web_2/core/config/config.dart';

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
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;

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
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (cmb_catID2.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select deprtment category!'
        ..show();

      return;
    }
    if (cmb_DeptID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Warning!", "Please deprtment!'
        ..show();

      return;
    }
    if (txt_section.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please enter valid section name!'
        ..show();

      return;
    }
    try {
      // isSectionLoading.value = true;

      // customBusyDialog(context);
      loader.show();

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
      // Navigator.pop(context);
      loader.close();
      var m = x.map((e) => ModelStatus.fromJson(e)).first;
      //isSectionLoading.value = false;
      if (m == null) {
        // ignore: use_build_context_synchronously
        dialog
          ..dialogType = DialogType.error
          ..message = 'Faullure to save data!'
          ..show();

        return;
      }
      if (m.status != '1') {
        dialog
          ..dialogType = DialogType.error
          ..message = m.msg!
          ..show();
        // ignore: use_build_context_synchronously

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
      dialog
        ..dialogType = DialogType.success
        ..message = m.msg!
        ..show();

      //cmb_catID2.value = '';
      //cmb_DeptID.value = '';
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // isSectionLoading.value = false;
      // ignore: use_build_context_synchronously
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();

      return;
    }
  }

  void saveUpdateDeprtment() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (cmb_catID.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select deprtment category!'
        ..show();

      return;
    }
    if (txt_department.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please eneter valid department name!'
        ..show();

      return;
    }
    try {
      loader.show();
      // customBusyDialog(context);
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
      // Navigator.pop(context);
      loader.close();
      var m = x.map((e) => ModelStatus.fromJson(e)).first;
      //isDepartmentLoading.value = false;
      if (m.status == null) {
        // ignore: use_build_context_synchronously
        dialog
          ..dialogType = DialogType.error
          ..message = 'Faullure to save data!'
          ..show();

        return;
      }

      if (m.status != '1') {
        // ignore: use_build_context_synchronously
        dialog
          ..dialogType = DialogType.error
          ..message = m.msg!
          ..show();

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

      dialog
        ..dialogType = DialogType.success
        ..message = m.msg!
        ..show();
      // ignore: use_build_context
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //isDepartmentLoading.value = false;
      // ignore: use_build_context_synchronously

      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();

      return;
    }
  }

  Future saveUpdateCategory() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);

    if (txt_category.text == '') {
      dialog
        ..dialogType = DialogType.error
        ..message = 'Please eneter valid category name!'
        ..show();

      return;
    }
    if (txt_category.text == '') {
      return;
    }
    //customBusyDialog(context);
    //customBusyDialog(context)
    // customBusyDialog(context);
    loader.show();
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
      loader.close();
      if (m.status == null) {
        // ignore: use_build_context_synchronously

        dialog
          ..dialogType = DialogType.error
          ..message = 'Faullure to save data!'
          ..show();
        return;
      }

      if (m.status != '1') {
        // ignore: use_build_context_synchronously
        
            
             dialog
        ..dialogType = DialogType.error
        ..message = m.msg!
        ..show();
        return;
      }

      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      // loader.close();

      if (txt_category.text == '') {
        return;
      }

      // ignore: use_build_context_synchronously
      


             dialog
        ..dialogType = DialogType.success
        ..message = m.msg!
        ..show();

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
      


             dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();

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
      if (user.value.uid == null) {
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
