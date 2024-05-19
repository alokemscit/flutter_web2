// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
 
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';

import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/Inventory/pages/attribute_setup_page/controller/inventory_attribute_controller.dart';

class InvAttributeSetup extends StatelessWidget {
  const InvAttributeSetup({super.key});
  void disposeController() {
    try {
      Get.delete<InvmsAttributeController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    InvmsAttributeController controller =
        Get.put(InvmsAttributeController(context: context));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _mobile(controller),
            _desktop(controller),
            _desktop(controller)),
      ),
    );
  }
}

 

_mobile(InvmsAttributeController controller) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StoreTypePart(controller),
            height(),
            _groupPart(controller),
            height(),
            _subGroupPart(controller)
          ],
        ),
      ),
    );


_desktop(InvmsAttributeController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _StoreTypePart(controller),
              ),
              width(),
              Expanded(
                flex: 5,
                child: _groupPart(controller),
              ),
              
            ],
          ),
          height(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: _subGroupPart(controller),
              ),
            ],
          )
        ],
      ),
    );

_StoreTypePart(InvmsAttributeController controller) =>
    CustomAccordionContainer(headerName: "Store Type", children: [
      _StoreTypeEnryPart(controller),
      _StoreTypeTablePart(controller)
    ]);

_StoreTypeTablePart(InvmsAttributeController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBox(
                      // borderRadious: 12,
                      labelTextColor: kGrayColor,
                      isFilled: true,
                      caption: "Search Store Type",
                      controller: controller.txt_StoreTypeSearch,
                      onChange: (v) {
                        controller.searchStoreType();
                      }),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(130),
                    1: FlexColumnWidth(80),
                    2: FlexColumnWidth(30),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: kBgDarkColor,
                      ),
                      children: [
                        CustomTableCell("Name"),
                        CustomTableCell("Status"),
                        CustomTableCell("Action"),
                      ],
                    ),
                    for (var i = 0;
                        i < controller.storeTypeList_temp.length;
                        i++)
                      TableRow(
                          decoration: BoxDecoration(
                            color: controller.editStoreTypeID.value !=
                                    controller.storeTypeList_temp[i].id
                                ? Colors.white
                                : Colors.amber.withOpacity(0.3),
                          ),
                          children: [
                            CustomTableCell(
                                controller.storeTypeList_temp[i].name!),
                            CustomTableCell(
                                controller.storeTypeList_temp[i].status == '1'
                                    ? "Active"
                                    : "Inactive"),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    controller.editStoreTypeID.value =
                                        controller.storeTypeList_temp[i].id!;
                                    controller.txt_StoreType.text =
                                        controller.storeTypeList_temp[i].name!;
                                    controller.cmb_StoreTypeStatusId.value =
                                        controller
                                            .storeTypeList_temp[i].status!;
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
      ),
    );

_StoreTypeEnryPart(InvmsAttributeController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                maxlength: 100,
                caption: "Store Type Name",
                controller: controller.txt_StoreType,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_StoreTypeStatusId.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_StoreTypeStatusId.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");
            controller.saveStoreType();
            //await controller.saveUpdateCategory();
          },
              controller.editStoreTypeID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.editStoreTypeID.value = '';
            controller.txt_StoreType.text = '';
            controller.cmb_StoreTypeStatusId.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_groupPart(InvmsAttributeController controller) => CustomAccordionContainer(
    headerName: "Item Group",
    children: [_groupEnryPart(controller), _groupTablePart(controller)]);

