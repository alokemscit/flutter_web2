// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/shared/inv_function.dart';

import '../../inv_po_approve/model/inv_model_PO_Approval.dart';
import '../../inv_po_create/model/inv_model_po_details.dart';
import '../../inv_po_create/model/inv_model_terms_master.dart';
import '../../inv_supplier_master/model/inv_model_supplier_master.dart';

class InvGrnCreateController extends GetxController with MixInController {
  final TextEditingController txt_grn_date = TextEditingController();
  final TextEditingController txt_grn_note = TextEditingController();

  var list_tool = <CustomTool>[].obs;
  var cmb_store_typeID = ''.obs;
  var list_year = <ModelCommonMaster>[].obs;
  var cmb_yearID = ''.obs;
  var cmb_supplierID = ''.obs;
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  //@cid int=12,@store_type_id int=2, @year int=2024
  var selectedMrr = ModelPoMasterForApp().obs;
  var list_po_master = <ModelPoMasterForApp>[].obs;
  var list_terms_master = <ModelInvTermsMaster>[].obs;
  var list_month = <_m>[].obs;
  var grand_total = ''.obs;
  var list_po_item_tems = <_temp2>[].obs;
  var list_po_details = <ModelPoDetails>[].obs;
  var list_supplier = <ModelSupplierMaster>[].obs;

  void toolEvent(ToolMenuSet v) {
    if (v == ToolMenuSet.undo) {
      setUndo();
    }
  }

  void setCheckCondition(bool b, String id) {
    list_terms_master.where((e) => e.id.toString() == id).first.isDefault =
        b ? 1 : 0;
    list_terms_master.refresh();
  }

  void setUndo() {
    list_po_item_tems.clear();

    list_po_details.clear();

    selectedMrr.value = ModelPoMasterForApp();
    list_terms_master.clear();
    grand_total.value = '';
    mToolEnableDisable(list_tool, [
      ToolMenuSet.none
    ], [
      ToolMenuSet.approve,
      ToolMenuSet.save,
      ToolMenuSet.undo,
    ]);
    txt_grn_date.text = '';
    txt_grn_note.text = '';

    cmb_supplierID.value = '';
  }

  void setMRR(ModelPoMasterForApp f) {
    list_po_details.clear();
    list_po_item_tems.clear();

    selectedMrr.value = f;
    cmb_supplierID.value = (f.supId ?? '').toString();
    txt_grn_date.text = '';
    txt_grn_note.text = '';
    setStore();
  }

  void next_line_qty(_temp2 f) {
    var index = list_po_item_tems.indexOf(f);
    if (index != -1 && index + 1 < list_po_item_tems.length) {
      var el = list_po_item_tems.elementAt(index + 1);
      FocusScope.of(context).requestFocus(el.qty_f);
    }
  }

  void removeTempItem(_temp2 f) {
    list_po_item_tems
        .removeWhere((e) => e.id == f.id && e.isFree == f.isFree && e == f);
    if (list_po_item_tems.isEmpty) {
      // mToolEnableDisable(list_tool, [], [ToolMenuSet.save, ToolMenuSet.undo]);
      setUndo();
    }
    getTotal();
  }

  void key_change(_temp2 f) {
    final _tempItem = list_po_item_tems
        .firstWhere((e) => e.id == f.id && e.isFree == f.isFree);

    if (f.isFree != 1) {
      if (f.remQty! < (double.tryParse(f.qty?.text ?? '0') ?? 0)) {
        f.qty!.text = f.remQty.toString();
        _tempItem.qty!.text = f.remQty.toString();
      }
    }

    final qty = double.tryParse(f.qty?.text ?? '0') ?? 0;
    final rate = f.rate ?? 0;
    final discount = f.disc ?? 0;

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
        list_po_item_tems.add(_temp2(
          id: e.itemId,
          name: e.itemName ?? '',
          type: e.subGroupName ?? '',
          unit: e.unitName ?? '',
          appQty: e.app_qty,
          code: e.code ?? '',
          remQty: e.rem_qty,
          amt: e.tot,
          disc: e.disc,
          rate: e.rate,
          poQty: e.qty,
          qty: TextEditingController(text: e.rem_qty.toString()),
          qty_f: FocusNode(),
          isFree: e.isFree,
          batch: TextEditingController(text: ''),
          batc_f: FocusNode(),
          expdate: TextEditingController(
              text: DateFormat('dd/MM/yyyy')
                  .format(DateTime.now().add(const Duration(days: 365)))),
          expdate_f: FocusNode(),
        ));
      });
      getTotal();

      if (list_po_details.isNotEmpty) {
        mToolEnableDisable(list_tool, [ToolMenuSet.save, ToolMenuSet.undo],
            [ToolMenuSet.file]);
      } else {
        mToolEnableDisable(list_tool, [], [ToolMenuSet.save, ToolMenuSet.undo]);
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

  void getTotal() {
    double d = 0.00;
    list_po_item_tems.forEach((f) {
      d += f.amt ?? 0;
    });
    grand_total.value = d.toStringAsFixed(3);
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
              "tag": "87",
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

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    cmb_yearID.value = DateFormat('yyyy').format(DateTime.now());
    try {
      await Inv_Get_Year(api, list_year, user.value.cid!);
      await Inv_Get_Store_Type(api, list_storeTypeList, user.value.cid!);
      await Inv_Get_Suppliers(api, list_supplier, user.value.cid!);
      list_tool.value = Custom_Tool_List();
      mToolEnableDisable(list_tool, [ToolMenuSet.show], [ToolMenuSet.file]);

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

class _temp2 {
  int? id;
  String? code;
  String? name;
  String? type;
  String? unit;
  double? poQty;
  double? appQty;
  double? remQty;
  TextEditingController? qty;
  double? rate;
  double? disc;
  TextEditingController? batch;
  TextEditingController? expdate;
  double? amt;
  FocusNode? qty_f;
  FocusNode? batc_f;
  FocusNode? expdate_f;
  double? isFree;
  _temp2({
    this.id,
    this.code,
    this.name,
    this.type,
    this.unit,
    this.appQty,
    this.remQty,
    this.qty,
    this.rate,
    this.disc,
    this.batch,
    this.expdate,
    this.amt,
    this.qty_f,
    this.batc_f,
    this.expdate_f,
    this.isFree,
    this.poQty,
  });
}

 