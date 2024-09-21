// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:web_2/core/config/const.dart';

import '../../department_setup/model/model_department.dart';
import '../../department_setup/model/model_section_unit.dart';
import '../model/model_emp_load_master_table.dart';

class HrEmployeeProfileController extends GetxController with MixInController {
   final Rx<File> imageFile = File('').obs;
  var checkedID = "1".obs;
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
  var cmb_medical_status = ''.obs;

  var cmb_jobstatus = ''.obs;
  var cmb_jobcategory = ''.obs;
  var cmb_department_category = ''.obs;
  var list_tab = <ModelCommonMaster>[].obs;
  var list_Mlist = <ModelMasterEmpTable>[].obs;
  var list_department = <ModelDepartment>[].obs;
  var list_unit = <ModelSectionUnit>[].obs;

  List<ModelMasterEmpTable> getList(String tp) {
    return list_Mlist.where((e) => e.tp == tp).toList();
  }

  // void setDepartmentType(String dic) async {
  //   cmb_department.value = '';
  //   cmb_department_category.value = dic;

  //   loader = CustomBusyLoader(context: context);
  //   dialog = CustomAwesomeDialog(context: context);
  //   try {
  //     loader.show();
  //     List<ModelDepartment> list = [];
  //     await mLoadModel(
  //         api,
  //         [
  //           {
  //             "tag": "23",
  //             "cid": user.value.cid,
  //           }
  //         ],
  //         list,
  //         (e) => ModelDepartment.fromJson(e));
  //     list_department
  //       ..clear()
  //       ..addAll(list.where((e) => e.catId == dic && e.status == '1'));
  //     //list_department.refresh();
  //     // print(list_department.length);
  //     loader.close();
  //   } catch (e) {
  //     loader.close();
  //     dialog
  //       ..dialogType = DialogType.error
  //       ..message = e.toString()
  //       ..show();
  //   }
  // }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    list_tab.addAll(list.map((item) => ModelCommonMaster(
          id: item["id"],
          name: item["name"],
          // Set default value for isSelected
        )));
    try {
      List<ModelMasterEmpTable> aaa = [];
      await mLoadModel(
          api,
          [
            {"tag": "13", "cid": user.value.cid.toString()}
          ],
          aaa,
          (e) => ModelMasterEmpTable.fromJson(e));
      aaa.sort((a, b) => a.name!.compareTo(
            b.name!,
          ));
      list_Mlist.addAll(aaa.where((e) => e.status == '1'));
      // print(list_Mlist.length);

      await mLoadModel(
          api,
          [
            {
              "tag": "23",
              "cid": user.value.cid,
            }
          ],
          list_department,
          (e) => ModelDepartment.fromJson(e));

      await mLoadModel(
          api,
          [
            {
              "tag": "24",
              "cid": user.value.cid,
            }
          ],
          list_unit,
          (e) => ModelSectionUnit.fromJson(e));

      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }
}

// class _tab {
//   String? id;
//   String? name;
//   bool? isSelected;
//   _tab({
//     this.id,
//     this.name,
//     this.isSelected,
//   });
// }

var list = [
  {"id": "1", "name": "Address"},
  {"id": "2", "name": "Qualification"},
  {"id": "3", "name": "Emp. History"},
  {"id": "4", "name": "Leave"},
  {"id": "5", "name": "Separation"},
  {"id": "6", "name": "Dependant"},
  {"id": "7", "name": "Training"},
  {"id": "8", "name": "Misconduct"},
  {"id": "9", "name": "Leave"},
  {"id": "10", "name": "Additional"}
];
