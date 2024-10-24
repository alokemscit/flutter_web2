// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:web_2/component/custom_pdf_report_generator.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/finance/fin_voucher/widget/fin_voucher_widget.dart';

import '../../cost_center_master/model/model_costcenter_master.dart';
import '../../fin_shared/fin_function.dart';
import '../../ledger_master_page/model/model_chart_acc_master.dart';
import '../../sub_ledger_master/model/fiin_model_subledger_master.dart';
import '../model/fin_model_voucher_date_range.dart';
import '../model/fin_model_voucher_details.dart';
import '../model/fin_model_voucher_type.dart';

class FinVoucherEntryController extends GetxController with MixInController {
  var isShowRightMenuBar = true.obs;
  var list_acc_type = <ModelCommonMaster>[].obs;
  var list_voucher_type = <FinModelVoucherType>[].obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedVoucherType = FinModelVoucherType().obs;
  final TextEditingController txt_voucher_date = TextEditingController();
  final TextEditingController txt_voucher_narration = TextEditingController();

  final TextEditingController txt_vs_fdate = TextEditingController();
  final TextEditingController txt_vs_tdate = TextEditingController();
  final TextEditingController txt_vs_search = TextEditingController();
  var cmb_vs_v_typeID = ''.obs;

  var list_voucher_temp = <_v>[].obs;
  var list_ledger = <ModelChartAccMaster>[].obs;
  var list_cc = <FinModelCostCenter>[].obs;
  var list_sl = <FinModelSubLedgerMaster>[].obs;
  var total = _tot().obs;
  var list_voucher_details = <FinModelVoucherDetails>[].obs;
  var list_voucher_with_date_range_master = <FinModelVoucherDateRange>[].obs;

  var list_voucher_with_date_range = <FinModelVoucherDateRange>[].obs;

  void search() {
    list_voucher_with_date_range
      ..clear()
      ..addAll(list_voucher_with_date_range_master.where((f) =>
          f.vno!.toUpperCase().contains(txt_vs_search.text.toUpperCase()) ||
          f.vdate!.toUpperCase().contains(txt_vs_search.text.toUpperCase()) ||
          f.vtName!.toUpperCase().contains(txt_vs_search.text.toUpperCase()) ||
          f.amt!
              .toString()
              .toUpperCase()
              .contains(txt_vs_search.text.toUpperCase())));
  }

  void show_voucher_with_date_range() async {
    list_voucher_with_date_range.clear();
    list_voucher_with_date_range_master.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      loader.show();
      await mLoadModel_All(
          api,
          [
            {
              "tag": "10",
              "cid": user.value.cid,
              "vtype": cmb_vs_v_typeID.value,
              "fdate": txt_vs_fdate.text,
              "tdate": txt_vs_tdate.text
            }
          ],
          list_voucher_with_date_range_master,
          (x) => FinModelVoucherDateRange.fromJson(x),
          'fin');
      list_voucher_with_date_range.addAll(list_voucher_with_date_range_master);
      loader.close();
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(double.parse((total.value.tot ?? '0').toString()) != 0,
        dialog, 'Debit and Credit Amount should be same!')) return;

    if (isCheckCondition(double.parse((total.value.dr ?? '0').toString()) == 0,
        dialog, 'No Voucher Particulars found to save voucher !')) return;

    List<Map<String, dynamic>> list = [];
    bool b = true;
    bool b1 = true;
    list_voucher_temp.forEach((f) {
      if (f.ledger_id == '') {
        b = false;
        return;
      }
      if (f.amount!.text == '') {
        b1 = false;
        return;
      }
      list.add({
        "acc_id": f.crdr_id,
        "gl_id": f.ledger_id,
        "sl_id": f.sl_id,
        "cc_id": f.cc_id,
        "amt": f.amount!.text,
        "rem": f.narration!.text
      });
    });
    if (!b) {
      dialog
        ..dialogType = DialogType.error
        ..message = 'Missing to select ledger for some row!'
        ..show();
      return;
    }
    if (!b1) {
      dialog
        ..dialogType = DialogType.error
        ..message = 'Missing to enter ledger amount for some row!'
        ..show();
      return;
    }
    if (isCheckCondition(
        list.isEmpty, dialog, 'No Voucher Particulars found to save voucher !'))
      return;

