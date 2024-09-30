import 'package:web_2/modules/Inventory/shared/inv_shared_widget.dart';

import '../../../../core/config/const.dart';
import '../controller/inv_grn_create_controller.dart';

class InvGrnCreate extends StatelessWidget implements MyInterface {
  const InvGrnCreate({super.key});
  @override
  void disposeController() {
    mdisposeController<InvGrnCreateController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvGrnCreateController c = Get.put(InvGrnCreateController());
    c.context = context;
    return Obx(() => CommonBodyWithToolBar(
            c,
            [
              Expanded(
                  child: CustomTwoPanelGroupBox(
                leftPanelWidth: 320,
                leftChild: _leftpanel(c),
                rightChild: _rightPanel(c),
              )),
            ],
            c.list_tool, (v) {
          c.toolEvent(v!);
        }));
  }
}

Widget _rightPanel(InvGrnCreateController controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.selectedMrr.value.id == null
            ? const SizedBox()
            : Row(
                children: [
                  Expanded(
                    child: CustomGroupBox(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomTextInfo('PO. NO. ',
                                      controller.selectedMrr.value.poNo ?? ''),
                                  12.widthBox,
                                  CustomTextInfo(
                                      'PO. Date ',
                                      controller.selectedMrr.value.poDate ??
                                          ''),
                                  12.widthBox,
                                  CustomTextInfo(
                                      'Delivery Date ',
                                      controller
                                              .selectedMrr.value.deliveryDate ??
                                          ''),
                                  12.widthBox,
                                  CustomTextInfo(
                                      'Remarks ',
                                      controller.selectedMrr.value.remarks ??
                                          ''),
                                  12.widthBox,
                                  CustomTextInfo(
                                      'Delivery Note ',
                                      controller
                                              .selectedMrr.value.deliveryNote ??
                                          '')
                                ],
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomTextInfo(
                                      'Supplier ',
                                      controller.selectedMrr.value.subName ??
                                          ''),
                                  12.widthBox,
                                  CustomTextInfo(
                                      'Delivery Note ',
                                      controller
                                              .selectedMrr.value.deliveryNote ??
                                          ''),
                                  12.widthBox,
                                  CustomTextInfo(
                                      'Remarks ',
                                      controller.selectedMrr.value.remarks ??
                                          ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: CustomGroupBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CustomTextHeader(
                                            text: "GRN. Date :"),
                                        8.widthBox,
                                        CustomDatePickerDropDown(
                                          date_controller:
                                              controller.txt_grn_date,
                                          width: 120,
                                          label: '',
                                        ),
                                      ],
                                    ),
                                    12.widthBox,
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const CustomTextHeader(
                                              text: "Note :"),
                                          8.widthBox,
                                          Flexible(
                                              child: CustomTextBox(
                                            caption: '',
                                            controller: controller.txt_grn_note,
                                            width: 600,
                                            maxlength: 250,
                                            maxLine: 1,
                                            textInputType:
                                                TextInputType.multiline,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                  )
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
                        40,
                        30,
                        30,
                        30,
                        30,
                        30,
                        35,
                        35,
                        50,
                        40,
                        45,
                        15
                      ], childrenHeader: [
                        CustomTableColumnHeaderBlack('Code'),
                        CustomTableColumnHeaderBlack('Item Name'),
                        CustomTableColumnHeaderBlack('Type', Alignment.center),
                        CustomTableColumnHeaderBlack('Unit', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'PO.Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'App. Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Rem. Qty', Alignment.center),
                        CustomTableColumnHeaderBlack('Rate', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Dis(%)', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'GRN. Qty', Alignment.center),
                        CustomTableColumnHeaderBlack('Batch/SL No'),
                        CustomTableColumnHeaderBlack('Expiry date'),
                        CustomTableColumnHeaderBlack(
                            'Amount', Alignment.centerRight),
                        CustomTableColumnHeaderBlack('*', Alignment.center),
                      ], childrenTableRowList: [
                        ...controller.list_po_item_tems.map((f) => TableRow(
                                decoration: BoxDecoration(
                                    color: f.isFree == 1
                                        ? appColorPista.withOpacity(0.5)
                                        : f.remQty! < 1
                                            ? Colors.red.withOpacity(0.05)
                                            : kBgColorG),
                                children: [
                                  CustomTableCellx(
                                    text: f.code ?? '',
                                    isTextTuncate: true,
                                  ),
                                  CustomTableCellx(
                                    text: f.name ?? '',
                                    isTextTuncate: true,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCellx(
                                    text: f.type ?? '',
                                    isTextTuncate: true,
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.unit ?? '',
                                    isTextTuncate: true,
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.poQty!.toString(),
                                    isTextTuncate: true,
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.appQty.toString(),
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.remQty.toString(),
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.rate!.toStringAsFixed(2),
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.disc!.toStringAsFixed(2),
                                    alignment: Alignment.center,
                                  ),
                                  InvEditText(
                                    f.qty!,
                                    f.qty_f!,
                                    10,
                                    () {
                                      controller.key_change(f);
                                    },
                                    () {
                                      if (f.qty!.text != '') {
                                        FocusScope.of(controller.context)
                                            .requestFocus(f.batc_f);
                                      }
                                    },
                                  ),
                                  InvEditText(f.batch!, f.batc_f!, 100, () {},
                                      () {
                                    FocusScope.of(controller.context)
                                        .requestFocus(f.expdate_f);
                                  }, false, TextAlign.start,
                                      TextInputType.text),
                                  InvEditText(f.expdate!, f.expdate_f!, 10, () {
                                    // controller.key_change(f, true);
                                  }, () {
                                    if (f.expdate!.text.length == 10) {
                                      controller.next_line_qty(f);
                                    }
                                    // FocusScope.of(controller.context)
                                    //     .requestFocus(f.rate_f);
                                  }, false, TextAlign.start,
                                      TextInputType.datetime),
                                  CustomTableCellx(
                                    fontSize: 12.5,
                                    text: f.amt!.toStringAsFixed(3),
                                    alignment: Alignment.centerRight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableEditCell(() {
                                    controller.removeTempItem(f);
                                  }, Icons.delete, 16, Colors.red)
                                ]))
                      ]),
                    ),
                    double.parse(controller.grand_total.value == ''
                                ? '0'
                                : controller.grand_total.value) ==
                            0
                        ? const SizedBox()
                        : Table(
                            columnWidths:
                                customColumnWidthGenarator([410, 45, 10]),
                            children: [
                              TableRow(children: [
                                InvFooterCell('Grand Total '),
                                InvFooterCell(
                                    controller.grand_total.value, true),
                                InvFooterCell('')
                              ])
                            ],
                          )
                  ],
                ))),
      ],
    );
