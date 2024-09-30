// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/inv_item_master/model/inv_model_item_master.dart';

import '../../inv_po_create/model/inv_model_po_details.dart';

import '../../inv_po_create/model/inv_model_terms_master.dart';
import '../../inv_supplier_master/model/inv_model_supplier_master.dart';
import '../model/inv_model_PO_Approval.dart';

class InvPoApprovalController extends GetxController with MixInController {
  var cmb_yearID = ''.obs;
  var cmb_store_typeID = ''.obs;
  var cmb_supplierID = ''.obs;
  var grand_total = ''.obs;
  var list_menu = <CustomTool>[].obs;
  var selectedMrr = ModelPoMasterForApp().obs;
  final TextEditingController txt_po_date = TextEditingController();
  final TextEditingController txt_delivery_date = TextEditingController();
  final TextEditingController txt_delivery_note = TextEditingController();
  final TextEditingController txt_remarks = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var list_year = <ModelCommonMaster>[].obs;

  var list_po_master = <ModelPoMasterForApp>[].obs;

  var list_terms_master = <ModelInvTermsMaster>[].obs;
  var list_supplier = <ModelSupplierMaster>[].obs;
  var list_item_master = <ModelItemMaster>[].obs;

  var list_po_item_tems = <_temp>[].obs;

  var list_po_details = <ModelPoDetails>[].obs;

  var list_month = <_m>[].obs;
  bool b = true;
  void toolBarEvent(ToolMenuSet v) async {
    if (!b) {
      Future.delayed(const Duration(seconds: 1), () {
        b = true;
      });
      return;
    }
    b = false;

    if (v == ToolMenuSet.undo) {
      setUndo();
    }
    if (v == ToolMenuSet.approve) {
      po_approve_cancel(true);
    }
    if (v == ToolMenuSet.cancel) {
      po_approve_cancel(false);
    }
  }

