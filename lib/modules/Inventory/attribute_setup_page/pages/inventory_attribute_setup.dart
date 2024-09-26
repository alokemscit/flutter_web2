// ignore_for_file: non_constant_identifier_names, unused_element

 

import 'package:web_2/component/widget/custom_panel.dart';
import 'package:web_2/core/config/const.dart';

import 'package:web_2/modules/Inventory/attribute_setup_page/controller/inventory_attribute_controller.dart';

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
    InvmsAttributeController controller = Get.put(InvmsAttributeController());
    controller.context = context;

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Obx(
        () => CommonBody3(
          controller,
          [
            controller.isFullScreen.value
                ? _maximizedPanel(controller)
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _treeControll(controller),
                      ),
                    ),
                  )
          ],
          'Attributes Setup',
        ),
      ),
    );
  }
}

Widget _maximizedPanel(InvmsAttributeController controller) => Expanded(
      child: Stack(
        children: [
          Row(
            children: [
              controller.selectedAccordianId.value == '1'
                  ? _StoreTypePart(controller)
                  : controller.selectedAccordianId.value == '2'
                      ? _groupPart(controller)
                      : controller.selectedAccordianId.value == '3'
                          ? _subGroupPart(controller)
                          : controller.selectedAccordianId.value == '4'
                              ? _unitMaster(controller)
                              : controller.selectedAccordianId.value == '5'
                                  ? _company(controller)
                                  : _itemGenericMaster(controller),
            ],
          ),
          Positioned(
              top: 0,
              right: 4,
              child: InkWell(
                onTap: () {
                  controller.isFullScreen.value = false;
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: appColorGrayDark,
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close_fullscreen,
                      size: 14,
                      color: Colors.white,
                    )),
              ))
        ],
      ),
    );

_setMaximizeButton(InvmsAttributeController controller, String id) => InkWell(
      onTap: () {
        controller.selectedAccordianId.value = id;
        controller.isFullScreen.value = true;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Maximize",
              style: customTextStyle.copyWith(
                fontSize: 10,
              ),
            ),
            4.widthBox,
            const Icon(
              Icons.fullscreen_outlined,
              size: 18,
              color: appColorLogo,
            ),
          ],
        ),
      ),
    );

Widget _treeControll(InvmsAttributeController controller) => Column(
      children: controller.list_task
          .map((f) => CustomPanel(
                  isSelectedColor: false,
                  isSurfixIcon: false,
                  selectedTitleColor: Colors.black38.withOpacity(0.08),
                  isExpanded: controller.selectedAccordianId.value == f.id
                      ? true
                      : false,
                  onTap: (v) {
                    // print(f.id!);
                    //controller.selectedAccordianId.value = f.id!;
                  },
                  title: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: appColorLogoDeep,
                          size: 16,
                        ),
                        4.widthBox,
                        Text(
                          '${f.name!} ',
                          style: customTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    SizedBox(
                      height: 600,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              f.id == '1'
                                  ? _StoreTypePart(controller)
                                  : f.id == '2'
                                      ? _groupPart(controller)
                                      : f.id == '3'
                                          ? _subGroupPart(controller)
                                          : f.id == '4'
                                              ? _unitMaster(controller)
                                              : f.id == '5'
                                                  ? _company(controller)
                                                  : _itemGenericMaster(
                                                      controller),
                            ],
                          ),
                          Positioned(
                              top: 0,
                              right: 4,
                              child: _setMaximizeButton(controller, f.id!))
                        ],
                      ),
                    )
                  ]))
          .toList(),
    );