Widget _leftpanel(InvGrnCreateController c) => InvleftPanelWithTree(
    CustomDropDown2(
        id: c.cmb_store_typeID.value,
        list: c.list_storeTypeList,
        onTap: (v) {
          c.cmb_store_typeID.value = v!;
          c.show_po();
        }),
    CustomDropDown2(
        id: c.cmb_yearID.value,
        list: c.list_year,
        onTap: (v) {
          c.cmb_yearID.value = v!;
          c.show_po();
        }),
    c.list_month
        .map((f) => tree_node(
            8,
            f.name!,
            [
              ...c.list_po_master.where((e) => e.monthName == f.name).map(
                    (a) => InvTree_child(
                        a.poNo ?? '', c.selectedMrr.value.id == a.id, () {
                      c.setMRR(a);
                    }),
                  )
            ],
            14))
        .toList(),
    CustomTableGenerator(
        colWidtList: const [
          20,
          90
        ],
        childrenHeader: [
          CustomTableColumnHeaderBlack('Check', Alignment.center),
          CustomTableColumnHeaderBlack('Terms & Condiition List')
        ],
        childrenTableRowList: c.list_terms_master
            .map((f) => TableRow(
                    decoration: const BoxDecoration(color: Colors.white),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Checkbox(
                              value: f.isDefault == 1 ? true : false,
                              onChanged: (v) {
                                // c.setCheckCondition(
                                //     v!, f.id.toString());
                              })),
                      CustomTableCellx(
                        text: f.name ?? '',
                        fontSize: 11,
                      )
                    ]))
            .toList()),
    c.context.width);
