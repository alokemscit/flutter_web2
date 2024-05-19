import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
 
import 'package:web_2/modules/hrm/employee_master_page/model/model_emp_load_master_table.dart';
import 'package:web_2/modules/opd/doctor_setup/model/model_doctor_setup.dart';

class DoctorOPDsetupController extends GetxController {
  late data_api2 api;
  var user = ModelUser().obs;
  var elist = <ModelMasterEmpTable>[].obs;
  var dList = <ModuleDoctorSetup>[].obs;
   
   
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var companyName = "".obs;
  var isSearch = false.obs;

  var cmb_job_catID = ''.obs;
  var cmb_deptID = ''.obs;
  var cmb_section_ID = ''.obs;
  var cmb_doc_ID = ''.obs;

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
        {"tag": "20", "cid": user.value.cid}
      ]);
      var dl = x.map((e) => ModuleDoctorSetup.fromJson(e)).toList();
      dList.addAll(dl);

      x = await api.createLead([
        {"tag": "13", "cid": user.value.cid.toString()}
      ]);
      var aaa = x.map((e) => ModelMasterEmpTable.fromJson(e)).toList();
      aaa.sort((a, b) => a.name!.compareTo(
            b.name!,
          ));
      elist.addAll(aaa);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'You have to re-login again';
    }
    super.onInit();
  }
}