Widget _itemGenericMaster(InvmsAttributeController controller) => Expanded(
      child: CustomGroupBox(
        groupHeaderText:
            controller.isFullScreen.value ? 'Item Generic Master' : '',
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                width: 800,
                child: Column(children: [
                  CustomGroupBox(
                    groupHeaderText: '',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomDropDown(
                                  width: 90,
                                  id: controller.cmb_StoreTypeId6.value,
                                  list: controller.storeTypeList
                                      .map(
                                          (element) => DropdownMenuItem<String>(
                                              value: element.id,
                                              child: Text(
                                                element.name!,
                                                style: CustomDropdownTextStyle,
                                              )))
                                      .toList(),
                                  onTap: (v) {
                                    //controller.cmb_StoreTypeId6.value = v!;
                                     controller.setGenericStoreType(v!);
                                  }),
                              8.widthBox,
                              Expanded(
                                  child: CustomTextBox(
                                      caption: 'Generic Name',
                                      controller: controller.txt_genericName,
                                      onChange: (v) {})),
                              8.widthBox,
                              CustomDropDown(
                                  labeltext: 'Status',
                                  width: 100,
                                  id: controller.cmb_GenericStatusID.value,
                                  list: controller.statusList
                                      .map(
                                          (element) => DropdownMenuItem<String>(
                                              value: element.id,
                                              child: Text(
                                                element.name!,
                                                style: CustomDropdownTextStyle,
                                              )))
                                      .toList(),
                                  onTap: (v) {
                                    controller.cmb_GenericStatusID.value = v!;
                                  }),
                              8.widthBox,
                              CustomSaveUpdateButtonWithUndo(
                                  controller.editGenericId.value != '', () {
                                controller.saveUpdateGeneric();
                              }, () {
                                controller.txt_genericName.text = '';
                                controller.editGenericId.value = '';
                              })
                              // Row(
                              //   children: [
                              //     CustomButton(
                              //         controller.editUnitID.value != ''
                              //             ? Icons.update
                              //             : Icons.save,
                              //         controller.editUnitID.value != ''
                              //             ? "Update"
                              //             : "Save", () {
                              //       controller.saveUpdateUnit();
                              //     }),
                              //     controller.editUnitID.value == ''
                              //         ? const SizedBox()
                              //         : Row(
                              //             children: [
                              //               4.widthBox,
                              //               CustomUndoButtonRounded(onTap: () {
                              //                 controller.txt_Unit.text = '';
                              //                 controller.editUnitID.value = '';
                              //               })
                              //             ],
                              //           ),
                              //   ],
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.heightBox,
                  Expanded(
                    child: CustomGroupBox(
                        padingvertical: 8,
                        groupHeaderText: '',
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                    child: CustomSearchBox(
                                        caption: 'Search',
                                        width: 250,
                                        controller:
                                            controller.txt_genericSearch,
                                        onChange: (v) {}))
                              ],
                            ),
                            8.heightBox,
                            Expanded(
                              child: CustomTableGenerator(
                                  colWidtList: const [
                                    100,
                                    80,
                                    50,
                                    20
                                  ],
                                  childrenHeader: [
                                    CustomTableClumnHeader("Generic Name"),
                                    CustomTableClumnHeader("Store Type"),
                                    CustomTableClumnHeader("Status"),
                                    CustomTableEditCell(() {}, Icons.star)
                                  ],
                                  childrenTableRowList: controller
                                      .list_generic_temp
                                      .map((f) => TableRow(
                                              decoration: BoxDecoration(
                                                  color: controller.editGenericId
                                                              .value ==
                                                          f.id
                                                      ? appColorPista
                                                          .withOpacity(0.3)
                                                      : Colors.white),
                                              children: [
                                                CustomTableCell2(f.name),
                                                 CustomTableCell2(f.stypeName),
                                                CustomTableCell2(
                                                    f.status == '1'
                                                        ? 'Active'
                                                        : 'Inactive',
                                                    true),
                                                CustomTableEditCell(() {
                                                  controller.setGenericEdit(f);
                                                })
                                              ]))
                                      .toList()),
                            )
                          ],
                        )),
                  )

                  //_StoreTypeEnryPart(controller),
                  //_StoreTypeTablePart(controller)
                ]),
              ),
            ),
          ],
        ),
      ),
    );

