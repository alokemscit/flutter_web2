import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';

import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/hms_setup/controller/hms_department_Setup_Controller.dart';

class HmsDepartmentSetup extends StatelessWidget {
  const HmsDepartmentSetup({super.key});
  void disposeController() {
    try {
      Get.delete<HmsDepartmentSetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    HmsDepartmentSetupController cnt = Get.put(HmsDepartmentSetupController());
    cnt.context = context;
    return Scaffold(
      body: Obx(() => CustomCommonBody(cnt.isLoading.value, cnt.isError.value,
          cnt.errorMessage.value, _mobile(cnt), _mobile(cnt), _desktop(cnt))),
    );
  }
}

_mobile(
  HmsDepartmentSetupController cnt,
) =>
    Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [Expanded(child: _groupMaster(cnt))],
      ),
    );
_desktop(HmsDepartmentSetupController cnt) => Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _groupMaster(cnt),
          ),
          const Expanded(
            flex: 3,
            child: SizedBox(),
          )
        ],
      ),
    );

_groupMaster(HmsDepartmentSetupController cnt) => CustomAccordionContainer(
        headerName: "Hospital Department Master",
        height: 0,
        isExpansion: false,
        children: [
          _groupEntry(cnt),
          height(),
          _groupTablePart(cnt),
        ]);

_groupTablePart(HmsDepartmentSetupController cnt) => Expanded(
      child: Column(
        children: [
          height(),
          Row(
            children: [
              Expanded(
                  child: CustomSearchBox(
                      caption: "Hospital Department Search",
                      controller: cnt.txt_group_search,
                      onChange: (v) {
                        cnt.Search();
                      }))
            ],
          ),
          height(),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(50),
                  1: FlexColumnWidth(120),
                  2: FlexColumnWidth(140),
                  3: FlexColumnWidth(80),
                  4: FlexColumnWidth(50),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: kBgDarkColor,
                    ),
                    children: [
                      CustomTableCell("ID"),
                      CustomTableCell("HR Department"),
                      CustomTableCell("Hospital Department Nane"),
                      CustomTableCell("Status"),
                      CustomTableCell("Action"),
                    ],
                  ),
                  for (var i = 0; i < cnt.group_list_temp.length; i++)
                    TableRow(
                        decoration: BoxDecoration(
                            color: cnt.editGroupID.value ==
                                    cnt.group_list_temp[i].id
                                ? Colors.amber.withOpacity(0.3)
                                : Colors.white),
                        children: [
                          CustomTableCell(cnt.group_list_temp[i].id!),
                          CustomTableCell(cnt.group_list_temp[i].deptName!),
                          CustomTableCell(cnt.group_list_temp[i].name!),
                          CustomTableCell(cnt.group_list_temp[i].status == '1'
                              ? "Active"
                              : "Inactive"),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: InkWell(
                                onTap: () {
                                  cnt.editGroupID.value =
                                      cnt.group_list_temp[i].id!;

                                  cnt.txt_group_name.text =
                                      cnt.group_list_temp[i].name!;
                                  cnt.cmb_departmentID.value =
                                      cnt.group_list_temp[i].deptId!;
                                  cnt.cmb_groupStatusID.value =
                                      cnt.group_list_temp[i].status!;
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: kWebHeaderColor,
                                    size: 12,
                                  ),
                                ),
                              )),
                        ])
                ],
                border: CustomTableBorder(),
              ),
            ),
          )
        ],
      ),
    );

_groupEntry(
  HmsDepartmentSetupController cnt,
) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: CustomDropDown(
                  labeltext: "HR Department",
                  id: cnt.cmb_departmentID.value,
                  list: cnt.department_list_temp
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    cnt.cmb_departmentID.value = v!;
                  })),
          width(),
          Expanded(
            flex: 6,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Hospital Department Name",
                controller: cnt.txt_group_name,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: cnt.cmb_groupStatusID.value,
              labeltext: "Status",
              list: cnt.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                cnt.cmb_groupStatusID.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            cnt.saveUpdateGroupSetup();
            // print("object");
            // controller.saveStoreType();
            //await controller.saveUpdateCategory();
          }, cnt.editGroupID.value == '' ? Icons.save_as_sharp : Icons.edit),
          width(),
          roundedButton(() {
            cnt.cmb_groupStatusID.value = "1";
            cnt.txt_group_name.text = '';
            cnt.editGroupID.value = '';
            // controller.editServiceCatID.value = '';
            //controller.txt_ServiceCatName.text = '';
            //controller.cmb_service_cat_status.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );
