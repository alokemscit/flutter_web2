import '../../../../core/config/const.dart';
import '../../shared/inv_shared_widget.dart';
import '../controller/inv_po_approval_controller.dart';

class InvPoApproval extends StatelessWidget implements MyInterface {
  const InvPoApproval({super.key});
  @override
  void disposeController() {
    mdisposeController<InvPoApprovalController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvPoApprovalController c = Get.put(InvPoApprovalController());
    c.context = context;
    bool b = true;
    return Obx(() => CommonBodyWithToolBar(
            c,
            [
              Expanded(
                  child: CustomTwoPanelGroupBox(
                leftPanelWidth: 320,
                leftChild: _left_panel(c),
                rightChild: _rightPanel(c),
                minWidth: 1050,
              ))
            ],
            c.list_menu, (v) {
          if (b) {
            if (v == ToolMenuSet.show) {
              _showDialog(c);
            } else {
              c.toolBarEvent(v!);
            }
            b = false;
            Future.delayed(const Duration(seconds: 1), () {
              b = true;
            });
          }
        }));
  }
}

Widget _rightPanel(InvPoApprovalController controller) => Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomGroupBox(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomTextInfo(
                        'PO. NO. ', controller.selectedMrr.value.poNo ?? ''),
                    12.widthBox,
                    CustomTextInfo(
                        'PR. Date ', controller.selectedMrr.value.poDate ?? ''),
                    12.widthBox,
                    CustomTextInfo('Delivery Date ',
                        controller.selectedMrr.value.deliveryDate ?? ''),
                    12.widthBox,
                    CustomTextInfo(
                        'Remarks ', controller.selectedMrr.value.remarks ?? ''),
                    12.widthBox,
                    CustomTextInfo('Delivery Note ',
                        controller.selectedMrr.value.deliveryNote ?? '')
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
                                CustomTextBox(
                                    width: 130,
                                    caption: 'PO. Date',
                                    fontWeight: FontWeight.bold,
                                    isDisable: true,
                                    isReadonly: true,
                                    controller: controller.txt_po_date),
                                // CustomDatePickerDropDown(
                                //     width: 130,
                                //     label: 'PO. Date',
                                //     date_controller: controller.txt_po_date),
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
                                    controller: controller.txt_delivery_note),
                                12.widthBox,
                                CustomTextBox(
                                    textInputType: TextInputType.multiline,
                                    maxLine: 2,
                                    width: 260 + 12,
                                    height: 42,
                                    maxlength: 250,
                                    caption: 'Remarks',
                                    controller: controller.txt_remarks),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )))
          ],
        ),
        //  _freeItemPanel(controller),
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
                        50,
                        40,
                        40,
                        30,
                        30,
                        35,
                        25,
                        45,
                      ], childrenHeader: [
                        CustomTableColumnHeaderBlack('Code'),
                        CustomTableColumnHeaderBlack('Item Name'),
                        CustomTableColumnHeaderBlack('Generic'),
                        // CustomTableColumnHeaderBlack('Company'),
                        CustomTableColumnHeaderBlack('Group'),
                        CustomTableColumnHeaderBlack(
                            'Sub. Group', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'PO.Qty', Alignment.center),
                        // CustomTableColumnHeaderBlack(
                        //     'App.Qty', Alignment.center),
                        // CustomTableColumnHeaderBlack(
                        //     'Rem.Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'App. Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Rate', Alignment.centerRight),
                        CustomTableColumnHeaderBlack(
                            'Dis(%)', Alignment.centerRight),
                        CustomTableColumnHeaderBlack(
                            'Amount', Alignment.centerRight),
                        // CustomTableColumnHeaderBlack('*', Alignment.center),
                      ], childrenTableRowList: [
                        ...controller.list_po_item_tems.map((f) => TableRow(
                                decoration: BoxDecoration(
                                    color: f.isFree!
                                        ? appColorPista.withOpacity(0.5)
                                        : f.remQty! < 1
                                            ? Colors.red.withOpacity(0.05)
                                            : kBgColorG),
                                children: [
                                  CustomTableCellx(
                                    text: f.code!,
                                    isTextTuncate: true,
                                  ),
                                  CustomTableCellx(
                                    text: f.itemName!,
                                    isTextTuncate: true,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCellx(
                                      text: f.genericName!,
                                      isTextTuncate: true),
                                  // CustomTableCellx(
                                  //   text: f.comName!,
                                  //   isTextTuncate: true,
                                  // ),
                                  CustomTableCellx(
                                      text: f.groupName!, isTextTuncate: true),
                                  CustomTableCellx(
                                    text: f.subgroupName!,
                                    isTextTuncate: true,
                                    alignment: Alignment.center,
                                  ),
                                  CustomTableCellx(
                                    text: f.reqQty.toString(),
                                    alignment: Alignment.center,
                                  ),

                                  InvEditText(
                                    f.qty!,
                                    f.qty_f!,
                                    10,
                                    () {
                                      controller.key_change(f, true);
                                    },
                                    () {
                                      controller.next_line_qty(f);
                                      // FocusScope.of(controller.context)
                                      //     .requestFocus(f.rate_f);
                                    },
                                  ),

                                  // InvEditText(f.rate!, f.rate_f!, 15, () {
                                  //  // controller.key_change(f);
                                  // }, () {
                                  //   FocusScope.of(controller.context)
                                  //       .requestFocus(f.disc_f);
                                  // },
                                  //     (f.isFree! || f.remQty! < 1)
                                  //         ? true
                                  //         : false),

                                  CustomTableCellx(
                                    text: double.parse(f.rate!.text == ''
                                            ? '0'
                                            : f.rate!.text)
                                        .toStringAsFixed(2),
                                    alignment: Alignment.centerRight,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  // InvEditText(f.disc!, f.disc_f!, 5, () {
                                  //  // controller.key_change(f);
                                  // }, () {
                                  //  // controller.next_line_qty(f);
                                  // },
                                  //     (f.isFree! || f.remQty! < 1)
                                  //         ? true
                                  //         : false),
                                  CustomTableCellx(
                                    text: double.parse(f.disc!.text == ''
                                            ? '0'
                                            : f.disc!.text)
                                        .toStringAsFixed(2),
                                    alignment: Alignment.centerRight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCellx(
                                    fontSize: 12.5,
                                    text: f.amt!.toStringAsFixed(3),
                                    alignment: Alignment.centerRight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // CustomTableEditCell(() {
                                  //   //controller.removeTempItem(f);
                                  // }, Icons.delete, 16, Colors.red)
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

Widget _left_panel(InvPoApprovalController controller) => InvleftPanelWithTree(
      CustomDropDown2(
          labeltext: 'Store Type',
          id: controller.cmb_store_typeID.value,
          list: controller.list_storeTypeList,
          onTap: (v) {
            controller.cmb_store_typeID.value = v!;
            controller.show_po();
            //controller.setStore();
          }),
      CustomDropDown2(
          labeltext: 'Year',
          id: controller.cmb_yearID.value,
          width: 120,
          list: controller.list_year,
          onTap: (v) {
            controller.cmb_yearID.value = v!;
            controller.show_po();
          }),
      controller.list_month
          .map((f) => tree_node(
              8,
              f.name!,
              [
                ...controller.list_po_master
                    .where((e) => e.monthName == f.name)
                    .map(
                      (a) => InvTree_child(
                          a.poNo ?? '', controller.selectedMrr.value.id == a.id,
                          () {
                        controller.setMRR(a);
                      }),
                    )
              ],
              14))
          .toList(),
      CustomTableGenerator(
          colWidtList: const [
            20,
            80
          ],
          childrenHeader: [
            CustomTableColumnHeaderBlack('Check', Alignment.center),
            CustomTableColumnHeaderBlack('Terms & Condiition List')
          ],
          childrenTableRowList: controller.list_terms_master
              .map((f) => TableRow(
                      decoration: const BoxDecoration(color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Checkbox(
                                value: f.isDefault == 1 ? true : false,
                                onChanged: (v) {
                                  controller.setCheckCondition(
                                      v!, f.id.toString());
                                })),
                        CustomTableCellx(text: f.name ?? '')
                      ]))
              .toList()),
    );

void _showDialog(InvPoApprovalController controller) => CustomDialog(
    controller.context,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        'PO. Reort',
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
                              ..id = controller.cmb_store_type_search.value
                              ..list = controller.list_storeTypeList
                              ..onTap = (v) {
                                controller.cmb_store_type_search.value = v!;
                              },
                            MyWidget().DatePicker
                              ..width = 120
                              ..date_controller = controller.txt_search_fdate
                              ..label = 'From Date'
                              ..isBackDate = true
                              ..isShowCurrentDate = true,
                            MyWidget().DatePicker
                              ..width = 120
                              ..date_controller = controller.txt_search_tdate
                              ..label = 'To Date'
                              ..isBackDate = true
                              ..isShowCurrentDate = true,
                            MyWidget().IconButton
                              ..icon = Icons.search
                              ..text = 'Show'
                              ..onTap = () {
                                controller.showPoStatus();
                              }),
                      ),
                    ),
                  ],
                ),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyWidget().SearchBox
                      ..width = 250
                      ..controller = TextEditingController()
                      ..onChange = (v) {},
                  ],
                ),
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
                          MyWidget().TableColumnHeader..text = 'PO. No',
                          MyWidget().TableColumnHeader..text = 'PO. Date',
                          MyWidget().TableColumnHeader..text = 'Suppliers',
                          MyWidget().TableColumnHeader..text = 'Delivery Date',
                          MyWidget().TableColumnHeader..text = 'Status',
                          MyWidget().TableColumnHeader
                            ..text = '*'
                            ..alignment = Alignment.center,
                        ], childrenTableRowList: [
                          ...controller.list_po_stattus_temp.map(
                            (f) => TableRow(
                                decoration: BoxDecoration(
                                    color: f.currentStatus == 2
                                        ? appColorPista
                                        : f.currentStatus == 0
                                            ? Colors.red.withOpacity(0.05)
                                            : Colors.white),
                                children: [
                                  MyWidget().TableCell..text = f.poNo ?? '',
                                  MyWidget().TableCell..text = f.poDate ?? '',
                                  MyWidget().TableCell..text = f.subName ?? '',
                                  MyWidget().TableCell
                                    ..text = f.deliveryDate ?? '',
                                  MyWidget().TableCell
                                    ..text = f.currentStatus == 0
                                        ? 'Canceled'
                                        : f.currentStatus == 2
                                            ? "Approved"
                                            : "App. Pending",
                                  CustomTableEditCell(() {
                                    controller
                                        .show_po_report(f.poId!.toString());
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
Widget _dialodContentTop(InvPoApprovalController controller, Widget dropdowb,
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