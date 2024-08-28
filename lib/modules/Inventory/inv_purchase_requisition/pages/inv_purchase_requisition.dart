import 'package:web_2/core/config/properties.dart';

import '../../../../core/config/const.dart';
import '../controller/inv_purchase_requisition_controller.dart';

class InvPurchaseRequisition extends StatelessWidget {
  const InvPurchaseRequisition({super.key});
  void disposeController() {
    try {
      Get.delete<InvPurchaseRequisitionController>();
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvPurchaseRequisitionController controller =
        Get.put(InvPurchaseRequisitionController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [_header(controller), 8.heightBox, _entryPart(controller)],
        'Purchase Requisition'));
  }

  Widget _searchPanel(InvPurchaseRequisitionController controller) => Stack(
        children: [
          SizedBox(
            height: 250,
            child: Row(
              children: [
                Expanded(
                    child: CustomGroupBox(
                        bgColor: Colors.white,
                        borderWidth: 4,
                        ShadowColor: appColorGrayDark,
                        padingvertical: 0,
                        groupHeaderText: 'Search Item',
                        child: Column(
                          children: [
                            Row(
                              children: [
                                RawKeyboardListener(
                                  onKey: controller.handleKeyPress_search,
                                  focusNode: controller.focusnode_search_down,
                                  child: CustomSearchBox(
                                    focusNode: controller.focusnode_search,
                                    caption: 'item Search',
                                    width: 250,
                                    controller: controller.txt_search_name,
                                    onChange: (v) {
                                      controller.search();
                                    },
                                    onSubmitted: (p0) {
                                      // print('object');
                                      controller.searchKeyEnter();
                                    },
                                    onEditingComplete: () {
                                      //print('object');
                                    },
                                    onTap: () {
                                      // print('onTap');
                                    },
                                  ),
                                ),
                                8.widthBox,
                                CustomTextBox(
                                  focusNode: controller.focusnode_qty,
                                  caption: 'Qty',
                                  width: 80,
                                  textInputType: TextInputType.number,
                                  controller: controller.txt_search_qty,
                                  onChange: (v) {},
                                  onSubmitted: (p0) {
                                    controller.qtyKeyEnter();
                                  },
                                ),
                                8.widthBox,
                                Flexible(
                                  child: CustomTextBox(
                                    focusNode: controller.focusnode_note,
                                    caption: 'Remarks',
                                    width: 250,
                                    maxlength: 250,
                                    textInputType: TextInputType.text,
                                    controller: controller.txt_search_note,
                                    onChange: (v) {},
                                    onSubmitted: (p0) {
                                      controller.remKeyEnter();
                                    },
                                  ),
                                ),
                                8.widthBox,
                                CustomUndoButtonRounded(
                                  onTap: () {
                                    controller.remKeyEnter();
                                  },
                                  icon: Icons.add,
                                )
                              ],
                            ),
                            4.heightBox,
                            Expanded(
                                child: CustomTableGenerator(
                                    colWidtList: const [
                                  30,
                                  100,
                                  40,
                                  80,
                                  80,
                                  80,
                                  30
                                ],
                                    childrenHeader: [
                                  CustomTableCellTableBody('Code'),
                                  CustomTableCellTableBody('Item Name'),
                                  CustomTableCellTableBody('Unit'),
                                  CustomTableCellTableBody('Group'),
                                  CustomTableCellTableBody('Sub Group'),
                                  CustomTableCellTableBody('Generic'),
                                  CustomTableCellTableBody('*', 12,
                                      FontWeight.w300, Alignment.center),
                                ],
                                    childrenTableRowList: controller
                                        .list_item_temp
                                        .map((f) => TableRow(
                                                decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedItem
                                                                .value
                                                                .id ==
                                                            f.id
                                                        ? appColorPista
                                                        : Colors.white),
                                                children: [
                                                  CustomTableCellTableBody(
                                                      f.code!),
                                                  CustomTableCellTableBody(
                                                      f.name!,12,FontWeight.w600),
                                                  CustomTableCellTableBody(
                                                      f.unitName!),
                                                  CustomTableCellTableBody(
                                                      f.grpName!),
                                                  CustomTableCellTableBody(
                                                      f.sgrpName!),
                                                  CustomTableCellTableBody(
                                                      f.genName!),
                                                  CustomTableEditCell(() {
                                                    controller.add(f);
                                                  }, Icons.add, 18)
                                                ]))
                                        .toList()))
                          ],
                        )))
              ],
            ),
          ),
          Positioned(
              top: 6,
              right: 0,
              child: CustomCloseButtonRounded(onTap: () {
                controller.isShowSearch.value = false;
              }))
        ],
      );

  Widget _entryPart(InvPurchaseRequisitionController controller) => Expanded(
      child: CustomGroupBox(
          //  bgColor: Colors.amber,
          padingvertical: 0,
          groupHeaderText: 'Item List',
          child: Column(
            children: [
              controller.isShowSearch.value
                  ? _searchPanel(controller)
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.showSearchContainer();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.playlist_add_outlined,
                                size: 22,
                                color: appColorLogoDeep,
                              ),
                              Text('Add New Item',
                                  style: customTextStyle.copyWith(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic))
                            ],
                          ),
                        ),
                       controller.list_temp.isEmpty?const SizedBox():  Padding(
                         padding: const EdgeInsets.only(right: 4),
                         child: InkWell(
                          onTap: () {
                            
                          },
                          onHover: (value) {
                            if(value){

                            }
                          },
                           child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               const Icon(Icons.print_sharp,color: appColorBlue,size: 18,),Text('Print Priview',style: customTextStyle.copyWith(fontSize: 9,fontWeight: FontWeight.w500, color: appColorMint, ),),
                             ],
                           ),
                         ),
                       )
                      ],
                    ),
              6.heightBox,
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: appColorGrayDark,
                            blurRadius: .3,
                            spreadRadius: 0)
                      ]),
                  child: CustomTableGenerator(
                      colWidtList: const [
                        30,
                        100,
                        30,
                        80,
                        80,
                        80,
                        80,
                        30,
                        50,
                        28
                      ],
                      childrenHeader: [
                        CustomTableClumnHeader('Code'),
                        CustomTableClumnHeader('Item Name'),
                        CustomTableClumnHeader('Unit'),
                        CustomTableClumnHeader('Group'),
                        CustomTableClumnHeader('Sub Group'),
                        CustomTableClumnHeader('Generic'),
                        CustomTableClumnHeader('Company'),
                        CustomTableClumnHeader('Req. Qty', Alignment.center),
                        CustomTableClumnHeader('Remarks'),
                        CustomTableClumnHeader('*', Alignment.center),
                      ],
                      childrenTableRowList: controller.list_temp
                          .map((f) => TableRow(children: [
                                CustomTableCellTableBody(f.code!),
                                CustomTableCellTableBody(f.name!, 12,
                                    FontWeight.bold,),
                                CustomTableCellTableBody(f.unit!),
                                CustomTableCellTableBody(f.group!),
                                CustomTableCellTableBody(f.subgroup!),
                                CustomTableCellTableBody(f.Generic!),
                                CustomTableCellTableBody(f.company!),
                                CustomTableCellTableBody(f.qty!, 12,
                                    FontWeight.bold, Alignment.center),
                                CustomTableCellTableBody(f.rem!),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              child: InkWell(
                                                  onTap: () {
                                                    controller.minus(f);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 20,
                                                    color: appColorLogoDeep,
                                                  ))),
                                          const Flexible(
                                              child: SizedBox(
                                            width: 22,
                                          )),
                                          Flexible(
                                            child: InkWell(
                                                onTap: () {
                                                  controller.delete(f);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Colors.red,
                                                )),
                                          )
                                        ],
                                      ),
                                    ))
                              ]))
                          .toList()),
                ),
              ),
              CustomGroupBox(
                  padingvertical: 0,
                  groupHeaderText: '',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: CustomTextBox(
                              caption: 'Note',
                              height: null,
                              width: 300,
                              maxLine: null,
                              maxlength: 250,
                              textInputType: TextInputType.multiline,
                              controller: controller.txt_note,
                              onChange: (v) {}),
                        ),
                        8.widthBox,
                        CustomSaveUpdateButtonWithUndo(true, () {
                          controller.save();
                        }, () {
                          controller.setStoreType('');
                        }, true)
                      ],
                    ),
                  )),
              4.heightBox
            ],
          )));

  Widget _header(InvPurchaseRequisitionController controller) => Row(
        children: [
          Flexible(
              child: SizedBox(
            width: 460,
            child: CustomGroupBox(
                padingvertical: 0,
                groupHeaderText: 'Requisition Entry',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CustomDropDown2(
                                labeltext: 'Store Type',
                                width: 180,
                                id: controller.cmb_storetypeID.value,
                                list: controller.list_storeTypeList,
                                onTap: (v) {
                                  controller.setStoreType(v!);
                                }),
                          ),
                          10.widthBox,
                          CustomDatePickerDropDown(
                            label: 'Requisition Date',
                            date_controller: controller.txt_date,
                            width: 120,
                            isBackDate: false,
                            isShowCurrentDate: true,
                          ),
                          10.widthBox,
                          CustomDropDown2(
                              labeltext: 'Priority',
                              width: 120,
                              id: controller.cmb_priorityID.value,
                              list: controller.list_priority,
                              onTap: (v) {
                                controller.cmb_priorityID.value = v!;
                              }),
                        ],
                      ),
                    ],
                  ),
                )),
          )),
        ],
      );
}
