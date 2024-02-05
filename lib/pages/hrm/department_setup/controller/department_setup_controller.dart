import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/pages/hrm/department_setup/model/model-cat_dep_section.dart';
import 'package:web_2/pages/hrm/department_setup/model/model_department.dart';
import 'package:web_2/pages/hrm/department_setup/model/model_department_category.dart';
import 'package:web_2/pages/hrm/department_setup/model/model_section_unit.dart';

class DepartmentSetupController extends GetxController {
  late data_api2 api;
  var user = ModelUser().obs;
  var elist = <ModuleCatDeptSection>[].obs;
  final TextEditingController txt_category=TextEditingController();
   final TextEditingController txt_department=TextEditingController();
    final TextEditingController txt_section=TextEditingController();

  var category_list = <ModelDepartmentCategory>[].obs;
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

  @override
  void onInit() async {
    api = data_api2();
    isLoading.value = true;
    try {
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
      department_list
          .addAll(x.map((e) => ModelDepartment.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "24", "cid": user.value.cid}
      ]);

      section_list
          .addAll(x.map((e) => ModelSectionUnit.fromJson(e)).toList());

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'You have to re-login again';
    }
    super.onInit();
  }
}