Widget _company(InvmsAttributeController controller) => Expanded(
    child: CustomGroupBox(
        //   bgColor: appGray100,
        padingvertical: 0,
        groupHeaderText: controller.isFullScreen.value ? 'Company Master' : '',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 600,
                      child: CustomGroupBox(
                          padingvertical: 2,
                          groupHeaderText: 'Company Details',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomDropDown(
                                      width: 150,
                                      id: controller.cmb_StoreTypeId5.value,
                                      list: controller.storeTypeList
                                          .map((element) =>
                                              DropdownMenuItem<String>(
                                                  value: element.id,
                                                  child: Text(
                                                    element.name!,
                                                    style:
                                                        CustomDropdownTextStyle,
                                                  )))
                                          .toList(),
                                      onTap: (v) {
                                        controller.loadCompanyList(v!);
                                      },
                                      labeltext: 'Store Type',
                                    ),
                                  ],
                                ),
                                8.heightBox,
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomTextBox(
                                            caption: 'Company Name',
                                            maxlength: 150,
                                            controller:
                                                controller.txt_company_name,
                                            onChange: (v) {})),
                                  ],
                                ),
                                8.heightBox,
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomTextBox(
                                            caption: 'Company Address',
                                            maxlength: 1000,
                                            maxLine: null,
                                            height: null,
                                            textInputType:
                                                TextInputType.multiline,
                                            controller:
                                                controller.txt_company_address,
                                            onChange: (v) {})),
                                  ],
                                ),
                                8.heightBox,
                                Row(
                                  children: [
                                    CustomTextBox(
                                        caption: 'Contact No',
                                        textInputType: TextInputType.phone,
                                        maxlength: 18,
                                        width: 150,
                                        controller:
                                            controller.txt_company_contactno,
                                        onChange: (v) {}),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomButton(
                                              controller.editCompanyID.value !=
                                                      ''
                                                  ? Icons.update
                                                  : Icons.save,
                                              controller.editUnitID.value != ''
                                                  ? "Update"
                                                  : "Save", () {
                                            controller.saveUpdateCompany();
                                          }),
                                          controller.editCompanyID.value == ''
                                              ? const SizedBox()
                                              : Row(
                                                  children: [
                                                    4.widthBox,
                                                    CustomUndoButtonRounded(
                                                        onTap: () {
                                                      controller
                                                          .txt_company_name
                                                          .text = '';
                                                      controller
                                                          .txt_company_address
                                                          .text = '';
                                                      controller.editCompanyID
                                                          .value = '';
                                                    })
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                8.heightBox,
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: CustomGroupBox(
                      padingvertical: 2,
                      groupHeaderText: 'List of Company',
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                                child: CustomSearchBox(
                                    caption: 'Search',
                                    width: 350,
                                    controller: controller.txt_company_search,
                                    onChange: (v) {}))
                          ],
                        ),
                        8.heightBox,
                        Expanded(
                          child: CustomTableGenerator(
                              colWidtList: const [
                                150,
                                200,
                                50,
                                60,
                                20
                              ],
                              childrenHeader: [
                                CustomTableClumnHeader("Company Name"),
                                CustomTableClumnHeader("Company Address"),
                                CustomTableClumnHeader("Contact No."),
                                CustomTableClumnHeader("Store Type"),
                                CustomTableClumnHeader("*", Alignment.center),
                              ],
                              childrenTableRowList: controller.list_company_temp
                                  .map((f) => TableRow(
                                          decoration: BoxDecoration(
                                              color: controller.editCompanyID
                                                          .value ==
                                                      f.id
                                                  ? appColorPista
                                                      .withOpacity(0.3)
                                                  : Colors.white),
                                          children: [
                                            CustomTableCell2(f.name),
                                            CustomTableCell2(f.address),
                                            CustomTableCell2(f.mob),
                                            CustomTableCell2(f.stypeName),
                                            CustomTableEditCell(() {
                                              controller.setCompanyForEdit(f);
                                            })
                                          ]))
                                  .toList()),
                        ),
                        8.heightBox,
                      ]))),
            ],
          ),
        )));

