import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/hms_setup/controller/hms_section_master_controller.dart';

class HmsSectionMaster extends StatelessWidget {
  const HmsSectionMaster({super.key});
  void disposeController() {
    try {
      Get.delete<HmsSectionMasterController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    HmsSectionMasterController controller =
        Get.put(HmsSectionMasterController());
    controller.context = context;
    return Scaffold(
      body: Obx(() => CustomCommonBody(
          controller.isLoading.value,
          controller.isError.value,
          controller.errorMessage.value,
          _desktop(controller, true),
          _desktop(controller, true),
          _desktop(controller, false))),
    );
  }
}

_desktop(HmsSectionMasterController controller, bool ismob) => Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [_minTestSetup(controller, ismob)],
    ));

_minTestSetup(HmsSectionMasterController controller, bool isMob) => Expanded(
      child: CustomAccordionContainer(
        isExpansion: false,
          headerName: "Section Setup",
          height: 0,
          children: [
            _entryPart(controller, isMob),
            height(),
            _tablePart(controller),
          ]),
    );

_entryPart(HmsSectionMasterController cnt, bool isMob) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: CustomDropDown(
                      labeltext: "HR Department",
                      id: cnt.cmb_departmentID.value,
                      list: cnt.department_list_all
                          .map((element) => DropdownMenuItem<String>(
                              value: element.id, child: Text(element.name!)))
                          .toList(),
                      onTap: (v) {
                        cnt.cmb_groupID.value = '';
                        cnt.group_list_temp.clear();
                        cnt.cmb_departmentID.value = v!;
                        cnt.LoadGroupList();
                      })),
              width(),
              Expanded(
                  flex: 3,
                  child: CustomDropDown(
                      labeltext: "HMS Department",
                      id: cnt.cmb_groupID.value,
                      list: cnt.group_list_temp
                          .map((element) => DropdownMenuItem<String>(
                              value: element.id, child: Text(element.name!)))
                          .toList(),
                      onTap: (v) {
                        cnt.cmb_groupID.value = v!;
                      })),
              width(),
              // Expanded(
              //     flex: 3,
              //     child: CustomDropDown(
              //         labeltext: "Head Name",
              //         id: cnt.cmb_headID.value,
              //         list: cnt.service_head_List
              //             .map((element) => DropdownMenuItem<String>(
              //                 value: element.id, child: Text(element.name!)))
              //             .toList(),
              //         onTap: (v) {
              //           cnt.cmb_headID.value = v!;
              //         })),
              !isMob ? width() : width(0),
              !isMob ? Expanded(flex: 7, child: _responsive(cnt)) : width(0),
            ],
          ),
          isMob ? _responsive(cnt) : width(0),
        ],
      ),
    );

_responsive(HmsSectionMasterController cnt) => Row(
      children: [
        Expanded(
          child: CustomTextBox(
              maxlength: 100,
              caption: "Section Name Entry",
              controller: cnt.txt_test_name,
              onChange: (value) {}),
        ),
        width(),
        CustomDropDown(
            id: cnt.cmb_statusID.value,
            labeltext: "Status",
            list: cnt.statusList
                .map((element) => DropdownMenuItem<String>(
                    value: element.id, child: Text(element.name!)))
                .toList(),
            onTap: (v) {
              cnt.cmb_statusID.value = v.toString();
            },
            width: 90),
        width(),
        roundedButton(() async {
          cnt.saveUpdateMainTest();
        }, cnt.editTestID.value == '' ? Icons.save_as_sharp : Icons.edit),
        width(),
        roundedButton(() {
          cnt.editTestID.value = '';
          cnt.txt_test_name.text = '';
          cnt.cmb_departmentID.value = '';
          cnt.cmb_groupID.value = '';
          //cnt.cmb_headID.value = '';
          cnt.cmb_statusID.value = '1';
          cnt.group_list_temp.clear();
        }, Icons.undo_sharp)
      ],
    );

_tablePart(HmsSectionMasterController cnt) => Expanded(
      child: Column(
        children: [
          height(),
          Row(
            children: [
              Expanded(
                  child: CustomSearchBox(
                      caption: "Search Section",
                      controller: cnt.txt_tsearch,
                      onChange: (v) {
                        cnt.searchSection();
                      }))
            ],
          ),
          height(),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(40),
                  1: FlexColumnWidth(80),
                  2: FlexColumnWidth(100),
                  3: FlexColumnWidth(140),
                  4: FixedColumnWidth(70),
                  5: FixedColumnWidth(60)
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: kBgDarkColor,
                    ),
                    children: [
                      CustomTableCell("ID"),
                      CustomTableCell("HR Department"),
                      CustomTableCell("HMS Department"),
                      CustomTableCell("Section Name"),
                      CustomTableCell("Status"),
                      CustomTableCell("Edit"),
                    ],
                  ),
                  for (var i = 0; i < cnt.testmain_list_temp.length; i++)
                    TableRow(
                        decoration: BoxDecoration(
                            color: cnt.editTestID.value ==
                                    cnt.testmain_list_temp[i].id
                                ? Colors.amber.withOpacity(0.3)
                                : Colors.white),
                        children: [
                          CustomTableCell(cnt.testmain_list_temp[i].id!),
                          CustomTableCell(
                              cnt.testmain_list_temp[i].hrDeptName!),
                          CustomTableCell(
                              cnt.testmain_list_temp[i].hmsDeptName!),
                          CustomTableCell(cnt.testmain_list_temp[i].name!),
                          CustomTableCell(
                              cnt.testmain_list_temp[i].status == '1'
                                  ? "Active"
                                  : "Inactive"),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: InkWell(
                                onTap: () {
                                  cnt.cmb_groupID.value = '';
                                  cnt.cmb_departmentID.value =
                                      cnt.testmain_list_temp[i].hrDeptId!;
                                  cnt.LoadGroupList();

                                  cnt.editTestID.value =
                                      cnt.testmain_list_temp[i].id!;

                                  cnt.txt_test_name.text =
                                      cnt.testmain_list_temp[i].name!;

                                  // print(cnt.testmain_list_temp[i].hrDeptId!);

                                  cnt.cmb_groupID.value =
                                      cnt.testmain_list_temp[i].hmsDeptId!;
                                  //  print(cnt.testmain_list_temp[i].hmsDeptId!);

                                  cnt.cmb_statusID.value =
                                      cnt.testmain_list_temp[i].status!;
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
