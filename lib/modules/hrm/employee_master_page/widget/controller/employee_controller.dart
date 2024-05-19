// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/const_string.dart';

import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';

import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_status.dart';

import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_department.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_section_unit.dart';
import 'package:web_2/modules/hrm/employee_master_page/model/model_emp_load_master_table.dart';
import '../../../../../component/settings/config.dart';

class EmployeeController extends GetxController {
  final BuildContext context;
  late CustomBusyLoader loader;
  late CustomAwesomeDialog dialog;

  late data_api2 api;
  final Rx<File> imageFile = File('').obs;
  var isImageUpdate = false.obs;
  var isDisableID = true.obs;
  var elist = <ModelMasterEmpTable>[].obs;
  //var elist_prifix = <ModelMasterEmpTable>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var companyName = "".obs;
  var uid = ''.obs;
  //var user=ModelUser().obs;
  var user = ModelUser().obs;

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
  var cmb_department_category = ''.obs;
  final TextEditingController txt_emp_doj = TextEditingController();

  var department_list = <ModelDepartment>[].obs;
  var section_list = <ModelSectionUnit>[].obs;

  EmployeeController({required this.context});

  getSection() async {
    try {
      var x = await api.createLead([
        {
          "tag": "24",
          "cid": user.value.cid,
        }
      ]);
      section_list.clear();
      section_list.addAll(x.map((e) => ModelSectionUnit.fromJson(e)).where(
          (element) =>
              element.depId == cmb_department.value && element.status == '1'));
    } catch (e) {
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
    }
  }

  getDeoartment() async {
    try {
      var x = await api.createLead([
        {
          "tag": "23",
          "cid": user.value.cid,
        }
      ]);
      department_list.clear();
      department_list.addAll(x.map((e) => ModelDepartment.fromJson(e)).where(
          (element) =>
              element.catId == cmb_department_category.value &&
              element.status == '1'));
    } catch (e) {
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
    }
  }

  Future<void> ImageUpload() async {
    if (imageFile.value.path == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "No new Image selected for upload"
        ..show();
      // customAwesamDialodOk(context, DialogType.warning, "Warning!",
      //     'No new Image selected for upload', () {});
      return;
    }
    if (uid.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Employee edit mode required"
        ..show();
      return;
    }
    var img = await imageFileToBase64(imageFile.value.path);
    loader.show();
    var x = await api.createLead([
      {"path": "img", "img": img}
    ], "save_image");

    ModelStatus st = x.map((e) => ModelStatus.fromJson(e)).first;
    if (st == null || st.id != "1") {
      dialog
        ..dialogType = DialogType.error
        ..message = "Faillure to upload image!"
        ..show();
      loader.close();
      return;
    }
    api.createLead([
      {
        "tag": "39",
        "id": uid.value,
        "path": st.msg,
      }
    ]).then((value) {
      getStatusWithDialog(value, dialog).then((value) {
        loader.close();
      });
    });

    //print(x);
  }

  void empSearch() {
    if (txt_emp_name.text.length == 10) {}
  }

  Undo() {
    cmb_department_category.value = '';
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
    uid.value = '';
  }

  EditEmployee() {
    if (!isDisableID.value) {
      isDisableID.value = true;
      uid.value = '';
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
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select prefix"
        ..show();

      return;
    }

    if (txt_emp_name.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter name"
        ..show();
      return;
    }

    if (txt_emp_dob.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter date of birth"
        ..show();

      return;
    }
    if (cmb_nationality.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select nationality"
        ..show();

      return;
    }
    if (txt_emp_father.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter father's name"
        ..show();

      return;
    }
    if (txt_emp_mother.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter mother's name"
        ..show();

      return;
    }
    if (cmb_gender.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select gender"
        ..show();

      return;
    }
    if (cmb_religion.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select religion"
        ..show();

      return;
    }

    if (cmb_maritalstatus.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select marital status"
        ..show();

      return;
    }
    if (cmb_bloodgroup.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select blood group"
        ..show();

      return;
    }
    if (cmb_identitytype.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select identity type"
        ..show();

      return;
    }
    if (txt_emp_identityname.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter identity number"
        ..show();

      return;
    }
    if (cmb_designation.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select designation"
        ..show();

      return;
    }
    if (cmb_grade.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select grade"
        ..show();

      return;
    }
    if (cmb_department_category.isEmpty) {
      customAwesamDialodOk(context, DialogType.warning, "Warning!",
          "Please select department Category", () {});
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
    // customBusyDialog(context);
    loader.show();
    String img_path = '';
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
    // print(img_path);

    String s =
        '''$CustomXmlFormat<r><a><id>${txt_emp_id.text}</id><uid>${uid.value == '' ? '0' : uid.value}</uid><prefix>${cmb_prefix.value}</prefix><name>${txt_emp_name.text}</name>
    <dob>${txt_emp_dob.text}</dob><nationality>${cmb_nationality.value}</nationality>
    <fname>${txt_emp_father.text}</fname><mname>${txt_emp_mother.text}</mname>
    <sname>${txt_emp_spouse.text}</sname><gender>${cmb_gender.value}</gender><religion>${cmb_religion.value}</religion>
    <mstatus>${cmb_maritalstatus.value}</mstatus><bg>${cmb_bloodgroup.value}</bg><itype>${cmb_identitytype.value}</itype>
    <ino>${txt_emp_identityname.text}</ino><designation>${cmb_designation.value}</designation><grade>${cmb_grade.value}</grade>
    <dept>${cmb_department.value}</dept><section>${cmb_section.value}</section><etype>${cmb_emptype.value} </etype>
    <jstatus>${cmb_jobstatus.value}</jstatus><doj>${txt_emp_doj.text}</doj><dcat>${cmb_department_category.value}</dcat>
    <note>${txt_emp_note.text}</note><img>${img_path.toString()}</img>
    </a></r>''';

    try {
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
      loader.close();
      // Get.back();
      //print(x);
      // ignore: use_build_context_synchronously
      //isLoading.value = false;
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      // ignore: use_build_context_synchronously
      //print(x);
      bool b = GetStatusMessage(context, x);
      if (b) {
        // Undo();

        isDisableID.value = false;
        txt_emp_id.text =
            x.map((e) => ModelStatus.fromJson(e)).first.extra.toString();
        uid.value = x.map((e) => ModelStatus.fromJson(e)).first.id.toString();
      }
    } catch (e) {
      loader.close();
      //isLoading.value = true;
      //Get.back();
      //errorMessage(e.toString());
      // ignore: use_build_context_synchronously
      //Navigator.pop(context);
      // ignore: use_build_context_synchronously
      customAwesamDialodOk(
          context, DialogType.error, "Error!", e.toString(), () {});
    }
  }

  void advabceSearch() {
// showCupertinoDialog(
//     context: context,
//     builder: (BuildContext context1) {
//       return CupertinoAlertDialog(
//         title: const Text("Advance Employee Search"),
//         content: LayoutBuilder(
//             builder: (context1, constraints) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Container(
//                   height: constraints.maxHeight*.8,
//                   width: constraints.maxWidth>1350?1200:constraints.maxWidth,
//                   color: Colors.black,
//                   child: const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: CupertinoActivityIndicator(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               );
//             }
//           ),
//         actions: [
//           CupertinoDialogAction(
//             child: const Text( 'Close'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog

//             },
//           ),
//           // CupertinoDialogAction(
//           //   isDefaultAction: true, // Emphasize the primary action
//           //   child: Text('Yes'),
//           //   onPressed: () {
//           //     Navigator.of(context).pop(); // Close the dialog

//           //   },
//           // ),
//         ],
//       );
//     },
//   );

    showDialog<void>(
      useSafeArea :false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                       // borderRadius: BorderRadiusDirectional.circular(50)
                      ),
                      height: constraints.maxHeight * .85,
                      width: constraints.maxWidth > 1350
                          ? 1200
                          : constraints.maxWidth,
                      // color: Colors.grey.shade200,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                        
                          decoration: CustomCaptionDecoration(0.5,Colors.black),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCaptionForContainer("Search Employee"),
                              height(8),
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: CustomSearchBox(
                                                  caption: "Employee Search",
                                                  controller: TextEditingController(),
                                                  onChange: (v) {})),
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            for(var i=0;i<100;i++)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2),
                                              child: Container(height: 50,color: Colors.amber,),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 5,
                      top: 3,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(50)),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              )),
                        ),
                      )),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  setEnableDisableID() {
    isDisableID(!isDisableID.value);
  }

  @override
  void onInit() async {
    // print("init call");
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    isLoading(true);
    api = data_api2();
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
