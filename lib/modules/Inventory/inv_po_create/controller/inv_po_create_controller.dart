// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, camel_case_types, curly_braces_in_flow_control_structures
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:intl/intl.dart';

import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/inv_supplier_master/model/inv_model_supplier_master.dart';

import '../../inv_item_master/model/inv_model_item_master.dart';
import '../model/inv_model_pr_for_app_model.dart';
import '../model/inv_model_pr_item_details.dart';
import '../model/inv_model_terms_master.dart';

class InvPoCreateController extends GetxController with MixInController {
  final TextEditingController txt_po_date = TextEditingController();
  final TextEditingController txt_delivery_date = TextEditingController();
  final TextEditingController txt_delivery_note = TextEditingController();
  final TextEditingController txt_remarks = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var list_year = <ModelCommonMaster>[].obs;
  var list_pr_master = <ModelInvPrForApp>[].obs;
  var list_terms_master = <ModelInvTermsMaster>[].obs;
  var list_supplier = <ModelSupplierMaster>[].obs;
  var list_pr_item_details = <ModelInvPrItemDetails>[].obs;
  var list_pr_item_tems = <_temp>[].obs;

  var list_tools = <CustomTool>[].obs;

  var list_item_master = <ModelItemMaster>[].obs;
  var list_item_temp = <ModelItemMaster>[].obs;

  var cmb_store_typeID = ''.obs;
  var cmb_yearID = ''.obs;
  var cmb_supplierID = ''.obs;
  var list_month = <_m>[].obs;
  var selectedMrr = ModelInvPrForApp().obs;
  var grand_total = ''.obs;
  var isShowfree = false.obs;

