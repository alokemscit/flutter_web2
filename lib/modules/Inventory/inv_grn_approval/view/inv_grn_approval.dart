import 'package:web_2/core/config/const.dart';

import '../../shared/inv_shared_widget.dart';
import '../controller/inv_grn_approval_controller.dart';

class InvGrnApproval extends StatelessWidget implements MyInterface {
  const InvGrnApproval({super.key});
  @override
  void disposeController() {
    mdisposeController<InvGrnApprovalController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvGrnApprovalController c = Get.put(InvGrnApprovalController());
    c.context = context;
    bool b = true;
    return Obx(() => CommonBodyWithToolBar(
            c,
            [
              Expanded(
                  child: CustomTwoPanelGroupBox(
                leftChild: _leftpanel(c),
                rightChild: _rightPanel(c),
                leftPanelWidth: 320,
              )),
            ],
            c.list_tool, (v) {
          if (b) {
            c.toolbarEvent(v);
            b = false;
            Future.delayed(const Duration(seconds: 1), () {
              b = true;
            });
          }
        }));
  }
}

Widget _rightPanel(InvGrnApprovalController c) => Column(
      children: [
        c.selectedGRM.value.grnNo == null
            ? const SizedBox()
            : Column(
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
                                  'GRN. NO. ', c.selectedGRM.value.grnNo ?? ''),
                              12.widthBox,
                              CustomTextInfo('GRN. Date ',
                                  c.selectedGRM.value.grnDate ?? ''),
                              12.widthBox,
                              CustomTextInfo('Delivery Date ',
                                  c.selectedGRM.value.delivery_date ?? ''),
                              12.widthBox,
                              CustomTextInfo('Delivery Note ',
                                  c.selectedGRM.value.delivery_note ?? ''),
                              12.widthBox,
                              CustomTextInfo('Chalan Date ',
                                  c.selectedGRM.value.chalanDate ?? ''),
                              12.widthBox,
                              CustomTextInfo('Chalan No ',
                                  c.selectedGRM.value.chalanNo ?? ''),
                              12.widthBox,
                              CustomTextInfo('Supplier Name ',
                                  c.selectedGRM.value.supName ?? '')
                            ],
                          ),
                        )),
                      )
                    ],
                  ),
                  // 8.heightBox,
                  Row(
                    children: [
                      Expanded(
                          child: CustomGroupBox(
                              child: CustomTextHeaderWithCaptinAndWidget(
                        caption: 'Remarks',
                        child: Flexible(
                            child: CustomTextBox(
                          controller: c.txt_remarks,
                          width: 450,
                        )),
                      )))
                    ],
                  ),
                ],
              ),
        _tablePart(c),
        _grandTotal(c),
      ],
    );

Widget _grandTotal(InvGrnApprovalController c) =>
    double.parse(c.grn_total.value == '' ? '0' : c.grn_total.value) == 0
        ? const SizedBox()
        : Table(
            columnWidths: customColumnWidthGenarator([260, 40]),
            children: [
              TableRow(children: [
                InvFooterCell('Grand Total '),
                InvFooterCell(c.grn_total.value, true),
                // InvFooterCell('')
              ])
            ],
          );

Widget _tablePart(InvGrnApprovalController c) => Expanded(
        child: CustomGroupBox(
            child: CustomTableGenerator(colWidtList: const [
      20,
      50,
      25,
      20,
      25,
      25,
      25,
      30,
      30,
      40
    ], childrenHeader: [
      CustomTableColumnHeaderBlack('Code'),
      CustomTableColumnHeaderBlack('Name'),
      CustomTableColumnHeaderBlack('Type', Alignment.center),
      CustomTableColumnHeaderBlack('Unit', Alignment.center),
      CustomTableColumnHeaderBlack('PO.Qty', Alignment.center),
      CustomTableColumnHeaderBlack('Rem.Qty', Alignment.center),
      CustomTableColumnHeaderBlack('GRN. Qty', Alignment.center),
      CustomTableColumnHeaderBlack('Rate', Alignment.centerRight),
      CustomTableColumnHeaderBlack('Disc(%)', Alignment.center),
      CustomTableColumnHeaderBlack('Total', Alignment.centerRight),
      // CustomTableColumnHeaderBlack('*',Alignment.center),
    ], childrenTableRowList: [
      ...c.list_grn_details_view.map((f) => TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: [
                CustomTableCellx(text: f.code ?? '', isTextTuncate: true),
                CustomTableCellx(text: f.itemName ?? '', isTextTuncate: true),
                CustomTableCellx(
                    text: f.subgroupName ?? '',
                    isTextTuncate: true,
                    alignment: Alignment.center),
                CustomTableCellx(
                  text: f.unitName ?? '',
                  isTextTuncate: true,
                  alignment: Alignment.center,
                ),
                CustomTableCellx(
                    text: (f.po_app_qty ?? 0).toString(),
                    alignment: Alignment.center),
                CustomTableCellx(
                    text: (f.rem_qty ?? 0).toString(),
                    alignment: Alignment.center),
                CustomTableCellx(
                    text: (f.qty ?? 0).toString(), alignment: Alignment.center),
                CustomTableCellx(
                    text: (f.price ?? 0).toStringAsFixed(2),
                    alignment: Alignment.centerRight),
                CustomTableCellx(
                    text: (f.disc ?? 0).toStringAsFixed(2),
                    alignment: Alignment.center),
                CustomTableCellx(
                    text: (f.tot ?? 0).toStringAsFixed(2),
                    alignment: Alignment.centerRight),
                // CustomTableEditCell((){},Icons.delete,14,Colors.red)
              ])),
    ])));

Widget _leftpanel(InvGrnApprovalController c) => InvleftPanelWithTree(
      CustomDropDown2(
          id: c.cmb_store_typeID.value,
          list: c.list_storeTypeList,
          onTap: (v) {
            c.cmb_store_typeID.value = v!;
            c.setGRN();
          }),
      CustomDropDown2(
          id: c.cmb_yearID.value,
          list: c.list_year,
          onTap: (v) {
            c.cmb_yearID.value = v!;
            c.setGRN();
          }),
      [
        ...c.list_month.map((f) => tree_node(8, f.name ?? '', [
              ...c.list_grn_for_app.where((e) => e.grnMonth == f.name!).map(
                  (f) => InvTree_child(
                          f.grnNo ?? '', c.selectedGRM.value.grnId == f.grnId,
                          () {
                        c.getGrnDetails(f);
                      }))
            ])),
      ],
      null,
      c.context.width,
    );
