import 'package:get/get.dart';
import 'package:web_2/core/config/config.dart';
import 'package:web_2/core/config/mixin_attr_for_controller.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/modules/hms_setup/model/model_hrms_section_master.dart';

class ReportSectionSetupController extends GetxController with MixInController {
  var section_list_all = <ModelHmsSectionMaster>[].obs;
  var section_list_temp = <ModelHmsSectionMaster>[].obs;
  var selectedSectionID = ''.obs;

  var d_list_all = <_hmsdept>[].obs;
  var d_list_temp = <_hmsdept>[].obs;

  @override
  void onInit() async {
    api = data_api2();
    super.onInit();
    isLoading.value = true;
    try {
      user.value = await getUserInfo();

      var x = await api.createLead([
        {"tag": "48", "cid": user.value.cid}
      ]);
      print(x);
      section_list_all
          .addAll(x.map((e) => ModelHmsSectionMaster.fromJson(e)).toList());
      section_list_temp.addAll(section_list_all);

      Set<String> distinctCombos = Set<String>();

      for (var element in section_list_all) {
        String combo =
            "${element.hrDeptId}-${element.hrDeptName}-${element.hmsDeptId}-${element.hmsDeptName}";
        if (!distinctCombos.contains(combo)) {
          distinctCombos.add(combo);
          d_list_all.add(_hmsdept(
              hrId: element.hrDeptId,
              hrName: element.hrDeptName,
              hmsId: element.hmsDeptId,
              hmsName: element.hmsDeptName));
          //distinctList.add(element);
        }
      }
      d_list_temp.addAll(d_list_all);

//hms_dept_id: 32, hms_dept_name: Cardiology, hr_dept_id: 15,
//hr_dept_name: Surgery

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }
}

class _hmsdept {
  String? hrId;
  String? hrName;
  String? hmsId;
  String? hmsName;
  _hmsdept({this.hrId, this.hrName, this.hmsId, this.hmsName});
}
