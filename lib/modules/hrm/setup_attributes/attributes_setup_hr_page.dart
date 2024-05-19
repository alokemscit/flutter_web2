import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/hrm/setup_attributes/controller/attribute_setup_hr_controller.dart';
import 'package:web_2/modules/hrm/setup_attributes/widget/custom_widget_hr.dart';

class AttributesSetupHRM extends StatelessWidget {
  const AttributesSetupHRM({super.key});
  void disposeController() {
    try {
      Get.delete<AttributeSetupHrController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    AttributeSetupHrController controller =
        Get.put(AttributeSetupHrController());
    controller.context = context;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (controller.isError.value) {
          return Text(
            controller.errorMessage.value.toString(),
            style: const TextStyle(color: Colors.red),
          );
        }
        return Responsive(
          mobile: _mobile(controller), // //_tablet(controller),
          tablet: _tablet(controller), //  _tablet(controller),
          desktop: _desktop(controller),
        );
      }),
    );
  }
}

_mobile(AttributeSetupHrController controller) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            _designationPart(controller),
            height(),
            _gradePart(controller),
            height(),
            _empTypePart(controller),
            height(),
            _genderPart(controller, 300),
            height(),
            _maritialPart(controller),
            height(),
            _bloodPart(controller),
            height(),
            _religionPart(controller),
            height(),
            _identityPart(controller),
            height(),
            _jobStatusPart(controller),
             height(),
            _prefixPart(controller),
          ],
        ),
      ),
    );

_tablet(AttributeSetupHrController controller) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _designationPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _gradePart(controller),
                ),
              ],
            ),
            height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _empTypePart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _genderPart(controller, 300),
                ),
              ],
            ),
            height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _maritialPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _bloodPart(controller),
                ),
              ],
            ),
            height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _religionPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _identityPart(controller),
                ),
              ],
            ),
            height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _jobStatusPart(controller),
                ),
                width(),
                 Expanded(
                  flex: 3,
                  child: _prefixPart(controller),
                ),
              ],
            ),
          ],
        ),
      ),
    );

_desktop(AttributeSetupHrController controller) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _designationPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _gradePart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _empTypePart(controller),
                ),
              ],
            ),
            height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _genderPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _maritialPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _bloodPart(controller),
                ),
              ],
            ),
            height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _religionPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _identityPart(controller),
                ),
                width(),
                Expanded(
                  flex: 3,
                  child: _jobStatusPart(controller),
                ),
              ],
            ),


           height(),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _prefixPart(controller),
                ),
                width(),
                const Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                width(),
                const Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
              ],
            ),







          ],
        ),
      ),
    );

_designationPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_designationLoading.value,
        "Designation master",
        controller.statusList,
        controller.designation_list,
        controller.txt_designation,
        "Designation Name",
        controller.cmb_designation_statusID,
        controller.edit_designationID, () {
      //save
      print("Save");
    }, 300);

_gradePart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_designationLoading.value,
        "Grade master",
        controller.statusList,
        controller.grade_list,
        controller.txt_grade,
        "Grade Name",
        controller.cmb_grade_statusID,
        controller.edit_gradeID, () {
      //save
      print("Save");
    }, 300);

_genderPart(AttributeSetupHrController controller, [double height = 250]) =>
    commonMasterPart(
        controller.is_genderLoading.value,
        "Gender master",
        controller.statusList,
        controller.gender_list,
        controller.txt_gender,
        "Gender Name",
        controller.cmb_gender_statusID,
        controller.edit_genderID, () {
      //save
      print("Save");
    }, height);

_religionPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_religionoading.value,
        "Religion master",
        controller.statusList,
        controller.religion_list,
        controller.txt_religion,
        "Religion Name",
        controller.cmb_religion_statusID,
        controller.edit_religionID, () {
      //save
      print("Save");
    }, 250);

_maritialPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_religionoading.value,
        "Marital Status master",
        controller.statusList,
        controller.marital_list,
        controller.txt_marital,
        "Marital Status Name",
        controller.cmb_marital_statusID,
        controller.edit_maritalID, () {
      //save
      print("Save");
    }, 250);

_bloodPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_religionoading.value,
        "Blood Group master",
        controller.statusList,
        controller.blood_list,
        controller.txt_blood,
        "Blood Group Name",
        controller.cmb_blood_statusID,
        controller.edit_bloodlID, () {
      //save
      print("Save");
    }, 250);

_identityPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_iddentityLoading.value,
        "Identity Type master",
        controller.statusList,
        controller.identity_list,
        controller.txt_identity,
        "Itentity Type Name",
        controller.cmb_identity_statusID,
        controller.edit_identityID, () {
      //save
      print("Save");
    }, 250);

_empTypePart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_iddentityLoading.value,
        "Employee Type master",
        controller.statusList,
        controller.emptype_list,
        controller.txt_emptype,
        "Employee Type Name",
        controller.cmb_emptype_statusID,
        controller.edit_emptypeID, () {
      //save
      print("Save");
    }, 300);

_jobStatusPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_iddentityLoading.value,
        "Job Status Type master",
        controller.statusList,
        controller.jobstatus_list,
        controller.txt_jobstatus,
        "Job Status Type Name",
        controller.cmb_jobstatus_statusID,
        controller.edit_jobstatusID, () {
      //save
      print("Save");
    }, 250);


_prefixPart(AttributeSetupHrController controller) => commonMasterPart(
        controller.is_iddentityLoading.value,
        "Employee Prefix master",
        controller.statusList,
        controller.prefix_list,
        controller.txt_prefix,
        "Prefix Name",
        controller.cmb_prefix_statusID,
        controller.edit_prefixID, () {
      //save
      print("Save");
    }, 250);
