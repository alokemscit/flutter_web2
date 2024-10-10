import '../../../../core/config/const.dart';
import '../controller/fin_voucher_entry_controller.dart';
import '../widget/fin_voucher_widget.dart';

class FinVoucherEntry extends StatelessWidget implements MyInterface {
  const FinVoucherEntry({super.key});

  @override
  void disposeController() {
    mdisposeController<FinVoucherEntryController>();
  }

  @override
  Widget build(BuildContext context) {
    final FinVoucherEntryController c = Get.put(FinVoucherEntryController());
    c.context = context;

    return Obx(() => CommonBodyWithToolBar(
            c,
            [
              FinVoucherWidget().finVoucherWidget(
                  c, [Obx(() => _tablePart(c)), Obx(() => _total(c))])
            ],
            c.list_tool, (v) {
          c.toolevent(v);
        }));
  }
}

Widget _tableCellRight(String v, [Color cr = Colors.black]) => TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Container(
        decoration: BoxDecoration(
            color: kBgColorG,
            border: Border.all(color: Colors.black, width: 0.3)),
        child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                v,
                style: customTextStyle.copyWith(fontSize: 13, color: cr),
              ),
            ))));

Widget _total(FinVoucherEntryController c) => c.total.value.tot == null
    ? const SizedBox()
    : CustomTableGenerator(isBodyScrollable: false, colWidtList: const [
        50,
        40,
        20,
        40,
        40,
        40,
        48
      ], childrenHeader: [
        // const TableCell(child: SizedBox()),
        _tableCellRight("Debit"),
        _tableCellRight(c.total.value.dr!),
        _tableCellRight("Credit"),
        _tableCellRight(c.total.value.cr!),
        _tableCellRight("Balance (Dr-Cr)"),
        _tableCellRight(c.total.value.tot!),

        _tableCellRight(""),
      ], childrenTableRowList: const []);

