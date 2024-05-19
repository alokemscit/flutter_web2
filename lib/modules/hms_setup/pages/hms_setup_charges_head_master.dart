// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/hms_setup/controller/hms_setup_charges_head_master_controller.dart';

class HmsChargeHeadMaster extends StatelessWidget {
  const HmsChargeHeadMaster({super.key});
  void disposeController() {
    try {
      Get.delete<LabServiceCategoryHeadController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final LabServiceCategoryHeadController controller =
        Get.put(LabServiceCategoryHeadController());
    controller.context = context;
    return Scaffold(
      body: Obx(() => CustomCommonBody(
          controller.isLoading.value,
          controller.isError.value,
          controller.errorMessage.value,
          _mobile(controller),
          _desktop(controller),
          _desktop(controller))),
    );
  }
}

_desktop(LabServiceCategoryHeadController controller) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Expanded(flex: 3, child: _serviceUrgencyMater(controller)),
            width(),
            Expanded(flex: 4, child: _serviceHead(controller, ))
          ],
        ));

_serviceHead(
        LabServiceCategoryHeadController controller, ) =>
    CustomAccordionContainer(
        headerName: "Charges Master",
        height: 0,
        children: [
          _serviceHeadEntry(controller, ),
          height(),
          __serviceHeadTablePart(controller),
        ]);

_serviceHeadEntry(
        LabServiceCategoryHeadController controller, ) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                maxlength: 100,
                caption: "Charges Name",
                controller: controller.txt_HeadName,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_head_status.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_head_status.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");
            controller.saveUpdateHead();
            //await controller.saveUpdateCategory();
          },
              controller.editHeadID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.editHeadID.value = '';
            controller.txt_HeadName.text = '';
            controller.cmb_head_status.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

__serviceHeadTablePart(LabServiceCategoryHeadController controller) => Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(150),
                  1: FlexColumnWidth(130),
                  2: FlexColumnWidth(80),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: kBgDarkColor,
                    ),
                    children: [
                      CustomTableCell("Charges Name"),
                      CustomTableCell("Status"),
                      CustomTableCell("Action"),
                    ],
                  ),
                  for (var i = 0; i < controller.service_head_List.length; i++)
                    TableRow(
                        decoration: BoxDecoration(
                            color: controller.editHeadID.value ==
                                    controller.service_head_List[i].id
                                ? Colors.amber.withOpacity(0.3)
                                : Colors.white),
                        children: [
                          CustomTableCell(
                              controller.service_head_List[i].name!),
                          CustomTableCell(
                              controller.service_head_List[i].status == '1'
                                  ? "Active"
                                  : "Inactive"),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: InkWell(
                                onTap: () {
                                  controller.editHeadID.value =
                                      controller.service_head_List[i].id!;

                                  controller.txt_HeadName.text =
                                      controller.service_head_List[i].name!;
                                  controller.cmb_head_status.value =
                                      controller.service_head_List[i].status!;
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

_serviceUrgencyMater(
        LabServiceCategoryHeadController controller, 
        [double pHeight = 0]) =>
    CustomAccordionContainer(
        headerName: "Service Urgency Master",
        height: pHeight,
        children: [
          _serviceUrgencyEntry(controller ),
          height(),
          __serviceUrgencyTablePart(controller),
        ]);

_serviceUrgencyEntry(
        LabServiceCategoryHeadController controller, ) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                maxlength: 100,
                caption: "Service Urgency Name",
                controller: controller.txt_ServiceCatName,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_service_cat_status.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_service_cat_status.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            controller.saveUpdateServiceUrgebcy();
            // print("object");
            // controller.saveStoreType();
            //await controller.saveUpdateCategory();
          },
              controller.editServiceCatID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.editServiceCatID.value = '';
            controller.txt_ServiceCatName.text = '';
            controller.cmb_service_cat_status.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

__serviceUrgencyTablePart(LabServiceCategoryHeadController controller) =>
    Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(150),
                  1: FlexColumnWidth(130),
                  2: FlexColumnWidth(80),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: kBgDarkColor,
                    ),
                    children: [
                      CustomTableCell("Service Urgency of Name"),
                      CustomTableCell("Status"),
                      CustomTableCell("Action"),
                    ],
                  ),
                  for (var i = 0;
                      i < controller.service_urgency_List.length;
                      i++)
                    TableRow(
                        decoration: BoxDecoration(
                            color: controller.editServiceCatID.value ==
                                    controller.service_urgency_List[i].id
                                ? Colors.amber.withOpacity(0.3)
                                : Colors.white),
                        children: [
                          CustomTableCell(
                              controller.service_urgency_List[i].name!),
                          CustomTableCell(
                              controller.service_urgency_List[i].status == '1'
                                  ? "Active"
                                  : "Inactive"),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: InkWell(
                                onTap: () {
                                  controller.editServiceCatID.value =
                                      controller.service_urgency_List[i].id!;

                                  controller.txt_ServiceCatName.text =
                                      controller.service_urgency_List[i].name!;
                                  controller.cmb_service_cat_status.value =
                                      controller
                                          .service_urgency_List[i].status!;
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

_mobile(LabServiceCategoryHeadController controller,) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          _serviceUrgencyMater(controller, 280),
          height(),
          Expanded(child: _serviceHead(controller, )),
        ],
      ),
    );
