import '../../../../core/config/const.dart';
import '../controller/inv_item_master_controller.dart';

class InvItemMaster extends StatelessWidget {
  const InvItemMaster({super.key});
  void disposeController() {
    try {
      Get.delete<InvItemMasterController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvItemMasterController controller =
        Get.put(InvItemMasterController());
    controller.context = context;
    return Obx(() => CommonBody3(
          controller,
          [Expanded(child: _mainWindow(controller))],
          'Item Master::',
        ));
  }
}

Widget _mainWindow(InvItemMasterController controller) =>
    controller.context.width > 1300
        ? Row(
            children: [
              _header(controller),
              8.widthBox,
              _tableView(controller),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(controller),
              8.heightBox,
              _tableView(controller)
            ],
          );

Widget _tableView(InvItemMasterController controller) => Expanded(
      child: CustomGroupBox(
          // bgColor: Colors.white,
          padingvertical: 0,
          groupHeaderText: 'List of Company',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: CustomSearchBox(
                          caption: 'Company Search',
                          width: 450,
                          controller: controller.txt_search,
                          onChange: (v) {
                            controller.search();
                          })),
                  controller.list_item_temp.isNotEmpty
                      ? Row(
                          children: [
                            8.widthBox,
                            InkWell(
                                onTap: () {
                                  controller.print();
                                },
                                child: const Icon(
                                  Icons.local_print_shop_rounded,
                                  size: 24,
                                  color: appColorLogoDeep,
                                ))
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              8.heightBox,
              Expanded(
                child: CustomTableGenerator(
                    colWidtList: const [
                      40,
                      120,
                      50,
                      80,
                      80,
                      80,
                      60,
                      20
                    ],
                    childrenHeader: [
                      CustomTableClumnHeader("Code"),
                      CustomTableClumnHeader("Item Name"),
                      CustomTableClumnHeader("Unit"),
                      CustomTableClumnHeader("Group"),
                      CustomTableClumnHeader("Subgroup"),
                      CustomTableClumnHeader("Generic"),
                      CustomTableClumnHeader("Store Type"),
                      CustomTableClumnHeader("*", Alignment.center),
                    ],
                    childrenTableRowList: controller.list_item_temp
                        .map((f) => TableRow(
                                decoration: BoxDecoration(
                                    color: controller.editItemID.value == f.id
                                        ? Colors.amber.withOpacity(0.1)
                                        : Colors.white),
                                children: [
                                  //CustomTableClumnHeader(f.code!),
                                  CustomTableCellTableBody(f.code!),
                                  CustomTableCellTableBody(f.name!),
                                  CustomTableCellTableBody(f.unitName!),
                                  CustomTableCellTableBody(f.grpName!),
                                  CustomTableCellTableBody(f.sgrpName!),
                                  CustomTableCellTableBody(f.genName!),
                                  CustomTableCellTableBody(f.stypeName!),
                                  CustomTableEditCell(() {
                                    controller.setEdit(f);
                                  })
                                ]))
                        .toList()),
              )
            ],
          )),
    );

Widget _header(InvItemMasterController controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 450,
          child: CustomGroupBox(
              // bgColor: Colors.white,
              padingvertical: 4,
              groupHeaderText: 'Item Master',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomDropDown2(
                            labeltext: 'Store Type',
                            id: controller.cmb_storetypeID.value,
                            width: 250,
                            list: controller.list_storeTypeList,
                            onTap: (v) {
                              //controller.cmb_storetypeID.value = v!;
                              controller.setStoreType(v!);
                            })
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown2(
                                labeltext: 'Company',
                                id: controller.cmb_companyID.value,
                                width: 400,
                                list: controller.list_company_temp,
                                onTap: (v) {
                                  controller.cmb_companyID.value = v!;
                                }))
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown2(
                                labeltext: 'Group',
                                id: controller.cmb_groupID.value,
                                width: 400,
                                list: controller.list_group_temp,
                                onTap: (v) {
                                  controller.setGroup(v!);
                                }))
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown2(
                                labeltext: 'Sub Group',
                                id: controller.cmb_subGroupID.value,
                                width: 400,
                                list: controller.list_subGroup_temp,
                                onTap: (v) {
                                  controller.cmb_subGroupID.value = v!;
                                }))
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        CustomTextBox(
                            isDisable: true,
                            caption: 'Code',
                            width: 80,
                            controller: controller.txt_code,
                            onChange: (v) {}),
                        8.widthBox,
                        Flexible(
                            child: CustomTextBox(
                                caption: 'Item Name',
                                width: 312,
                                controller: controller.txt_name,
                                onChange: (v) {}))
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown2(
                                labeltext: 'Generic Name',
                                id: controller.cmb_generic.value,
                                width: 400,
                                list: controller.list_generic_temp,
                                onTap: (v) {
                                  controller.cmb_generic.value = v!;
                                }))
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown2(
                                labeltext: 'Unit',
                                id: controller.cmb_unitID.value,
                                width: 250,
                                list: controller.list_storeUnit_temp,
                                onTap: (v) {
                                  controller.cmb_unitID.value = v!;
                                }))
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomSaveUpdateButtonWithUndo(
                            controller.editItemID.value != '', () {
                          controller.saveUpdateItem();
                        }, () {
                          controller.setUndo();
                        }),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ],
    );
