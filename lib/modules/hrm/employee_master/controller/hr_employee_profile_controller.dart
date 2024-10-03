// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:web_2/core/config/const.dart';

import '../../department_setup/model/model_department.dart';
import '../../department_setup/model/model_section_unit.dart';
import '../../setup_attributes/model/hr_model_designation_master.dart';
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
  var cmb_corp_designation = ''.obs;
  var cmb_designation = ''.obs;
  var cmb_grade = ''.obs;
  var cmb_department = ''.obs;
  var cmb_section = ''.obs;
  var cmb_emptype = ''.obs;
  var cmb_medical_status = ''.obs;

  var cmb_jobstatus = ''.obs;
  var cmb_jobcategory = ''.obs;
  var cmb_department_category = ''.obs;
  var cmb_probation_duration = ''.obs;
  var list_tab = <ModelCommonMaster>[].obs;
  var list_Mlist = <ModelMasterEmpTable>[].obs;
  var list_department = <ModelDepartment>[].obs;
  var list_unit = <ModelSectionUnit>[].obs;
  var list_designation_master = <ModelHrDesignationMaster>[].obs;

  final TextEditingController txt_first_name = TextEditingController();
  final TextEditingController txt_middle_name = TextEditingController();
  final TextEditingController txt_last_name = TextEditingController();
  final TextEditingController txt_identity_no = TextEditingController();
  final TextEditingController txt_dob = TextEditingController();
  final TextEditingController txt_doj = TextEditingController();
  final TextEditingController txt_contact_end_date = TextEditingController();
  final TextEditingController txt_probation_duration = TextEditingController();
  var list_duration = <ModelCommonMaster>[].obs;
  var list_qualification = <_qualification>[].obs;
  var lsit_employment = <_employment>[].obs;

  var mAddress = _address().obs;
  var mSeparation = _separation().obs;

  var isContactEnd = false.obs;
  var isProbation = true.obs;

  var list_tool = <CustomTool>[].obs;

 

  List<ModelMasterEmpTable> getList(String tp) {
    return list_Mlist.where((e) => e.tp == tp).toList();
  }

  @override
  void onInit() async {
    mAddress.value = _address().getAddressNew();
    mSeparation.value = _separation(
      exit_interview_date: TextEditingController(),
      exit_note: TextEditingController(),
      is_salary_stop: false,
      reason_of_separation: TextEditingController(),
      reg_submit_date: TextEditingController(),
      separation_date: TextEditingController(),
      last_work_date: TextEditingController(),
    );
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

      await mLoadModel(
          api,
          [
            {"tag": "79", "cid": user.value.cid}
          ],
          list_designation_master,
          (x) => ModelHrDesignationMaster.fromJson(x));

      list_duration.addAll(duration.map((x) => ModelCommonMaster.fromJson(x)));
      list_tool.addAll( Custom_Tool_List());

      

      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }
}
 
class _separation {
  TextEditingController? reg_submit_date;
  TextEditingController? separation_date;
  TextEditingController? reason_of_separation;
  TextEditingController? last_work_date;

  TextEditingController? exit_interview_date;
  TextEditingController? exit_note;
  bool? is_salary_stop;
  _separation({
    this.reg_submit_date,
    this.separation_date,
    this.reason_of_separation,
    this.exit_interview_date,
    this.exit_note,
    this.is_salary_stop,
    this.last_work_date,
  });
}

class _employment {
  TextEditingController? startdate;
  TextEditingController? enddate;
  TextEditingController? organiztion;
  TextEditingController? department;
  TextEditingController? designation;
}

class _qualification {
  TextEditingController? Degree;
  TextEditingController? inistitue;
  TextEditingController? subject;
  TextEditingController? passing_year;
  TextEditingController? mark;
  bool? isVerified;
}

class _address {
  TextEditingController? address1_pre;
  TextEditingController? address2_pre;
  TextEditingController? address1_per;
  TextEditingController? address2_per;
  TextEditingController? mobile_per;
  TextEditingController? mobile_pre;
  TextEditingController? email_per;
  TextEditingController? email_pre;
  String? country_pre;
  String? country_per;
  TextEditingController? city_pre;
  TextEditingController? city_per;
  _address({
    this.address1_pre,
    this.address2_pre,
    this.address1_per,
    this.address2_per,
    this.mobile_per,
    this.mobile_pre,
    this.email_per,
    this.email_pre,
    this.country_pre,
    this.country_per,
    this.city_pre,
    this.city_per,
  });

  _address getAddressNew() {
    return _address(
        address1_per: TextEditingController(),
        address1_pre: TextEditingController(),
        address2_per: TextEditingController(),
        address2_pre: TextEditingController(),
        city_per: TextEditingController(),
        city_pre: TextEditingController(),
        country_per: '',
        country_pre: '',
        email_per: TextEditingController(),
        email_pre: TextEditingController(),
        mobile_per: TextEditingController(),
        mobile_pre: TextEditingController());
  }
}

var duration = [
  {"id": "d", "name": "Day(s)"},
  {"id": "m", "name": "Month"},
  {"id": "y", "name": "Year"}
];
var list = [
  {"id": "1", "name": "Address"},
  {"id": "2", "name": "Qualification"},
  {"id": "3", "name": "Emp. History"},
  {"id": "4", "name": "Leave"},
  {"id": "5", "name": "Separation"},
  {"id": "6", "name": "Dependant"},
  {"id": "7", "name": "Training"},
  {"id": "8", "name": "Misconduct"},
  {"id": "9", "name": "Additional"}
];