Widget _unitMaster(InvmsAttributeController controller) => Expanded(
      child: CustomGroupBox(
        groupHeaderText:
            controller.isFullScreen.value ? 'Item Unit Master' : '',
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                width: 600,
                child: Column(children: [
                  CustomGroupBox(
                    groupHeaderText: '',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomDropDown(
                                  width: 90,
                                  id: controller.cmb_StoreTypeId4.value,
                                  list: controller.storeTypeList
                                      .map(
                                          (element) => DropdownMenuItem<String>(
                                              value: element.id,
                                              child: Text(
                                                element.name!,
                                                style: CustomDropdownTextStyle,
                                              )))
                                      .toList(),
                                  onTap: (v) {
                                    //controller.cmb_StoreTypeId4.value = v!;
                                    controller.loadStoreTypeForUnt(v!);
                                  }),
                              8.widthBox,
                              Expanded(
                                  child: CustomTextBox(
                                      caption: 'Unit Name',
                                      controller: controller.txt_Unit,
                                      onChange: (v) {})),
                              8.widthBox,
                              CustomDropDown(
                                  labeltext: 'Status',
                                  width: 100,
                                  id: controller.cmb_UnitStatusId.value,
                                  list: controller.statusList
                                      .map(
                                          (element) => DropdownMenuItem<String>(
                                              value: element.id,
                                              child: Text(
                                                element.name!,
                                                style: CustomDropdownTextStyle,
                                              )))
                                      .toList(),
                                  onTap: (v) {
                                    controller.cmb_UnitStatusId.value = v!;
                                  }),
                              8.widthBox,
                              Row(
                                children: [
                                  CustomButton(
                                      controller.editUnitID.value != ''
                                          ? Icons.update
                                          : Icons.save,
                                      controller.editUnitID.value != ''
                                          ? "Update"
                                          : "Save", () {
                                    controller.saveUpdateUnit();
                                  }),
                                  controller.editUnitID.value == ''
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            4.widthBox,
                                            CustomUndoButtonRounded(onTap: () {
                                              controller.txt_Unit.text = '';
                                              controller.editUnitID.value = '';
                                            })
                                          ],
                                        ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.heightBox,
                  Expanded(
                    child: CustomGroupBox(
                        padingvertical: 8,
                        groupHeaderText: '',
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                    child: CustomSearchBox(
                                        caption: 'Search',
                                        width: 250,
                                        controller: controller.txt_Unit_search,
                                        onChange: (v) {}))
                              ],
                            ),
                            8.heightBox,
                            Expanded(
                              child: CustomTableGenerator(
                                  colWidtList: const [
                                    100,
                                    50,
                                    20
                                  ],
                                  childrenHeader: [
                                    CustomTableClumnHeader("Unit Name"),
                                    CustomTableClumnHeader("Status"),
                                    CustomTableEditCell(() {}, Icons.star)
                                  ],
                                  childrenTableRowList: controller
                                      .list_unit_temp
                                      .map((f) => TableRow(
                                              decoration: BoxDecoration(
                                                  color: controller.editUnitID
                                                              .value ==
                                                          f.id
                                                      ? appColorPista
                                                          .withOpacity(0.3)
                                                      : Colors.white),
                                              children: [
                                                CustomTableCell2(f.name),
                                                CustomTableCell2(
                                                    f.status == '1'
                                                        ? 'Active'
                                                        : 'Inactive',
                                                    true),
                                                CustomTableEditCell(() {
                                                  controller.editUnit(f);
                                                })
                                              ]))
                                      .toList()),
                            )
                          ],
                        )),
                  )

                  //_StoreTypeEnryPart(controller),
                  //_StoreTypeTablePart(controller)
                ]),
              ),
            ),
          ],
        ),
      ),
    );