_groupEnryPart(InvmsAttributeController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomDropDown(
                id: controller.cmb_StoreTypeId2.value,
                labeltext: "Store Type",
                list: controller.storeTypeList
                    .map((element) => DropdownMenuItem<String>(
                        value: element.id, child: Text(element.name!)))
                    .toList(),
                onTap: (v) {
                  controller.cmb_StoreTypeId2.value = v.toString();
                },
                width: 90),
          ),
          width(),
          Expanded(
            flex: 5,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Category Name",
                controller: controller.txt_Group,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_GroupStatusId.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_GroupStatusId.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");
            controller.saveGroup();
            //await controller.saveUpdateCategory();
          },
              controller.editGroupId.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.cmb_StoreTypeId2.value = '';
            controller.editGroupId.value = '';
            controller.txt_Group.text = '';
            controller.cmb_GroupStatusId.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_groupTablePart(InvmsAttributeController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBox(
                      caption: "Search Group",
                      controller: TextEditingController(),
                      onChange: (v) {}),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(110),
                    1: FlexColumnWidth(130),
                    2: FlexColumnWidth(80),
                    3: FlexColumnWidth(30),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: kBgDarkColor,
                      ),
                      children: [
                        CustomTableCell("Stre Type"),
                        CustomTableCell("Group Name"),
                        CustomTableCell("Status"),
                        CustomTableCell("Action"),
                      ],
                    ),
                    for (var i = 0; i < controller.groupList.length; i++)
                      TableRow(
                          decoration: BoxDecoration(
                              color: controller.editGroupId.value ==
                                      controller.groupList[i].id
                                  ? Colors.amber.withOpacity(0.3)
                                  : Colors.white),
                          children: [
                            CustomTableCell(
                                controller.groupList[i].storeTypeName!),
                            CustomTableCell(controller.groupList[i].name!),
                            CustomTableCell(
                                controller.groupList[i].status == '1'
                                    ? "Active"
                                    : "Inactive"),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    controller.editGroupId.value =
                                        controller.groupList[i].id!;
                                    controller.cmb_StoreTypeId2.value =
                                        controller.groupList[i].storeTypeId!;
                                    controller.txt_Group.text =
                                        controller.groupList[i].name!;
                                    controller.cmb_GroupStatusId.value =
                                        controller.groupList[i].status!;
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
      ),
    );

_subGroupPart(InvmsAttributeController controller) =>
    CustomAccordionContainer(headerName: "Item Sub Group", children: [
      _subGroupEnryPart(controller),
      _subGroupTablePart(controller),
    ]);
_subGroupEnryPart(InvmsAttributeController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomDropDown(
              id: controller.cmb_StoreTypeId3.value,
              labeltext: "Store Type",
              list: controller.storeTypeList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_GroupId2.value = '';
                controller.cmb_StoreTypeId3.value = v.toString();
              },
            ),
          ),
          width(),
          Expanded(
            flex: 3,
            child: CustomDropDown(
              id: controller.cmb_GroupId2.value,
              labeltext: "Item Group",
              list: controller.groupList
                  .where((p0) =>
                      p0.storeTypeId == controller.cmb_StoreTypeId3.value)
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_GroupId2.value = v.toString();
              },
            ),
          ),
          width(),
          Expanded(
            flex: 5,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Item Sub Group Name",
                controller: controller.txt_SubGroup,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_SubGroupStatusId.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_SubGroupStatusId.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            // print("object");

            controller.saveSubGroup();
          },
              controller.editSubGroupID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.editSubGroupID.value = '';
            controller.txt_SubGroup.text = '';
            controller.cmb_SubGroupStatusId.value = "1";

            controller.cmb_GroupId2.value = '';
            controller.cmb_StoreTypeId3.value = '';
          }, Icons.undo_sharp)
        ],
      ),
    );

_subGroupTablePart(InvmsAttributeController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBox(
                      caption: "Search Sub Group",
                      controller: TextEditingController(),
                      onChange: (v) {}),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(110),
                    1: FlexColumnWidth(120),
                    2: FlexColumnWidth(130),
                    3: FlexColumnWidth(80),
                    4: FlexColumnWidth(30),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: kBgDarkColor,
                      ),
                      children: [
                        CustomTableCell("Stre Type"),
                        CustomTableCell("Group Name"),
                        CustomTableCell("Sub Group Name"),
                        CustomTableCell("Status"),
                        CustomTableCell("Edit"),
                      ],
                    ),
                    for (var i = 0;
                        i < controller.subGroupList_temp.length;
                        i++)
                      TableRow(
                          decoration: BoxDecoration(
                              color: controller.editSubGroupID.value ==
                                      controller.subGroupList_temp[i].id
                                  ? Colors.amber.withOpacity(0.3)
                                  : Colors.white),
                          children: [
                            CustomTableCell(
                                controller.subGroupList_temp[i].storeTypeName!),
                            CustomTableCell(
                                controller.subGroupList_temp[i].groupName!),
                            CustomTableCell(
                                controller.subGroupList_temp[i].name!),
                            CustomTableCell(
                                controller.subGroupList_temp[i].status == '1'
                                    ? "Active"
                                    : "Inactive"),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    controller.editSubGroupID.value =
                                        controller.subGroupList_temp[i].id!;
                                    controller.cmb_StoreTypeId3.value =
                                        controller
                                            .subGroupList_temp[i].storeTypeId!;

                                    controller.cmb_GroupId2.value = controller
                                        .subGroupList_temp[i].groupId!;

                                    controller.txt_SubGroup.text =
                                        controller.subGroupList_temp[i].name!;
                                    controller.cmb_SubGroupStatusId.value =
                                        controller.subGroupList_temp[i].status!;
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
      ),
    );
