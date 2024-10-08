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
    bool b = true;
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
          if (b) {
            if (v == ToolMenuSet.show) {
              c.list_grn_master_view_temp.clear();
              c.txt_search_d.text = '';
              _showDialog(c);
            } else {
              c.toolEvent(v!);
            }
            b = false;
            Future.delayed(const Duration(seconds: 1), () {
              b = true;
            });
          }
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
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        12.widthBox,
                                        Flexible(
                                          child: CustomDropDown2(
                                              labeltext: 'Select Main Store',
                                              width: 200,
                                              id: controller.cmb_store_id.value,
                                              list: controller.list_main_store,
                                              onTap: (v) {}),
                                        ),
                                        12.widthBox,
                                        CustomDatePickerDropDown(
                                          label: 'Chalan Date',
                                          isBackDate: true,
                                          date_controller:
                                              controller.txt_chalan_date,
                                          width: 120,
                                        ),
                                        12.widthBox,
                                        CustomTextBox(
                                          caption: 'Chalan No',
                                          controller: controller.txt_chalan_no,
                                          width: 150,
                                          maxlength: 150,
                                        ),
                                      ],
                                    ),
                                    8.heightBox,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const CustomTextHeader(
                                                  text: "Note :         "),
                                              8.widthBox,
                                              Flexible(
                                                  child: CustomTextBox(
                                                caption: '',
                                                controller:
                                                    controller.txt_grn_note,
                                                width: 630,
                                                maxlength: 250,
                                                maxLine: 1,
                                                textInputType:
                                                    TextInputType.multiline,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
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
          c.cmb_store_id.value = '';
          c.show_po();
          c.load_main_Store();
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

void _showDialog(InvGrnCreateController controller) => CustomDialog(
    controller.context,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        'GRN. Reort',
        style: customTextStyle.copyWith(color: appColorMint),
      ),
    ),
    Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 800,
            height: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomGroupBox(
                        child: _dialodContentTop(
                            controller,
                            MyWidget().DropDown
                              ..width = 250
                              ..id = controller.cmb_store_type_id_d.value
                              ..list = controller.list_storeTypeList
                              ..onTap = (v) {
                                controller.cmb_store_type_id_d.value = v!;
                              },
                            MyWidget().DatePicker
                              ..width = 120
                              ..date_controller = controller.txt_fdate_d
                              ..label = 'From Date'
                              ..isBackDate = true
                              ..isShowCurrentDate = true,
                            MyWidget().DatePicker
                              ..width = 120
                              ..date_controller = controller.txt_tdate_d
                              ..label = 'To Date'
                              ..isBackDate = true
                              ..isShowCurrentDate = true,
                            MyWidget().IconButton
                              ..icon = Icons.search
                              ..text = 'Show'
                              ..onTap = () {
                                controller.view_grn();
                              }),
                      ),
                    ),
                  ],
                ),
                8.heightBox,
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Flexible(
                      child: CustomSearchBox(
                    controller: controller.txt_search_d,
                    width: 350,
                    caption: 'Search',
                    onChange: (value) {
                      controller.search_grn();
                    },
                  ))
                ]),
                8.heightBox,
                Expanded(
                    child: Obx(() => CustomTableGenerator(colWidtList: const [
                          30,
                          30,
                          60,
                          30,
                          30,
                          20
                        ], childrenHeader: [
                          MyWidget().TableColumnHeader..text = 'GRN. No',
                          MyWidget().TableColumnHeader..text = 'GRN. Date',
                          MyWidget().TableColumnHeader..text = 'Suppliers',
                          MyWidget().TableColumnHeader..text = 'Remarks',
                          MyWidget().TableColumnHeader..text = 'Status',
                          MyWidget().TableColumnHeader
                            ..text = '*'
                            ..alignment = Alignment.center,
                        ], childrenTableRowList: [
                          ...controller.list_grn_master_view_temp.map(
                            (f) => TableRow(
                                decoration: BoxDecoration(
                                    color: f.cur_status == 2
                                        ? appColorPista
                                        : f.cur_status == 0
                                            ? Colors.red.withOpacity(0.05)
                                            : Colors.white),
                                children: [
                                  MyWidget().TableCell..text = f.grnNo ?? '',
                                  MyWidget().TableCell..text = f.grnDate ?? '',
                                  MyWidget().TableCell..text = f.supName ?? '',
                                  MyWidget().TableCell..text = f.remarks ?? '',
                                  MyWidget().TableCell
                                    ..text = f.cur_status == 0
                                        ? 'Canceled'
                                        : f.cur_status == 2
                                            ? "Approved"
                                            : "App. Pending",
                                  CustomTableEditCell(() {
                                    controller.report(f.grnId!.toString());
                                  }, Icons.print_rounded, 16)
                                ]),
                          )
                        ])))
              ],
            ),
          ),
        ),
      ],
    ),
    () {},
    true,
    false);

Widget _dialodContentTop(InvGrnCreateController controller, Widget dropdowb,
        Widget dateF, Widget dateT, Widget button) =>
    controller.context.width < 650
        ? Column(
            children: [
              Row(
                children: [
                  Expanded(child: dropdowb),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  Expanded(child: dateF),
                  8.widthBox,
                  Expanded(child: dateT),
                ],
              ),
              8.widthBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [button],
              )
            ],
          )
        : Row(
            children: [
              dropdowb,
              8.widthBox,
              dateF,
              8.widthBox,
              dateT,
              12.widthBox,
              button
            ],
          );
