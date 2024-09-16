// ignore_for_file: public_member_api_docs, sort_constructors_first
 

import '../../../../core/config/const.dart';
import '../controller/inv_po_create_controller.dart';

class InvPOCreate extends StatelessWidget {
  const InvPOCreate({super.key});
  void disposeController() {
    try {
      Get.delete<InvPoCreateController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvPoCreateController controller = Get.put(InvPoCreateController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          Expanded(
              child: CustomTwoPanelGroupBox(
                  leftPanelWidth: 320,
                  leftChild: _leftPanel(controller),
                  rightChild: _rightPanel(controller),
                  minWidth: 1050))
        ],
        'Create Purchase Order::'));
  }
}

Widget _rightPanel(InvPoCreateController controller) => Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomGroupBox(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomTextInfo('PR. NO. ',
                            controller.selectedMrr.value.pr_no ?? ''),
                        12.widthBox,
                        CustomTextInfo('PR. Date ',
                            controller.selectedMrr.value.pr_date ?? ''),
                        12.widthBox,
                        CustomTextInfo('Priority ',
                            controller.selectedMrr.value.priority_name ?? ''),
                        12.widthBox,
                        CustomTextInfo('Remarks ',
                            controller.selectedMrr.value.remarks ?? '')
                      ],
                    ),
                  )),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CustomGroupBox(
                        // bgColor: Colors.white,
                        groupHeaderText: 'PO. Details',
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomDropDown2(
                                        labeltext: 'Supplier',
                                        width: 250,
                                        id: controller.cmb_supplierID.value,
                                        list: controller.list_supplier,
                                        onTap: (v) {
                                          controller.cmb_supplierID.value = v!;
                                        }),
                                    12.widthBox,
                                    CustomDatePickerDropDown(
                                        width: 130,
                                        label: 'PO. Date',
                                        date_controller:
                                            controller.txt_po_date),
                                    12.widthBox,
                                    CustomDatePickerDropDown(
                                        width: 130,
                                        label: 'Delivery Date',
                                        date_controller:
                                            controller.txt_delivery_date)
                                  ],
                                ),
                                8.heightBox,
                                Row(
                                  children: [
                                    CustomTextBox(
                                        textInputType: TextInputType.multiline,
                                        maxLine: 2,
                                        width: 250,
                                        height: 42,
                                        maxlength: 250,
                                        caption: 'Delivery Note',
                                        controller:
                                            controller.txt_delivery_note),
                                    12.widthBox,
                                    CustomTextBox(
                                        textInputType: TextInputType.multiline,
                                        maxLine: 2,
                                        width: 260 + 12,
                                        height: 42,
                                        maxlength: 250,
                                        caption: 'Remarks',
                                        controller: controller.txt_remarks)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )))
              ],
            ),
            Expanded(
                child: CustomGroupBox(
                    bgColor: Colors.white,
                    groupHeaderText: 'PR. Item List',
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomTableGenerator(colWidtList: const [
                            25,
                            60,
                             60 ,
                            50,
                            40,
                            40,
                            30,
                            30,
                            30,
                            20,
                            30,
                            25,
                            30
                          ], childrenHeader: [
                            CustomTableColumnHeaderBlack('Code'),
                            CustomTableColumnHeaderBlack('Item Name'),
                            CustomTableColumnHeaderBlack('Generic'),
                             
                                CustomTableColumnHeaderBlack('Company'),
                            CustomTableColumnHeaderBlack('Group'),
                            CustomTableColumnHeaderBlack('Sub. Group'),
                            CustomTableColumnHeaderBlack(
                                'Req.Qty', Alignment.centerRight),
                            CustomTableColumnHeaderBlack(
                                'App.Qty', Alignment.centerRight),
                            CustomTableColumnHeaderBlack(
                                'Rem.Qty', Alignment.centerRight),
                            CustomTableColumnHeaderBlack(
                                'Qty', Alignment.centerRight),
                            CustomTableColumnHeaderBlack(
                                'Rate', Alignment.centerRight),
                            CustomTableColumnHeaderBlack(
                                'Dis(%)', Alignment.centerRight),
                            CustomTableColumnHeaderBlack(
                                'Amount', Alignment.centerRight),
                          ], childrenTableRowList: []),
                        )
                      ],
                    )))
          ],
        ),
        Positioned(
            top: 2,
            right: 4,
            child: CustomUndoButtonRounded(
              onTap: () {
                controller.setUndo();
              },
              bgColor: Colors.transparent,
            ))
      ],
    );

Widget _leftPanel(InvPoCreateController controller) => Column(
      children: [
        12.heightBox,
        Row(
          children: [
            Expanded(
              child: CustomGroupBox(
                  padingvertical: 0,
                  groupHeaderText: '',
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Store Type',
                              id: controller.cmb_store_typeID.value,
                              list: controller.list_storeTypeList,
                              onTap: (v) {
                                controller.cmb_store_typeID.value = v!;
                                controller.show_pr();
                                // controller.setStore();
                              })),
                      12.widthBox,
                      CustomDropDown2(
                          labeltext: 'Year',
                          id: controller.cmb_yearID.value,
                          width: 120,
                          list: controller.list_year,
                          onTap: (v) {
                            controller.cmb_yearID.value = v!;
                            controller.show_pr();
                          })
                    ],
                  )),
            )
          ],
        ),
        8.heightBox,
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                      color: appColorGrayDark,
                      spreadRadius: 0.1,
                      blurRadius: 0.5)
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      6.heightBox,
                      ...controller.list_month.map((f) => tree_node(
                          8,
                          f.name!,
                          [
                            ...controller.list_pr_master
                                .where((e) => e.month_name == f.name)
                                .map(
                                  (a) => _tree_child(a.pr_no!,
                                      controller.selectedMrr.value.id == a.id,
                                      () {
                                    controller.setMRR(a);
                                  }),
                                )
                          ],
                          14))
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
        controller.context.width < 1050
            ? const SizedBox()
            : CustomGroupBox(
                bgColor: Colors.white,
                height: 280,
                child: CustomTableGenerator(
                    colWidtList: [
                      20,
                      80
                    ],
                    childrenHeader: [
                      CustomTableColumnHeaderBlack('Check', Alignment.center),
                      CustomTableColumnHeaderBlack('Terms & Condiition List')
                    ],
                    childrenTableRowList: controller.list_terms_master
                        .map((f) => TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Checkbox(
                                          value:
                                              f.isDefault == 1 ? true : false,
                                          onChanged: (v) {
                                            controller.setCheckCondition(
                                                v!, f.id.toString());
                                          })),
                                  CustomTableCellx(text: f.name ?? '')
                                ]))
                        .toList()))
      ],
    );

_tree_child(String text, bool isID, Function() fun) => Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 18),
      child: InkWell(
        onTap: () {
          fun();
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_ios,
              color: appColorGrayDark,
              size: isID ? 16 : 14,
            ),
            4.widthBox,
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: isID ? appGray100 : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            color: appColorGray200,
                            blurRadius: .05,
                            spreadRadius: .01)
                      ]),
                  child: Text(
                    text,
                    style: customTextStyle.copyWith(
                        fontSize: 11,
                        color: !isID ? appColorMint : Colors.black,
                        fontFamily: appFontLato),
                  )),
            ),
          ],
        ),
      ),
    );