    //@cid int,@eid int,@vdate varchar(10),@vtype int,@rem nvarchar(250),
//@str_voucher varchar(max),@str_checque varchar(max)
    try {
      ModelStatus s = await commonSaveUpdate_all(
          api,
          loader,
          dialog,
          [
            {
              "tag": "8",
              "cid": user.value.cid,
              "eid": user.value.uid,
              "vdate": txt_voucher_date.text,
              "vtype": selectedVoucherType.value.id,
              "rem": txt_voucher_narration.text,
              "str_voucher": jsonEncode(list),
              "str_checque": ''
            }
          ],
          'fin');
      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () {
            loader.show();
            showReport(s.id!, () {
              loader.close();
            });
          };
      }
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void showReport(String vid, Function()? fun) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      await mLoadModel_All(
          api,
          [
            {"tag": "9", "vid": vid}
          ],
          list_voucher_details,
          (x) => FinModelVoucherDetails.fromJson(x));
      CustomPDFGenerator(
          font: font,
          header: [],
          footer: [],
          body: [],
          fun: () {
            if (fun != null) fun();
          }).ShowReport();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  Future<List<_v>> get_list(List<_v> l) async {
    List<_v> list = [];
    l.forEach((e) {
      list.add(_v(
          crdr_id: e.crdr_id,
          crdr: _widget().drcr(this, FocusNode(),
              TextEditingController(text: e.crdr!.controller.text)),
          ledger_id: e.ledger_id,
          ledger: _widget().ledger(this, FocusNode(),
              TextEditingController(text: e.ledger!.controller.text)),
          sl: _widget().sl_ledger(this, FocusNode(),
              TextEditingController(text: e.sl!.controller.text)),
          sl_id: e.sl_id,
          cc_id: e.cc_id,
          cc: _widget().cost_center(
            this,
            FocusNode(),
            TextEditingController(text: e.cc!.controller.text),
          ),
          amount: e.amount,
          amount_f: e.amount_f,
          narration: e.narration,
          narration_f: e.narration_f,
          cq: [],
          s: e.s));
    });
    return list;
  }

  void delete(_v f) async {
    list_voucher_temp.removeWhere((e) => e.s == f.s);
    list_voucher_temp.removeWhere((e) => e.crdr_id == '' || e.ledger_id == '');
    await get_list(list_voucher_temp);

    calTotal();
  }

  void calTotal() {
    total.value = _tot();
    if (list_voucher_temp.isEmpty) {
      total.value = _tot();
      total.refresh();
      return;
    } else {
      double dr = list_voucher_temp.where((e) => e.crdr_id == '1').fold(0.0,
          (previousValue, element) {
        return previousValue +
            double.parse(element.amount!.text.isEmpty
                ? '0'
                : element.amount!
                    .text); // Example: summing a field from each element
      });
      var cr = list_voucher_temp.where((e) => e.crdr_id == '2').fold(0.0,
          (previousValue, element) {
        return previousValue +
            double.parse(element.amount!.text.isEmpty
                ? '0'
                : element.amount!
                    .text); // Example: summing a field from each element
      });
      var tot = (dr - cr);
      if (tot != 0 || dr != 0 || cr != 0) {
        total.value = _tot(
            cr: cr.toStringAsFixed(2),
            dr: dr.toStringAsFixed(2),
            tot: tot.toStringAsFixed(2));
        total.refresh();
      }
    }
  }

  void createNew() {
    list_voucher_temp.add(_v(
        crdr_id: '',
        crdr: _widget().drcr(this, FocusNode(), TextEditingController()),
        ledger_id: '',
        ledger: _widget().ledger(this, FocusNode(), TextEditingController()),
        sl: _widget().sl_ledger(this, FocusNode(), TextEditingController()),
        sl_id: '',
        cc_id: '',
        cc: _widget().cost_center(
          this,
          FocusNode(),
          TextEditingController(),
        ),
        amount: TextEditingController(text: ''),
        amount_f: FocusNode(),
        narration: TextEditingController(),
        narration_f: FocusNode(),
        cq: [],
        s: const Uuid().v1()));
    list_voucher_temp.last.crdr!.focusNode.requestFocus();
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    font = await CustomLoadFont(appFontPathOpenSans);
    //list_tool.addAll(Custom_Tool_List());

    try {
      await Fin_Get_Acc_Type(api, list_acc_type);
      await Fin_Get_Voucher_Type(api, list_voucher_type);
      await Fin_Get_Chart_of_acc(api, list_ledger, user.value.cid!);
      await Fin_Get_Cost_center(api, list_cc, user.value.cid!);
      await Fin_Get_sub_ledger(api, list_sl, user.value.cid!);

      mToolEnableDisable(list_tools, [
        ToolMenuSet.show
      ], [
        ToolMenuSet.undo,
        ToolMenuSet.save,
        ToolMenuSet.update,
        ToolMenuSet.file
      ]);
    } catch (e) {
      CustomInitError(this, e.toString());
    } finally {
      isLoading.value = false; // Ensure loading state is false after completion
    }

    super.onInit();
  }

  void setNew() {
    mToolEnableDisable(list_tools, [ToolMenuSet.save, ToolMenuSet.undo], []);
    txt_voucher_narration.text = '';
    list_voucher_temp.clear();
    createNew();
  }

  void setUndo() {
    mToolEnableDisable(list_tools, [], [ToolMenuSet.save, ToolMenuSet.undo]);
    selectedVoucherType.value = FinModelVoucherType();
    list_voucher_temp.clear();
  }

