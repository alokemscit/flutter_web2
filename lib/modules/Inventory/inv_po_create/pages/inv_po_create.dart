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
                                        controller: controller.txt_remarks),
                                    controller.list_pr_item_tems.isEmpty
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              12.widthBox,
                                              CustomButton(Icons.save, 'Save',
                                                  () {
                                                controller.save();
                                              })
                                            ],
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )))
              ],
            ),
            _freeItemPanel(controller),
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
                            40,
                            30,
                            30,
                            30,
                            30,
                            35,
                            25,
                            45,
                            10
                          ], childrenHeader: [
                            CustomTableColumnHeaderBlack('Code'),
                            CustomTableColumnHeaderBlack('Item Name'),
                            CustomTableColumnHeaderBlack('Generic'),
                            CustomTableColumnHeaderBlack('Company'),
                            CustomTableColumnHeaderBlack('Group'),
                            CustomTableColumnHeaderBlack(
                                'Sub. Group', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'Req.Qty', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'App.Qty', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'Rem.Qty', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'Qty', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'Rate', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'Dis(%)', Alignment.center),
                            CustomTableColumnHeaderBlack(
                                'Amount', Alignment.centerRight),
                            CustomTableColumnHeaderBlack('*', Alignment.center),
                          ], childrenTableRowList: [
                            ...controller.list_pr_item_tems.map((f) => TableRow(
                                    decoration: BoxDecoration(
                                        color: f.isFree!
                                            ? appColorPista.withOpacity(0.5)
                                            : kBgColorG),
                                    children: [
                                      CustomTableCellx(text: f.code! ,isTextTuncate: true,),
                                      CustomTableCellx(
                                        text: f.itemName!,
                                        isTextTuncate: true,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomTableCellx(
                                          text: f.genericName!,
                                          isTextTuncate: true),
                                      CustomTableCellx(
                                        text: f.comName!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableCellx(
                                          text: f.groupName!,
                                          isTextTuncate: true),
                                      CustomTableCellx(
                                        text: f.subgroupName!,
                                        isTextTuncate: true,
                                        alignment: Alignment.center,
                                      ),
                                      CustomTableCellx(
                                        text: f.reqQty.toString(),
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
                                      _editText(
                                        f.qty!,
                                        f.qty_f!,
                                        10,
                                        () {
                                          controller.key_change(f, true);
                                        },
                                        () {
                                          FocusScope.of(controller.context)
                                              .requestFocus(f.rate_f);
                                        },
                                      ),
                                      _editText(f.rate!, f.rate_f!, 15, () {
                                        controller.key_change(f);
                                      }, () {
                                        FocusScope.of(controller.context)
                                            .requestFocus(f.disc_f);
                                      }, f.isFree! ? true : false),
                                      _editText(f.disc!, f.disc_f!, 5, () {
                                        controller.key_change(f);
                                      }, () {
                                        controller.next_line_qty(f);
                                      }, f.isFree! ? true : false),
                                      CustomTableCellx(
                                        text: f.amt!.toStringAsFixed(3),
                                        alignment: Alignment.centerRight,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomTableEditCell(
                                          () {}, Icons.delete, 16, Colors.red)
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
                                    _footerCell('Grand Total '),
                                    _footerCell(
                                        controller.grand_total.value, true),
                                    _footerCell('')
                                  ])
                                ],
                              )
                      ],
                    ))),
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