_StoreTypePart(InvmsAttributeController controller) => Expanded(
      child: CustomGroupBox(
        padingvertical: 0,
        groupHeaderText:
            controller.isFullScreen.value ? 'Store Type Master' : '',
        child: Row(children: [
          Flexible(
            child: SizedBox(
              width: 700,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomGroupBox(
                  // bgColor: appColorGrayLight,
                  groupHeaderText: '',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _StoreTypeEnryPart(controller),
                        _StoreTypeTablePart(controller)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );

_StoreTypeTablePart(InvmsAttributeController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: CustomSearchBox(
                      // borderRadious: 12,
                      labelTextColor: kGrayColor,
                      isFilled: true,
                      width: 250,
                      caption: "Search Store Type",
                      controller: controller.txt_StoreTypeSearch,
                      onChange: (v) {
                        controller.searchStoreType();
                      }),
                ),
              ],
            ),
            8.heightBox,
            Table(
              columnWidths: customColumnWidthGenarator([130, 80, 20]),
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
                // for (var i = 0;
                //     i < controller.storeTypeList_temp.length;
                //     i++)
              ],
              border: CustomTableBorder(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                    border: CustomTableBorderNew,
                    columnWidths: customColumnWidthGenarator([130, 80, 20]),
                    children: controller.storeTypeList_temp
                        .map((f) => TableRow(
                                decoration: BoxDecoration(
                                  color:
                                      controller.editStoreTypeID.value != f.id
                                          ? Colors.white
                                          : Colors.amber.withOpacity(0.3),
                                ),
                                children: [
                                  CustomTableCell(f.name!),
                                  CustomTableCell(
                                      f.status == '1' ? "Active" : "Inactive"),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: InkWell(
                                        onTap: () {
                                          controller.editStoreTypeID.value =
                                              f.id!;
                                          controller.txt_StoreType.text =
                                              f.name!;
                                          controller.cmb_StoreTypeStatusId
                                              .value = f.status!;
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
                                ]))
                        .toList()),
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
          8.widthBox,
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
          8.widthBox,
          RoundedButton(() async {
            // print("object");
            controller.saveStoreType();
            //await controller.saveUpdateCategory();
          },
              controller.editStoreTypeID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          8.widthBox,
          RoundedButton(() {
            controller.editStoreTypeID.value = '';
            controller.txt_StoreType.text = '';
            controller.cmb_StoreTypeStatusId.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_groupPart(InvmsAttributeController controller) => Expanded(
      child: Row(
        children: [
          Flexible(
            child: CustomGroupBox(
              groupHeaderText:
                  controller.isFullScreen.value ? 'Item Group Master' : '',
              child: SizedBox(
                width: 800,
                child: Column(
                  children: [
                    _groupEnryPart(controller),
                    _groupTablePart(controller)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

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
                        value: element.id,
                        child: Text(
                          element.name!,
                          style: customTextStyle.copyWith(fontSize: 12),
                        )))
                    .toList(),
                onTap: (v) {
                  controller.cmb_StoreTypeId2.value = v.toString();
                },
                width: 90),
          ),
          8.widthBox,
          Expanded(
            flex: 5,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Category Name",
                controller: controller.txt_Group,
                onChange: (value) {}),
          ),
          8.widthBox,
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
          8.widthBox,
          RoundedButton(() async {
            // print("object");
            controller.saveGroup();
            //await controller.saveUpdateCategory();
          },
              controller.editGroupId.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          8.widthBox,
          RoundedButton(() {
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
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: CustomSearchBox(
                      caption: "Search Group",
                      maxlength: 100,
                      width: 250,
                      controller: TextEditingController(),
                      onChange: (v) {}),
                ),
              ],
            ),
            8.heightBox,
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

_subGroupPart(InvmsAttributeController controller) => Expanded(
      child: CustomGroupBox(
        groupHeaderText:
            controller.isFullScreen.value ? 'Item Sub Group Master' : '',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            _subGroupEnryPart(controller),
            _subGroupTablePart(controller),
          ]),
        ),
      ),
    );
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
          8.widthBox,
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
          8.widthBox,
          Expanded(
            flex: 5,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Item Sub Group Name",
                controller: controller.txt_SubGroup,
                onChange: (value) {}),
          ),
          8.widthBox,
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
          8.widthBox,
          RoundedButton(() async {
            // print("object");

            controller.saveSubGroup();
          },
              controller.editSubGroupID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          8.widthBox,
          RoundedButton(() {
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
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: CustomSearchBox(
                      caption: "Search Sub Group",
                      maxlength: 100,
                      width: 250,
                      controller: TextEditingController(),
                      onChange: (v) {}),
                ),
              ],
            ),
            8.heightBox,
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