  bool b = true;
  void toolevent(ToolMenuSet? v) async {
    if (b) {
      b = false;
      if (v == ToolMenuSet.file) {
        setNew();
      }
      if (v == ToolMenuSet.undo) {
        setUndo();
      }
      if (v == ToolMenuSet.save) {
        save();
      }
      if (v == ToolMenuSet.show) {
        list_voucher_with_date_range.clear();
        list_voucher_with_date_range_master.clear();
        txt_vs_search.text = '';
        FinVoucherWidget().voucher_showDialog(this);
      }
      Future.delayed(const Duration(milliseconds: 400), () {
        b = true; // Re-enable events after the delay
      });
    }
  }

  @override
  void onClose() {
    // Dispose TextEditingControllers to avoid memory leaks
    txt_voucher_date.dispose();
    txt_voucher_narration.dispose();
    txt_vs_fdate.dispose();
    txt_vs_tdate.dispose();
    txt_vs_search.dispose();
    list_voucher_temp.clear();
    // Dispose any other resources here if needed
    // Example: If you have listeners or streams, close them here.

    super.onClose();
  }
}

class _widget {
  CustomSearchableDropdown drcr(
    FinVoucherEntryController c,
    FocusNode f,
    TextEditingController ct,
  ) =>
      CustomSearchableDropdown<ModelCommonMaster>(
          onTextChenge: (v) {},
          callback: (ModelCommonMaster c) {
            return Text(c.name!);
          },
          suggestionList: (s) {
            return c.list_acc_type
                .where((e) =>
                    (e.name ?? '').toUpperCase().contains(s.toUpperCase()))
                .toList();
          },
          onSelected: (v) {},
          controller: ct,
          focusNode: f);
  CustomSearchableDropdown ledger(
          FinVoucherEntryController c, FocusNode f, TextEditingController ct) =>
      CustomSearchableDropdown<ModelChartAccMaster>(
          FontWidth: FontWeight.bold,
          onTextChenge: (v) {},
          callback: (ModelChartAccMaster v) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v.cHARTNAME ?? '',
                  style: customTextStyle.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  v.cATNAME ?? '',
                  style: customTextStyle.copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${v.gLCODE ?? ''}  ${v.gLNAME ?? ''}',
                  style: customTextStyle.copyWith(
                      fontSize: 14, color: appColorMint),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
          suggestionList: (v) {
            var x = c.list_ledger
                .where((e) =>
                    (e.gLNAME ?? '').toUpperCase().contains(v.toUpperCase()) ||
                    (e.cATNAME ?? '').toUpperCase().contains(v.toUpperCase()) ||
                    (e.cATNAME ?? '').toUpperCase().contains(v.toUpperCase()) ||
                    (e.gLCODE ?? '').toUpperCase().contains(v.toUpperCase()))
                .toList();
            return x.isEmpty ? [] : x;
          },
          onSelected: (v) {},
          controller: ct,
          focusNode: f);

  CustomSearchableDropdown sl_ledger(
          FinVoucherEntryController c, FocusNode f, TextEditingController ct) =>
      CustomSearchableDropdown<FinModelSubLedgerMaster>(
          callback: (FinModelSubLedgerMaster v) {
            return Text(v.name ?? '');
          },
          suggestionList: (v) {
            return c.list_sl
                .where((e) =>
                    (e.name ?? '').toUpperCase().contains(v.toUpperCase()))
                .toList();
          },
          onSelected: (v) {},
          controller: ct,
          focusNode: f);

  CustomSearchableDropdown cost_center(
          FinVoucherEntryController c, FocusNode f, TextEditingController ct) =>
      CustomSearchableDropdown<FinModelCostCenter>(
          onTextChenge: (v) {},
          callback: (FinModelCostCenter v) {
            return Text(v.name ?? '');
          },
          suggestionList: (v) {
            return c.list_cc
                .where((e) =>
                    (e.name ?? '').toUpperCase().contains(v.toUpperCase()))
                .toList();
          },
          onSelected: (v) {},
          controller: ct,
          focusNode: f);
}

class _cq {
  String? id;
  String? checque_no;
  _cq({
    this.id,
    this.checque_no,
  });
}

class _tot {
  String? dr;
  String? cr;
  String? tot;
  _tot({
    this.dr,
    this.cr,
    this.tot,
  });
}

class _v {
  CustomSearchableDropdown? crdr;
  String? crdr_id;
  CustomSearchableDropdown? ledger;
  String? ledger_id;
  CustomSearchableDropdown? sl;
  String? sl_id;
  CustomSearchableDropdown? cc;
  String? cc_id;
  List<_cq>? cq;
  FocusNode? narration_f;
  TextEditingController? narration;
  TextEditingController? amount;
  FocusNode? amount_f;
  String? s;
  _v(
      {this.crdr,
      this.crdr_id,
      this.ledger,
      this.ledger_id,
      this.sl,
      this.sl_id,
      this.cc,
      this.cc_id,
      this.cq,
      this.narration,
      this.amount,
      this.s,
      this.amount_f,
      this.narration_f});
}