  void removeTempItem(_temp f) {
    list_pr_item_tems.removeWhere(
        (e) => e.itemId == f.itemId && e.isFree == f.isFree && e == f);
    if (list_pr_item_tems.isEmpty) {
      mToolEnableDisable(list_tools, [], [ToolMenuSet.save, ToolMenuSet.undo]);
    }
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(
        cmb_supplierID.value == '', dialog, 'Please select supplier')) return;
    //if(isCheckCondition(, dialog, msg))
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
        list_pr_item_tems.isEmpty, dialog, 'No Item list found for PO')) return;

    List<Map<String, dynamic>> list = [];

    for (var f in list_pr_item_tems) {
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
        "rate": (double.tryParse(f.rate?.text ?? '0') ?? 0),
        "disc": (double.tryParse(f.disc?.text ?? '0') ?? 0),
        "amt": f.amt
      });
    }
    List<Map<String, dynamic>> __list_terms = [];
    list_terms_master.forEach((f) {
      if (f.isDefault == 1) {
        __list_terms.add({"id": f.id});
      }
    });
    //print(jsonEncode(__list_terms));

    try {
      //  loader.show();
      //  @cid int,@pr_id int, @sup_id int, @po_date varchar(10),@delivery_date varchar(10),@remarks nvarchar(500),@delivery_note nvarchar(500),
//@emp_id int,@str_item  varchar(max),@str_terms
      ModelStatus st = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "80",
          "cid": user.value.cid,
          "pr_id": selectedMrr.value.id,
          "sup_id": cmb_supplierID.value,
          "po_date": txt_po_date.text,
          "delivery_date": txt_delivery_date.text,
          "remarks": txt_remarks.text,
          "delivery_note": txt_delivery_note.text,
          "emp_id": user.value.uid,
          "str_item": jsonEncode(list),
          "str_terms": jsonEncode(__list_terms)
        }
      ]);
      // loader.close();

      if (st.status == "1") {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () {
            setUndo();
            setStore();
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

  void addFreeItem(ModelItemMaster f) {
    var y = list_pr_item_tems
        .where((e) => e.itemId.toString() == f.id && e.isFree == true);
    if (y.isNotEmpty) {
      y.first.qty!.text =
          ((double.tryParse(y.first.qty?.text ?? '0') ?? 0) + 1).toString();
      list_pr_item_tems.refresh();
    } else {
      list_pr_item_tems.add(_temp(
          appQty: 0,
          code: f.code,
          comName: f.conName,
          disc: TextEditingController(text: '0.0'),
          genericName: f.genName,
          groupName: f.grpName,
          initName: f.unitName,
          itemId: int.parse(f.id!),
          itemName: f.name,
          subgroupName: f.sgrpName,
          qty: TextEditingController(text: 1.toString()),
          rate: TextEditingController(
            text: 0.toString(),
          ),
          remQty: 0,
          reqQty: 0,
          amt: 0,
          disc_f: FocusNode(),
          qty_f: FocusNode(),
          rate_f: FocusNode(),
          isFree: true));
    }
    if (list_pr_item_tems.isNotEmpty) {
      mToolEnableDisable(list_tools, [ToolMenuSet.save, ToolMenuSet.undo], []);
    }
  }

  void getTotal() {
    double d = 0.00;
    list_pr_item_tems.forEach((f) {
      d += f.amt ?? 0;
    });
    grand_total.value = d.toStringAsFixed(3);
  }

  void next_line_qty(_temp f) {
    var index = list_pr_item_tems.indexOf(f);
    if (index != -1 && index + 1 < list_pr_item_tems.length) {
      var el = list_pr_item_tems.elementAt(index + 1);
      FocusScope.of(context).requestFocus(el.qty_f);
    }
  }

  void key_change(_temp f, [bool isRqty = false]) {
    final _tempItem = list_pr_item_tems
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

    list_pr_item_tems.refresh();
    getTotal();
  }

  void setUndo() {
    isShowfree.value = false;
    list_item_temp.clear();
    list_pr_item_tems.clear();

    list_pr_item_details.clear();

    selectedMrr.value = ModelInvPrForApp();
    list_terms_master.clear();
    grand_total.value = '';
    mToolEnableDisable(
        list_tools, [ToolMenuSet.none], [ToolMenuSet.save, ToolMenuSet.undo]);
  }

  void setMRR(ModelInvPrForApp f) {
    isShowfree.value = false;
    list_item_temp.clear();
    list_pr_item_details.clear();
    list_pr_item_tems.clear();

    selectedMrr.value = f;
    cmb_supplierID.value = '';
    txt_delivery_note.text = '';
    txt_remarks.text = '';
    setStore();
  }

  void setStore() async {
    // setUndo();
    list_terms_master.clear();
    list_pr_item_tems.clear();
    list_item_temp.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      await mLoadModel(
          api,
          [
            {
              "tag": "77",
              "cid": user.value.cid,
              "store_type_id": cmb_store_typeID.value
            }
          ],
          list_terms_master,
          (x) => ModelInvTermsMaster.fromJson(x));
      await mLoadModel(
          api,
          [
            {"tag": "78", "prid": selectedMrr.value.id}
          ],
          list_pr_item_details,
          (x) => ModelInvPrItemDetails.fromJson(x));

      list_pr_item_details.forEach((e) {
        list_pr_item_tems.add(_temp(
            appQty: e.appQty,
            code: e.code,
            comName: e.comName,
            disc: TextEditingController(text: '0.0'),
            genericName: e.genericName,
            groupName: e.groupName,
            initName: e.initName,
            itemId: e.itemId,
            itemName: e.itemName,
            subgroupName: e.subgroupName,
            qty: TextEditingController(text: e.qty.toString()),
            rate: TextEditingController(
              text: e.rate.toString(),
            ),
            remQty: e.remQty,
            reqQty: e.reqQty,
            amt: ((e.rate ?? 0) * (e.qty ?? 0)),
            disc_f: FocusNode(),
            qty_f: FocusNode(),
            rate_f: FocusNode(),
            isFree: false));
      });
      getTotal();

      if (list_pr_item_details.isNotEmpty) {
        mToolEnableDisable(list_tools, [ToolMenuSet.save, ToolMenuSet.undo],
            [ToolMenuSet.file]);
      } else {
        mToolEnableDisable(
            list_tools, [], [ToolMenuSet.save, ToolMenuSet.undo]);
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

  void show_pr() async {
    setUndo();
    list_item_temp.clear();
    list_month.clear();
    list_pr_master.clear();
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
              "tag": "76",
              "cid": user.value.cid,
              "store_type_id": cmb_store_typeID.value,
              "year": cmb_yearID.value
            }
          ],
          list_pr_master,
          (x) => ModelInvPrForApp.fromJson(x)).then((v) {
        List<_m> l_m = [];
        list_pr_master.forEach((e) {
          l_m.add(_m(name: e.month_name));
        });
        list_month
          ..clear()
          ..addAll(l_m.toSet());
      });
    });
  }

  @override
  void onInit() async {
    api = data_api2();
    cmb_yearID.value = DateFormat('yyyy').format(DateTime.now());
    isLoading.value = true;
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
      list_tools.addAll(Custom_Tool_List());
      mToolEnableDisable(list_tools, [], [ToolMenuSet.file]);
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }

    super.onInit();
  }

  void setCheckCondition(bool b, String id) {
    list_terms_master.where((e) => e.id.toString() == id).first.isDefault =
        b ? 1 : 0;
    list_terms_master.refresh();
  }

  void addFreeItemShow() {
    list_item_temp.clear();
    list_item_temp
      ..clear()
      ..addAll(list_item_master
          .where((e) => e.storeTypeId == cmb_store_typeID.value));
    isShowfree.value = true;
  }

  void search() {
    list_item_temp
      ..clear()
      ..addAll(list_item_master.where((e) =>
          (e.storeTypeId == cmb_store_typeID.value) &&
              e.code!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.unitName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.conName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.sgrpName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.grpName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.genName!.toUpperCase().contains(txt_search.text.toUpperCase())));
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