  void po_approve_cancel(bool isApprove) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(
        cmb_supplierID.value == '', dialog, 'Please select supplier')) return;

    if (isCheckCondition(txt_po_date.text.isEmpty, dialog, 'Po Date Required!'))
      return;
    if (isCheckCondition(
        txt_delivery_date.text.isEmpty, dialog, 'Delivery Date Required!'))
      return;

    if (isCheckCondition(
        !isValidDateRange(txt_po_date.text, txt_delivery_date.text),
        dialog,
        'Delivery date should be greater  or equal to PO date')) return;
    if (isCheckCondition(
        list_po_item_tems.isEmpty, dialog, 'No Item list found for PO')) return;

    List<Map<String, dynamic>> list = [];

    for (var f in list_po_item_tems) {
      if ((double.tryParse(f.qty?.text ?? '0') ?? 0) == 0) {
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Item quantity should be greater tahn zero'
          ..show();
        break;
      }

      if (!f.isFree! && (double.tryParse(f.rate?.text ?? '0') ?? 0) == 0) {
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Item Rate should be required for non free item'
          ..show();
        break;
      }
      list.add({
        "id": f.itemId,
        "is_free": f.isFree! ? 1 : 0,
        "qty": (double.tryParse(f.qty?.text ?? '0') ?? 0),
        // "rate": (double.tryParse(f.rate?.text ?? '0') ?? 0),
        // "disc": (double.tryParse(f.disc?.text ?? '0') ?? 0),
        // "amt": f.amt
      });
    }
    List<Map<String, dynamic>> __list_terms = [];
    list_terms_master.forEach((f) {
      if (f.isDefault == 1) {
        __list_terms.add({"id": f.id});
      }
    });

    try {
      // @ int,   @ int, @ int, @po_date varchar(10),@delivery_date varchar(10),@remarks nvarchar(500),@delivery_note nvarchar(500),
//@emp_id int,@str_item  varchar(max),@str_terms varchar(max)  , @is_app tinyint

      // print({
      //   "tag": "86",
      //   "po_id": selectedMrr.value.id,
      //   "pr_id": selectedMrr.value.pr_id,
      //   "sup_id": cmb_supplierID.value,
      //   "po_date": txt_po_date.text,
      //   "delivery_date": txt_delivery_date.text,
      //   "remarks": txt_remarks.text,
      //   "delivery_note": txt_delivery_note.text,
      //   "emp_id": user.value.uid,
      //   "str_item": jsonEncode(list),
      //   "str_terms": jsonEncode(__list_terms),
      //   "is_app": isApprove ? "1" : "0"
      // });

      ModelStatus st = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "86",
          "po_id": selectedMrr.value.id,
          "pr_id": selectedMrr.value.pr_id,
          "sup_id": cmb_supplierID.value,
          "po_date": txt_po_date.text,
          "delivery_date": txt_delivery_date.text,
          "remarks": txt_remarks.text,
          "delivery_note": txt_delivery_note.text,
          "emp_id": user.value.uid,
          "str_item": jsonEncode(list),
          "str_terms": jsonEncode(__list_terms),
          "is_app": isApprove ? "1" : "0"
        }
      ]);

      if (st.status == "1") {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            setUndo();
            //setStore();
            show_po();
            // show_po_report(st.id!);

            /// list_pr_master.removeWhere((e) => e.id == selectedMrr.value.id);
          };
      }
    } catch (e) {
      // loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void setCheckCondition(bool b, String id) {
    list_terms_master.where((e) => e.id.toString() == id).first.isDefault =
        b ? 1 : 0;
    list_terms_master.refresh();
  }

  void show_po() async {
    setUndo();
    //list_item_temp.clear();
    list_month.clear();
    list_po_master.clear();
    if (cmb_store_typeID.value == '' || cmb_yearID.value == '') {
      return;
    }
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    await mVoidProcess(loader, dialog, () {
      mLoadModel(
          api,
          [
            {
              "tag": "84",
              "cid": user.value.cid,
              "store_type_id": cmb_store_typeID.value,
              "year": cmb_yearID.value
            }
          ],
          list_po_master,
          (x) => ModelPoMasterForApp.fromJson(x)).then((v) {
        List<_m> l_m = [];
        list_po_master.forEach((e) {
          l_m.add(_m(name: e.monthName));
        });
        list_month
          ..clear()
          ..addAll(l_m.toSet());
      });
    });
  }

  void setUndo() {
    list_po_item_tems.clear();

    list_po_details.clear();

    selectedMrr.value = ModelPoMasterForApp();
    list_terms_master.clear();
    grand_total.value = '';
    mToolEnableDisable(list_menu, [
      ToolMenuSet.none
    ], [
      ToolMenuSet.approve,
      ToolMenuSet.save,
      ToolMenuSet.undo,
      ToolMenuSet.cancel
    ]);
    txt_delivery_date.text = '';
    txt_delivery_note.text = '';
    txt_po_date.text = '';
    txt_search.text = '';
    txt_remarks.text = '';
    cmb_supplierID.value = '';
  }

  void setMRR(ModelPoMasterForApp f) {
    list_po_details.clear();
    list_po_item_tems.clear();

    selectedMrr.value = f;
    cmb_supplierID.value = (f.supId ?? '').toString();
    txt_delivery_note.text = f.deliveryNote ?? '';
    txt_delivery_date.text = f.deliveryDate ?? '';
    txt_po_date.text = f.poDate ?? '';
    txt_remarks.text = f.remarks ?? '';
    setStore();
  }

  void getTotal() {
    double d = 0.00;
    list_po_item_tems.forEach((f) {
      d += f.amt ?? 0;
    });
    grand_total.value = d.toStringAsFixed(3);
  }

  void next_line_qty(_temp f) {
    var index = list_po_item_tems.indexOf(f);
    if (index != -1 && index + 1 < list_po_item_tems.length) {
      var el = list_po_item_tems.elementAt(index + 1);
      FocusScope.of(context).requestFocus(el.qty_f);
    }
  }

  void key_change(_temp f, [bool isRqty = false]) {
    final _tempItem = list_po_item_tems
        .firstWhere((e) => e.itemId == f.itemId && e.isFree == f.isFree);

    if (isRqty && !f.isFree!) {
      if (f.remQty! < (double.tryParse(f.qty?.text ?? '0') ?? 0)) {
        f.qty!.text = f.remQty.toString();
        _tempItem.qty!.text = f.remQty.toString();
      }
    }

    final qty = double.tryParse(f.qty?.text ?? '0') ?? 0;
    final rate = double.tryParse(f.rate?.text ?? '0') ?? 0;
    final discount = double.tryParse(f.disc?.text ?? '0') ?? 0;

    _tempItem.amt = (qty * rate) - ((qty * rate) * (discount / 100))
      ..toStringAsFixed(3)
      ..toDouble();

    list_po_item_tems.refresh();
    getTotal();
  }

  void setStore() async {
    // setUndo();
    list_terms_master.clear();
    list_po_item_tems.clear();

    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      await mLoadModel(
          api,
          [
            {
              "tag": "85",
              "cid": user.value.cid,
              "store_type_id": cmb_store_typeID.value,
              "po_id": selectedMrr.value.id
            }
          ],
          list_terms_master,
          (x) => ModelInvTermsMaster.fromJson(x));

      await mLoadModel(
          api,
          [
            {"tag": "81", "po_id": selectedMrr.value.id}
          ],
          list_po_details,
          (x) => ModelPoDetails.fromJson(x));

      list_po_details.forEach((e) {
        list_po_item_tems.add(_temp(
            appQty: e.app_qty,
            code: e.code,
            comName: '',
            disc: TextEditingController(text: e.disc!.toStringAsFixed(2)),
            genericName: e.generic ?? '',
            groupName: e.groupName,
            initName: e.unitName ?? '',
            itemId: e.itemId,
            itemName: e.itemName,
            subgroupName: e.subGroupName ?? '',
            qty: TextEditingController(text: e.qty.toString()),
            rate: TextEditingController(
              text: e.rate.toString(),
            ),
            remQty: e.qty,
            reqQty: e.qty,
            amt: ((e.rate ?? 0) * (e.qty ?? 0)),
            disc_f: FocusNode(),
            qty_f: FocusNode(),
            rate_f: FocusNode(),
            isFree: e.isFree! > 0 ? true : false));
      });
      getTotal();

      if (list_po_details.isNotEmpty) {
        mToolEnableDisable(
            list_menu,
            [ToolMenuSet.approve, ToolMenuSet.undo, ToolMenuSet.cancel],
            [ToolMenuSet.file]);
      } else {
        mToolEnableDisable(list_menu, [],
            [ToolMenuSet.approve, ToolMenuSet.undo, ToolMenuSet.cancel]);
      }
      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api2();
    cmb_yearID.value = DateFormat('yyyy').format(DateTime.now());
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;

    try {
      await mLoadModel(
        api,
        [
          {"tag": "30", "cid": user.value.cid}
        ],
        list_storeTypeList,
        (json) => ModelCommonMaster.fromJson(json),
      );
      await mLoadModel(
          api,
          [
            {"tag": "75", "cid": user.value.cid}
          ],
          list_year,
          (json) => ModelCommonMaster.fromJson(json));

      await mLoadModel(
          api,
          [
            {"tag": "71", "cid": user.value.cid}
          ],
          list_supplier,
          (x) => ModelSupplierMaster.fromJson(x));

      await mLoadModel(
          api,
          [
            {"tag": "63", "cid": user.value.cid}
          ],
          list_item_master,
          (x) => ModelItemMaster.fromJson(x));
      list_menu.value = Custom_Tool_List();
      mToolEnableDisable(list_menu, [ToolMenuSet.show], [ToolMenuSet.file]);
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }
}

class _m extends Equatable {
  String? name;
  _m({
    this.name,
  });
  @override
  List<Object?> get props => [name];
}

class _temp {
  int? itemId;
  String? code;
  String? itemName;
  String? comName;
  String? genericName;
  String? groupName;
  String? subgroupName;
  String? initName;
  double? reqQty;
  double? appQty;
  double? remQty;
  TextEditingController? qty;
  TextEditingController? rate;
  TextEditingController? disc;
  double? amt;
  FocusNode? qty_f;
  FocusNode? rate_f;
  FocusNode? disc_f;
  bool? isFree;

  _temp(
      {this.itemId,
      this.code,
      this.itemName,
      this.comName,
      this.genericName,
      this.groupName,
      this.subgroupName,
      this.initName,
      this.reqQty,
      this.appQty,
      this.remQty,
      this.qty,
      this.rate,
      this.disc,
      this.amt,
      this.disc_f,
      this.qty_f,
      this.rate_f,
      this.isFree});
}
