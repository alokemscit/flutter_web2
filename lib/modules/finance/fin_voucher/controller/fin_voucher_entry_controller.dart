// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';
import 'package:web_2/core/config/const.dart';

import '../../cost_center_master/model/model_costcenter_master.dart';
import '../../fin_shared/fin_function.dart';
import '../../ledger_master_page/model/model_chart_acc_master.dart';
import '../../sub_ledger_master/model/fiin_model_subledger_master.dart';
import '../model/fin_model_voucher_type.dart';

class FinVoucherEntryController extends GetxController with MixInController {
  var isShowRightMenuBar = true.obs;
  var list_acc_type = <ModelCommonMaster>[].obs;
  var list_voucher_type = <FinModelVoucherType>[].obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedVoucherType = FinModelVoucherType().obs;
  final TextEditingController txt_voucher_date = TextEditingController();
  final TextEditingController txt_voucher_narration = TextEditingController();
  var list_voucher_temp = <_v>[].obs;
  var list_ledger = <ModelChartAccMaster>[].obs;
  var list_cc = <FinModelCostCenter>[].obs;
  var list_sl = <FinModelSubLedgerMaster>[].obs;
  var total = _tot().obs;

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
          narration:  e.narration,
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
    list_tool.addAll(Custom_Tool_List());

    try {
      await Fin_Get_Acc_Type(api, list_acc_type);
      await Fin_Get_Voucher_Type(api, list_voucher_type);
      await Fin_Get_Chart_of_acc(api, list_ledger, user.value.cid!);
      await Fin_Get_Cost_center(api, list_cc, user.value.cid!);
      await Fin_Get_sub_ledger(api, list_sl, user.value.cid!);

      mToolEnableDisable(list_tool, [
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
    mToolEnableDisable(list_tool, [ToolMenuSet.save, ToolMenuSet.undo], []);
    txt_voucher_narration.text = '';
    list_voucher_temp.clear();
    createNew();
  }

  void setUndo() {
    mToolEnableDisable(list_tool, [], [ToolMenuSet.save, ToolMenuSet.undo]);
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
      Future.delayed(const Duration(milliseconds: 400), () {
        b = true; // Re-enable events after the delay
      });
    }
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
               Text(v.cHARTNAME ?? '' ,style: customTextStyle.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis,),
               Text(v.cATNAME ?? '',style: customTextStyle.copyWith(fontSize: 14),overflow: TextOverflow.ellipsis,),
               Text( '${v.gLCODE??''}  ${v.gLNAME ?? ''}',style: customTextStyle.copyWith(fontSize: 14,color: appColorMint),overflow: TextOverflow.ellipsis,),
              ],
            );
          },
          suggestionList: (v) {
            var x = c.list_ledger
                .where((e) =>
                    (e.gLNAME ?? '').toUpperCase().contains(v.toUpperCase())
                    ||(e.cATNAME ?? '').toUpperCase().contains(v.toUpperCase())
                     ||(e.cATNAME ?? '').toUpperCase().contains(v.toUpperCase())
                     ||(e.gLCODE ?? '').toUpperCase().contains(v.toUpperCase())
                    )
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
