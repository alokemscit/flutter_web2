// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:web_2/component/custom_pdf_report_generator.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/shared/inv_function.dart';

import '../../inv_po_approve/model/inv_model_PO_Approval.dart';
import '../../inv_po_create/model/inv_model_po_details.dart';
import '../../inv_po_create/model/inv_model_terms_master.dart';
import '../../inv_supplier_master/model/inv_model_supplier_master.dart';
import '../model/inv_grn_master_view.dart';
import 'inv_grn_details_view.dart';

class InvGrnCreateController extends GetxController with MixInController {
  final TextEditingController txt_grn_date = TextEditingController();
  final TextEditingController txt_store_name = TextEditingController();
  final TextEditingController txt_grn_note = TextEditingController();
  final TextEditingController txt_chalan_date = TextEditingController();
  final TextEditingController txt_chalan_no = TextEditingController();
  final TextEditingController txt_search_d = TextEditingController();

  var cmb_store_type_id_d = ''.obs;
  final TextEditingController txt_fdate_d = TextEditingController();
  final TextEditingController txt_tdate_d = TextEditingController();
  var list_grn_master_view = <ModelGrnMAsterView>[].obs;
  var list_grn_master_view_temp = <ModelGrnMAsterView>[].obs;

  var list_tool = <CustomTool>[].obs;
  var cmb_store_typeID = ''.obs;
  var cmb_store_id = ''.obs;
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
  var list_main_store = <ModelCommonMaster>[].obs;
  var list_grn_details_view = <ModelGrnDetailsView>[].obs;