Widget _freeItemPanel(InvPoCreateController controller) => Column(
      children: [
        controller.list_terms_master.isEmpty || controller.isShowfree.value
            ? const SizedBox()
            : Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.addFreeItemShow();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: appColorMint,
                        ),
                        Text(
                          'Add Free Item',
                          style: customTextStyle.copyWith(color: appColorMint),
                        )
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
        !controller.isShowfree.value
            ? const SizedBox()
            : Stack(
                children: [
                  SizedBox(
                    height: 250,
                    child: CustomGroupBox(
                        child: Column(
                      children: [
                        4.heightBox,
                        Row(
                          children: [
                            Flexible(
                                child: CustomTextBox(
                              borderRadious: 4,
                              enabledBorderwidth: 1,
                              focusedBorderWidth: 1,
                              caption: 'Search Item',
                              width: 450,
                              controller: controller.txt_search,
                              onChange: (v) {
                                controller.search();
                              },
                            )),
                          ],
                        ),
                        4.heightBox,
                        Expanded(
                          child: CustomTableGenerator(colWidtList: const [
                            25,
                            60,
                            20,
                            40,
                            40,
                            40,
                            50,
                            20
                          ], childrenHeader: [
                            CustomTableColumnHeaderBlack('Code'),
                            CustomTableColumnHeaderBlack('Name'),
                            CustomTableColumnHeaderBlack(
                                'Unit', Alignment.center),
                            CustomTableColumnHeaderBlack('Generic'),
                            CustomTableColumnHeaderBlack('Group'),
                            CustomTableColumnHeaderBlack('Sub.Group'),
                            CustomTableColumnHeaderBlack('Company'),
                            CustomTableColumnHeaderBlack('*', Alignment.center),
                          ], childrenTableRowList: [
                            ...controller.list_item_temp.map((f) => TableRow(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    children: [
                                      CustomTableCellx(
                                        onTap: () {
                                          controller.addFreeItem(f);
                                        },
                                        text: f.code!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableCellx(
                                        onTap: () {
                                          controller.addFreeItem(f);
                                        },
                                        text: f.name!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableCellx(
                                        text: f.unitName!,
                                        isTextTuncate: true,
                                        alignment: Alignment.center,
                                      ),
                                      CustomTableCellx(
                                        text: f.genName!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableCellx(
                                        text: f.grpName!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableCellx(
                                        text: f.sgrpName!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableCellx(
                                        text: f.conName!,
                                        isTextTuncate: true,
                                      ),
                                      CustomTableEditCell(() {
                                        controller.addFreeItem(f);
                                      }, Icons.add, 16, appColorMint)
                                    ])),
                          ]),
                        )
                      ],
                    )),
                  ),
                  Positioned(
                      top: 8,
                      right: 6,
                      child: CustomUndoButtonRounded(onTap: () {
                        controller.isShowfree.value = false;
                      }))
                ],
              ),
      ],
    );

Widget _footerCell(String text, [bool isBorder = false]) => TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        decoration: isBorder
            ? const BoxDecoration(
                border: Border(
                    top: BorderSide(color: appColorGrayDark, width: 0.8)))
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: Text(
              text,
              style: customTextStyle.copyWith(
                  color: appColorMint,
                  fontFamily: appFontOpenSans,
                  fontSize: 12),
            ))
          ],
        ),
      ),
    );

Widget _editText(TextEditingController cnt, FocusNode focusnode,
    [int maxlength = 15,
    Function()? fun,
    Function()? submit,
    bool isReadOnly = false]) {
  focusnode.addListener(() {
    if (focusnode.hasFocus) {
      cnt.selection = TextSelection(
        baseOffset: 0,
        extentOffset: cnt.text.length,
      );
    }
  });
  return TableCell(
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                onChange: (v) {
                  if (fun != null) {
                    fun();
                  }
                },
                onSubmitted: (p0) {
                  if (submit != null) {
                    submit();
                  }
                },
                // onEditingComplete: () {
                //   if (fun != null) {
                //     fun();
                //   }
                // },
                isDisable: isReadOnly,
                isReadonly: isReadOnly,
                fontColor: appColorMint,
                fontWeight: FontWeight.bold,
                fillColor: Colors.white,
                isFilled: true,
                focusNode: focusnode,
                textAlign: TextAlign.center,
                maxlength: maxlength,
                textInputType: TextInputType.number,
                caption: '',
                controller: cnt),
          ),
        ],
      ));
}

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
