 
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
                      bgColor: appColorGray200,
                        padingvertical: 0,
                        groupHeaderText: '',
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomSearchBox(
                                    caption: 'item Search',
                                    width: 250,
                                    controller: controller.txt_search_name,
                                    onChange: (v) {}),
                                8.widthBox,
                                CustomTextBox(
                                    caption: 'Qty',
                                    width: 80,
                                    textInputType: TextInputType.number,
                                    controller: controller.txt_search_qty,
                                    onChange: (v) {}),8.widthBox,
                                    Flexible(
                                      child: CustomTextBox(
                                      caption: 'Narration',
                                      width: 250,
                                      maxlength: 250,
                                      textInputType: TextInputType.text,
                                      controller: controller.txt_search_qty,
                                      onChange: (v) {}),
                                    ),
                                    8.widthBox,
                                    CustomUndoButtonRounded(onTap: (){},icon: Icons.add,)


                              ],
                            ),
                            4.heightBox,
                            Expanded(
                                child: CustomTableGenerator(colWidtList: const [
                              30,
                              100,
                              40,
                              80,
                              80,
                              80
                            ], childrenHeader: [
                              CustomTableCellTableBody('Code'),
                              CustomTableCellTableBody('Item Name'),
                              CustomTableCellTableBody('Unit'),
                              CustomTableCellTableBody('Group'),
                              CustomTableCellTableBody('Sub Group'),
                              CustomTableCellTableBody('Generic'),
                            ], childrenTableRowList: []))
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
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic))
                            ],
                          ),
                        )
                      ],
                    ),
              4.heightBox,
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
                  child: CustomTableGenerator(colWidtList: const [
                    30,
                    100,
                    30,
                    80,
                    80,
                    80,
                    80,
                    30,
                    20
                  ], childrenHeader: [
                    CustomTableClumnHeader('Code'),
                    CustomTableClumnHeader('Item Name'),
                    CustomTableClumnHeader('Unit'),
                    CustomTableClumnHeader('Group'),
                    CustomTableClumnHeader('Sub Group'),
                    CustomTableClumnHeader('Generic'),
                    CustomTableClumnHeader('Company'),
                    CustomTableClumnHeader('Req. Qty'),
                    CustomTableClumnHeader('*', Alignment.center),
                  ], childrenTableRowList: []),
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
                        CustomSaveUpdateButtonWithUndo(true, () {}, () {
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
                            isBackDate: true,
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
                      // 10.heightBox,
                      // Row(
                      //   children: [

                      //     10.widthBox,
                      //   ],
                      // ),
                      // 10.heightBox,
                      // Row(
                      //   children: [
                      //     Expanded(
                      //         child: CustomTextBox(
                      //             caption: 'Note',
                      //             height: 50,
                      //             maxLine: null,
                      //             maxlength: 250,
                      //             textInputType: TextInputType.multiline,
                      //             controller: controller.txt_note,
                      //             onChange: (v) {})),
                      //   ],
                      // ),
                      // 8.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [

                      //   ],
                      // )
                    ],
                  ),
                )),
          )),
        ],
      );
}
