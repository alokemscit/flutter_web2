import 'package:web_2/core/config/const.dart';

import '../../shared/inv_shared_widget.dart';
import '../controller/inv_item_issue_to_store_controller.dart';

class InvStoreItemIssue extends StatelessWidget implements MyInterface {
  const InvStoreItemIssue({super.key});
  @override
  void disposeController() {
    mdisposeController<InvStoreItemIssueController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvStoreItemIssueController c =
        Get.put(InvStoreItemIssueController());
    c.context = context;
    return Obx(() => CommonBodyWithToolBar1(c, [
          Expanded(
              child: CustomTwoPanelGroupBox(
            leftPanelWidth: 320,
            leftChild: _leftpanel(c),
            rightChild: _rightPanel(c),
          )),
        ], (v) {
          c.toolEvent(v!);
        }));
  }
}

Widget _rightPanel(InvStoreItemIssueController c) => Column(
      children: [
        c.list_req_details.isEmpty
            ? const SizedBox()
            : Row(
                children: [
                  Expanded(
                      child: CustomGroupBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _text("Req. No",
                                      c.list_req_details.first.reqNo ?? ''),
                                  _text('Req. Date',
                                      c.list_req_details.first.reqDqte ?? ''),
                                  _text('From Store',
                                      c.list_req_details.first.storeName ?? ''),
                                  _text(
                                      'Priority',
                                      c.list_req_details.first.priorityName ??
                                          ''),
                                  c.list_req_details.first.remarks == ''
                                      ? const SizedBox()
                                      : _text(
                                          'Remarks',
                                          c.list_req_details.first.remarks ??
                                              ''),
                                ],
                              )))),
                ],
              ),
        Expanded(
            child: c.list_temp.isEmpty
                ? const SizedBox()
                : CustomGroupBox(
                    child: CustomTableGenerator(
                        colWidtList: const [
                        20,
                        50,
                        30,
                        25,
                        20,
                        20,
                        20,
                        25,
                        8
                      ],
                        childrenHeader: [
                        CustomTableColumnHeaderBlack('Code'),
                        CustomTableColumnHeaderBlack('Name'),
                        CustomTableColumnHeaderBlack('Type', Alignment.center),
                        CustomTableColumnHeaderBlack('Unit', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Available', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'App.Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Pending.Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Issue.Qty', Alignment.center),
                        CustomTableColumnHeaderBlack('*', Alignment.center),
                      ],
                        childrenTableRowList: c.list_temp
                            .map((f) => TableRow(
                                    decoration: BoxDecoration(
                                        color: (f.stock_qty ?? '0') == '0'
                                            ? Colors.red.withOpacity(0.1)
                                            : kBgColorG.withOpacity(0.5)),
                                    children: [
                                      CustomTableCellx(text: f.code ?? ''),
                                      CustomTableCellx(
                                        text: f.name ?? '',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomTableCellx(
                                        text: f.type ?? '',
                                        alignment: Alignment.center,
                                      ),
                                      CustomTableCellx(
                                        text: f.unit ?? '',
                                        alignment: Alignment.center,
                                      ),
                                      CustomTableCellx(
                                        text: f.stock_qty ?? '',
                                        alignment: Alignment.center,
                                      ),
                                      CustomTableCellx(
                                        text: f.app_qty ?? '',
                                        alignment: Alignment.center,
                                      ),
                                      CustomTableCellx(
                                        text: f.pending_qty ?? '',
                                        alignment: Alignment.center,
                                      ),
                                      InvEditText(
                                          f.qty!, f.focusnode!, 15, () {}, () {
                                        //subbmit
                                      }, (f.stock_qty ?? '0') == '0'),
                                      CustomTableEditCell(() {
                                        c.remove(f);
                                      }, Icons.delete, 14, Colors.red)
                                    ]))
                            .toList())))
      ],
    );

_text(String caption, String text) => CustomTextHeaderWithCaptinAndChild(
      bgColor: kBgColorG.withOpacity(0.8),
      caption: caption,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 16),
        child: Text(
          text,
          style: customTextStyle.copyWith(fontSize: 12, color: appColorMint),
        ),
      ),
    );

Widget _leftpanel(InvStoreItemIssueController c) => InvleftPanelWithTree(
    CustomDropDown2(
        id: c.cmb_store_typeID.value,
        list: c.list_store_type,
        onTap: (v) {
          c.cmb_store_typeID.value = v!;
          c.loadData();
        }),
    CustomDropDown2(
        id: c.cmb_yearID.value,
        list: c.list_year,
        onTap: (v) {
          c.cmb_yearID.value = v!;
          c.loadData();
        }),
    c.list_month
        .map((f) => Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: tree_node(
                  2,
                  f.mname ?? '',
                  c.list_mn
                      .where((e) => e.mid == f.mid)
                      .map((a) => tree_node(
                          16,
                          a.storeName ?? '',
                          c.list_req_tree
                              .where((b) =>
                                  b.mid == f.mid && b.store_id == a.storeId)
                              .map((k) => _textNode(k.reqNo ?? '',
                                      c.selectedRequisition.value.id == k.id,
                                      () {
                                    c.setSelect(k);
                                  }))
                              .toList(),
                          13,
                          false,
                          true,
                          1,
                          2))
                      .toList(),
                  14),
            ))
        .toList(),
    null);

Widget _textNode(String text, bool isSelected, Function() fun) => InkWell(
      onTap: () {
        fun();
        // c.setSelect(k);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 22, top: 3, bottom: 2),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: isSelected ? appColorRowSelected : Colors.white),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_right,
                      size: 16,
                    ),
                    4.widthBox,
                    Flexible(
                        child: Text(
                      text,
                      style: customTextStyle.copyWith(
                          fontSize: 12.5, color: appColorMint),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