  void report(String grn_id) async {
    print(grn_id);
    list_grn_details_view.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      loader.show();
      await mLoadModel(
          api,
          [
            {"tag": "91", "cid": user.value.cid, "grn_id": grn_id}
          ],
          list_grn_details_view,
          (x) => ModelGrnDetailsView.fromJson(x));
      if (list_grn_details_view.isEmpty) {
        loader.close();
        return;
      }
      var x = list_grn_details_view.first;
      var total = list_grn_details_view.fold(0.0, (previousValue, element) {
        return previousValue + (element.tot ?? 0.0);
      });

      CustomPDFGenerator(
          font: font,
          header: [
            pwTextOne(font, '', user.value.cname ?? ''),
            pwHeight(),
            pwTextOne(font, 'Store Type : ', x.storeName ?? '', 9,
                pwMainAxisAlignmentStart),
            pwHeight(4),
            pwText2Col(font, "GRN. No : ", x.grnNo ?? '', 'GRN. Date : ',
                x.grnDate ?? ''),
           
            pwHeight(4),
            pwText2Col(font, "Chalan. No : ", x.chalanNo ?? '',
                'Chalan. Date : ', x.chalanDate ?? ''),
                 pwHeight(4),
            pwText2Col(
                font,
                "PO. No : ",
                x.poNo ?? '',
                'GRN. Status : ',
                (x.currentStatus ?? 0) == 0
                    ? 'Canceled'
                    : (x.currentStatus ?? 0) == 2
                        ? "Approved"
                        : "Approval Pending"),
            pwHeight(4),
            pwTextOne(font, 'Remarks : ', x.remarks ?? '', 9,
                pwMainAxisAlignmentStart)
          ],
          footer: [
            pwText2Col(font, "GRN. Created By : ", x.createdBy ?? '',
                'Created. Date : ', x.createdDate ?? ''),
            pwHeight(4),
            (x.currentStatus ?? 0) == 2
                ? pwText2Col(font, "Approved By : ", x.appBy ?? '',
                    'Created. Date : ', x.appDate ?? '')
                : (x.currentStatus ?? 0) == 0
                    ? pwText2Col(font, "Canceled By : ", x.cancelBy ?? '',
                        'Created. Date : ', x.cancelDate ?? '')
                    : pwSizedBox(),
            pwText2Col(
                font,
                "Printed By : ",
                user.value.name ?? '',
                'Printed Date : ',
                DateFormat('dd/MM/yyyy hh:mm PM').format(DateTime.now())),
          ],
          body: [
            pwGenerateTable([
              15,
              50,
              20,
              20,
              20,
              20,
              20,
              20,
              20,
              30
            ], [
              pwTableColumnHeader('Code', font),
              pwTableColumnHeader('Name', font),
              pwTableColumnHeader('Type', font, pwAligmentCenter),
              pwTableColumnHeader('Unit', font, pwAligmentCenter),
               pwTableColumnHeader('Batch', font, pwAligmentCenter),
              pwTableColumnHeader('MRP', font, pwAligmentCenter),
              
              pwTableColumnHeader('Price', font, pwAligmentCenter),
              pwTableColumnHeader('Disc(%)', font, pwAligmentCenter),
              pwTableColumnHeader('Qty', font, pwAligmentCenter),
              pwTableColumnHeader('Total', font, pwAligmentRight),
            ], [
              ...list_grn_details_view.map((f) => pwTableRow([
                    pwTableCell(f.code ?? '', font,pwAligmentLeft,8),
                    pwTableCell(f.itemName ?? '', font,pwAligmentLeft,8),
                    pwTableCell(f.subgroupName ?? '', font,pwAligmentCenter,8),
                    pwTableCell(f.unitName ?? '', font, pwAligmentCenter,8),
                     pwTableCell(f.batch_no ?? '', font, pwAligmentCenter,8),
                    pwTableCell((f.mrp ?? 0).toStringAsFixed(2), font,
                        pwAligmentCenter,8),
                    pwTableCell((f.price ?? 0).toStringAsFixed(2), font,
                        pwAligmentCenter,8),
                    pwTableCell((f.disc ?? 0).toStringAsFixed(2), font,
                        pwAligmentCenter,8),
                    pwTableCell((f.qty ?? 0).toStringAsFixed(2), font,
                        pwAligmentCenter,8),
                    pwTableCell(
                        (f.tot ?? 0).toStringAsFixed(2), font, pwAligmentRight,8),
                  ])),
            ]),
            pwGenerateTable([
              15 + 50 + 20 + 20 + 20 + 20+20,
              20 + 20,
              30,
            ], [
              pwTableColumnHeader('', font),
              pwTableColumnHeader('Grand Total', font, pwAligmentRight, 9.5),
              pwTableColumnHeader(
                  total.toStringAsFixed(2), font, pwAligmentRight, 9.5)
            ], [])
          ],
          fun: () {
            loader.close();
          }).ShowReport();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void save() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (isCheckCondition(
        cmb_store_id.value == '', dialog, 'Please select main store name!'))
      return;
    if (isCheckCondition(txt_grn_date.text == '', dialog, 'GRN date required!'))
      return;

    if (isCheckCondition(
        txt_chalan_date.text == '', dialog, 'Chalan date required!')) return;

    if (isCheckCondition(
        txt_chalan_no.text == '', dialog, 'Chalan no required!')) return;

    if (isCheckCondition(
        list_po_item_tems.isEmpty, dialog, 'No Item found for GRN!')) return;
    for (var f in list_po_item_tems) {
      if ((double.tryParse(f.qty?.text ?? '0') ?? 0) == 0) {
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Item quantity should be greater tahn zero'
          ..show();
        break;
      }
    }

    List<Map<String, dynamic>> list = [];
    list_po_item_tems.forEach((f) {
      list.add({"id":f.id,"qty": (double.tryParse(f.qty?.text ?? '0') ?? 0),"rate":f.rate,"disc":f.disc,"is_free":f.isFree,"batch":f.batch!.text,"exp_date":f.expdate!.text ,  });
    });

     

    try {
      //@cid int,@eid int,@po_id int, @store_type_id int, @store_id int, @sup_id int,   @str varchar(max),@rem nvarchar(250), @grn_date varchar(10)
      ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "89",
          "cid": user.value.cid,
          "eid": user.value.uid,
          "po_id": selectedMrr.value.id,
          "store_type_id": cmb_store_typeID.value,
          "store_id": cmb_store_id.value,
          "sup_id": selectedMrr.value.supId,
          "str": jsonEncode(list),
          "rem": txt_grn_note.text,
          "grn_date": txt_grn_date.text,
          "chalan_no": txt_chalan_no.text,
          "chalan_date": txt_chalan_date.text
        }
      ]);

      if (s.status == "1") {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () async {
            print(s.id);
            report(s.id ?? '');
            setUndo();
          };
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void toolEvent(ToolMenuSet v) {
    if (v == ToolMenuSet.undo) {
      setUndo();
    }
    if (v == ToolMenuSet.save) {
      save();
    }
  }

  void setCheckCondition(bool b, String id) {
    list_terms_master.where((e) => e.id.toString() == id).first.isDefault =
        b ? 1 : 0;
    list_terms_master.refresh();
  }

  void setUndo() {
    // list_main_store.clear();
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
    txt_chalan_date.text = '';
    txt_chalan_no.text = '';
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

  void load_main_Store() async {
    try {
      await Inv_Get_MainStore(
          api, list_main_store, user.value.cid ?? '', cmb_store_typeID.value);
      if (list_main_store.isNotEmpty) {
        cmb_store_id.value = list_main_store.first.id ?? '';
      }
    } catch (e) {}
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
    font = await CustomLoadFont(appFontPathOpenSans);
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

  @override
  void dispose() {
    print('Call Dispose');
    super.dispose();
  }

  @override
  void onClose() {
    txt_grn_date.dispose();
    txt_store_name.dispose();
    txt_grn_note.dispose();
    txt_chalan_date.dispose();
    txt_chalan_no.dispose();
    txt_search_d.dispose();
    txt_fdate_d.dispose();
    txt_tdate_d.dispose();

    list_po_item_tems.forEach((item) {
      item.qty?.dispose();
      item.qty_f?.dispose();
      item.batch?.dispose();
      item.batc_f?.dispose();
      item.expdate?.dispose();
      item.expdate_f?.dispose();
    });
    list_po_item_tems.close();
    list_grn_master_view.close();
    list_grn_master_view_temp.close();
    list_tool.close();
    cmb_store_typeID.close();
    cmb_store_id.close();
    list_year.close();
    cmb_yearID.close();
    cmb_supplierID.close();
    list_storeTypeList.close();
    selectedMrr.close();
    list_po_master.close();
    list_terms_master.close();
    list_month.close();
    grand_total.close();
    list_po_details.close();
    list_supplier.close();
    list_main_store.close();
    list_grn_details_view.close();
    super.onClose();
    print('Call close');
  }

  void view_grn() async {
    list_grn_master_view.clear();
    list_grn_master_view_temp.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (isCheckCondition(!isValidDateRange(txt_fdate_d.text, txt_tdate_d.text),
        dialog, 'Valid Date Range Required!')) return;
    if (isCheckCondition(
        cmb_store_type_id_d.value == '', dialog, 'Please Select Store Type'))
      return;
    loader.show();
    print([
      {
        "tag": "90",
        "cid": user.value.cid,
        "store_type_id": cmb_store_type_id_d.value,
        "fdate": txt_fdate_d.text,
        "tdate": txt_tdate_d.text
      }
    ]);
    try {
      await mLoadModel(
          api,
          [
            {
              "tag": "90",
              "cid": user.value.cid,
              "store_type_id": cmb_store_type_id_d.value,
              "fdate": txt_fdate_d.text,
              "tdate": txt_tdate_d.text
            }
          ],
          list_grn_master_view,
          (x) => ModelGrnMAsterView.fromJson(x));
      if (list_grn_master_view.isNotEmpty) {
        list_grn_master_view_temp
          ..clear()
          ..addAll(list_grn_master_view);
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

  void search_grn() {
    list_grn_master_view_temp
      ..clear()
      ..addAll(list_grn_master_view.where((f) =>
          f.grnNo!.toUpperCase().contains(txt_search_d.text.toUpperCase()) ||
          f.grnDate!.toUpperCase().contains(txt_search_d.text.toUpperCase()) ||
          (f.supName ?? '')
              .toUpperCase()
              .contains(txt_search_d.text.toUpperCase()) ||
          (f.remarks ?? '')
              .toUpperCase()
              .contains(txt_search_d.text.toUpperCase())));
  }
}

// ignore: must_be_immutable
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