Widget _tablePart(FinVoucherEntryController c) => Expanded(
      child: CustomGroupBox(
        child: CustomTableGenerator(
            colWidtList: const [
              15,
              60,
              40,
              40,
              40,
              40,
              40,
              8
            ],
            childrenHeader: [
              // CustomTableColumnHeaderBlack('#', Alignment.center),
              CustomTableColumnHeaderBlack('Dr/Cr'),
              CustomTableColumnHeaderBlack('Ledger'),
              CustomTableColumnHeaderBlack('Sub Ledger'),
              CustomTableColumnHeaderBlack('Cost Ceneter'),
              CustomTableColumnHeaderBlack('Checque'),
              CustomTableColumnHeaderBlack('Amount', Alignment.centerRight),
              CustomTableColumnHeaderBlack('Narration'),
              CustomTableColumnHeaderBlack('*', Alignment.center),
            ],
            childrenTableRowList: c.list_voucher_temp
                .map((f) => TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [
                          // CustomTableCellx(text: f.s!.toString()),
                          _tableCell(f.crdr!
                            ..onTextChenge = (v) {
                              f.crdr_id = '';
                              c.list_voucher_temp.refresh();
                            }
                            ..onSelected = (v) {
                              f.crdr!.controller.text = v.name ?? '';
                              f.crdr_id = v.id!;
                              f.sl_id = '';
                              f.cc_id = '';
                              f.ledger!.focusNode = FocusNode();
                              f.ledger!.controller =
                                  TextEditingController(text: '');
                              f.sl!.focusNode = FocusNode();
                              f.sl!.controller =
                                  TextEditingController(text: '');
                              f.cc!.focusNode = FocusNode();
                              f.cc!.controller =
                                  TextEditingController(text: '');

                              c.list_voucher_temp.refresh();

                              f.ledger!.focusNode.requestFocus();
                            }),
                          f.crdr_id == ''
                              ? CustomTableCellx(text: '')
                              : _tableCell(f.ledger!
                                ..onSelected = (v) {
                                  f.ledger_id = v.gLID!;
                                  f.ledger!.controller.text = v.gLNAME!;
                                  f.sl_id = '';
                                  f.cc_id = '';
                                  f.sl!.focusNode = FocusNode();
                                  f.sl!.controller =
                                      TextEditingController(text: '');
                                  f.cc!.focusNode = FocusNode();
                                  f.cc!.controller =
                                      TextEditingController(text: '');
                                  //  c.list_voucher_temp.refresh();
                                  c.list_voucher_temp.refresh();
                                  if (v.is_sl_required == 1) {
                                    f.sl!.focusNode.requestFocus();
                                    return;
                                  }
                                  if (v.is_cc_required == 1) {
                                    // f.cc!.focusNode = FocusNode();
                                    // f.cc!.controller = TextEditingController();
                                    f.cc!.focusNode.requestFocus();
                                    return;
                                  } else {
                                    if (double.parse(c.total.value.tot ?? '0') >
                                            0 &&
                                        f.crdr_id == '2') {
                                      f.amount!.text = c.total.value.tot ?? '';
                                      c.list_voucher_temp.refresh();
                                    } else if (double.parse(
                                                c.total.value.tot ?? '0') <
                                            0 &&
                                        f.crdr_id == '1') {
                                      f.amount!.text = (double.parse(
                                              c.total.value.tot ?? '0'))
                                          .abs()
                                          .toString();
                                     // c.list_voucher_temp.refresh();
                                     // c.calTotal();
                                    }

                                    f.amount_f!.requestFocus();
                                  }
                                }
                                ..onTextChenge = (v) {
                                  f.ledger_id = '';
                                  f.sl_id = '';
                                  f.cc_id = '';
                                  c.list_voucher_temp.refresh();
                                }),
                          f.ledger_id == ''
                              ? CustomTableCellx(text: '')
                              : _tableCell(f.sl!
                                ..onSelected = (v) {
                                  f.sl_id = v.id!.toString();
                                  f.sl!.controller.text = v.name ?? '';
                                  c.list_voucher_temp.refresh();
                                  //if (v.is_cc_required == 1) {

                                  f.cc!.focusNode.requestFocus();
                                  //  return;
                                  // } else {
                                  // f.amount_f!.requestFocus();
                                  // }
                                }
                                ..onTextChenge = (v) {
                                  f.sl_id = '';
                                  c.list_voucher_temp.refresh();
                                }),
                          f.ledger_id == ''
                              ? CustomTableCellx(text: '')
                              : _tableCell(f.cc!
                                ..onSelected = (v) {
                                  f.cc_id = v.id!.toString();
                                  f.cc!.controller.text = v.name ?? '';
                                  c.list_voucher_temp.refresh();
                                  f.amount_f!.requestFocus();
                                }
                                ..onTextChenge = (v) {
                                  f.cc_id = '';
                                  c.list_voucher_temp.refresh();
                                }),
                          CustomTableCellx(text: ''),
                          f.ledger_id == ''
                              ? CustomTableCellx(
                                  text: f.amount!.text,
                                  alignment: Alignment.centerRight,
                                )
                              : _tableCell(CustomTextBox(
                                  fontWeight: FontWeight.bold,
                                  textInputType: TextInputType.number,
                                  textAlign: TextAlign.end,
                                  controller: f.amount!,
                                  focusNode: f.amount_f,
                                  onSubmitted: (p0) {
                                    if (p0.isNotEmpty) {
                                      f.narration_f!.requestFocus();
                                      c.calTotal();
                                    }
                                  },
                                  onChange: (v) {
                                    c.calTotal();
                                  },
                                )),
                          _tableCell(CustomTextBox(
                            maxlength: 150,
                            controller: f.narration!,
                            focusNode: f.narration_f,
                            onSubmitted: (p0) {
                              if (f.crdr_id != '' && f.ledger_id != '') {
                                c.calTotal();
                                c.createNew();
                              }
                            },
                          )),
                          CustomTableEditCell(() {
                            c.delete(f);
                          }, Icons.delete, 14, Colors.red)
                        ]))
                .toList()),
      ),
    );

TableCell _tableCell(Widget child) =>
    TableCell(verticalAlignment: TableCellVerticalAlignment.fill, child: child);
