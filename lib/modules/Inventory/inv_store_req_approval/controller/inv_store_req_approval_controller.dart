// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'dart:convert';

import 'package:web_2/core/config/const.dart';

import '../../../../component/custom_pdf_report_generator.dart';
import '../../inv_store_requisition/model/inv_model_requisition_master.dart';
import '../../inv_store_requisition/model/inv_requisition_details.dart';
import '../../shared/inv_function.dart';

class InvStoreRequisitionController extends GetxController
    with MixInController {
  final TextEditingController txt_search = TextEditingController();
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  var list_store_type = <ModelCommonMaster>[].obs;
  var cmb_store_typeID = ''.obs;

  var list_req_details = <ModelRequisitionDetails>[].obs;
  var list_req_master = <ModelRequisitionMaster>[].obs;
  var list_req_master_temp = <ModelRequisitionMaster>[].obs;
  var SelectedRequisition = ModelRequisitionMaster().obs;
  var list_temp = <_item>[].obs;
  var cmb_store_dialog_typeID = ''.obs;
  var cmb_dialog_storeID = ''.obs;
  var list_users_store_dialog = <ModelCommonMaster>[].obs;
  late VoidCallback showDialogMethod;

  bool b = true;

  void toolEvent(ToolMenuSet v) {
    if (b) {
      b = false;
      if (v == ToolMenuSet.undo) {
        undo();
      }
      if (v == ToolMenuSet.approve) {
        approve_cancel(false);
      }
      if (v == ToolMenuSet.cancel) {
        approve_cancel(true);
      }
      if (v == ToolMenuSet.print) {
        reportView(SelectedRequisition.value.reqId.toString());
      }
      if (v == ToolMenuSet.show) {
        showDialogMethod();
      }

      Future.delayed(const Duration(milliseconds: 300), () {
        b = true;
      });
    }
  }

  void undo() {
    list_temp.clear();
    SelectedRequisition.value = ModelRequisitionMaster();
    mToolEnableDisable(list_tools, [
      ToolMenuSet.show
    ], [
      ToolMenuSet.undo,
      ToolMenuSet.approve,
      ToolMenuSet.cancel,
      ToolMenuSet.print,
      ToolMenuSet.show
    ]);
  }

  void editForApproval(ModelRequisitionMaster f) async {
    list_temp.clear();
    SelectedRequisition.value = f;
    mToolEnableDisable(list_tools, [
      ToolMenuSet.undo,
      ToolMenuSet.approve,
      ToolMenuSet.cancel,
      ToolMenuSet.print,
    ], [
      ToolMenuSet.show
    ]);
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    list_req_details.clear();
    try {
      loader.show();
      await mLoadModel_All(
          api,
          [
            {"tag": "2", "reqid": f.reqId!.toString()}
          ],
          list_req_details,
          (x) => ModelRequisitionDetails.fromJson(x),
          'inv');
      list_req_details.forEach((f) {
        list_temp.add(_item(
            id: f.itemId!.toString(),
            code: f.code,
            name: f.itemName,
            type: f.subgroupName,
            unit: f.unitName,
            req_qty: f.reqQty.toString(),
            qty: TextEditingController(text: f.reqQty.toString()),
            focusNode: FocusNode()));
      });

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void loadRequisition() async {
    SelectedRequisition.value = SelectedRequisition();
    list_req_master.clear();
    list_req_master_temp.clear();
    list_req_details.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      loader.show();
      await mLoadModel_All(
          api,
          [
            {
              "tag": "4",
              "cid": user.value.cid,
              "store_type_id": cmb_store_typeID.value
            }
          ],
          list_req_master,
          (x) => ModelRequisitionMaster.fromJson(x),
          'inv');
      list_req_master_temp.addAll(list_req_master);

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
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    font = await CustomLoadFont(appFontPathOpenSans);
    try {
      //  await mLoadModel(api, parameter, listObject, fromJson)
      await Inv_Get_Store_Type(api, list_store_type, user.value.cid!);

      // print(list_item_temp.length);

      // list_tools.value = Custom_Tool_List();
      mToolEnableDisable(list_tools, [
        ToolMenuSet.show
      ], [
        ToolMenuSet.save,
        ToolMenuSet.undo,
      ]);
      //_new();
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    //isLoading
    super.onInit();
  }

  void textChange(_item f) {
    if ((double.tryParse(f.req_qty ?? '0') ?? 0) <
        (double.tryParse(f.qty?.text ?? '0') ?? 0)) {
      f.qty?.text = f.req_qty!;
    }
  }

  void next_line_qty(_item f) {
    var index = list_temp.indexOf(f);
    if (index != -1 && index + 1 < list_temp.length) {
      var el = list_temp.elementAt(index + 1);
      FocusScope.of(context).requestFocus(el.focusNode);
    }
  }

  void approve_cancel(bool isCancel) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);

    if (isCheckCondition(
        list_temp.isEmpty,
        dialog,
        isCancel
            ? 'No Item Found For Cancel!'
            : 'No Item Found For Approve!')) {
      return;
    }
    List<Map<String, dynamic>> list = list_temp
        .map((f) => {"id": f.id, "qty": f.qty!.text == '' ? '0' : f.qty!.text})
        .toList();

    try {
// @eid int, @req_id int, @str varchar(max), @is_cancel int
      ModelStatus s = await commonSaveUpdate_all(
          api,
          loader,
          dialog,
          [
            {
              "tag": "5",
              "eid": user.value.uid,
              "req_id": SelectedRequisition.value.reqId,
              "str": jsonEncode(list),
              "is_cancel": isCancel ? "1" : "0"
            }
          ],
          'inv');

      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () async {
            list_req_master
                .removeWhere((e) => e.reqId == SelectedRequisition.value.reqId);
            list_req_master_temp
              ..clear()
              ..addAll(list_req_master);
            reportView(SelectedRequisition.value.reqId.toString());
            undo();
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

  void reportView(
    String rid,
  ) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    list_req_details.clear();
    try {
      loader.show();
      await mLoadModel_All(
          api,
          [
            {"tag": "2", "reqid": rid}
          ],
          list_req_details,
          (x) => ModelRequisitionDetails.fromJson(x),
          'inv');

      if (list_req_details.isEmpty) {
        loader.close();
        return;
      }
      ModelRequisitionDetails f = list_req_details.first;
      CustomPDFGenerator(
        font: font,
        header: [
          pwTextOne(font, 'Store Requisition Report', ''),
          pwHeight(4),
          pwText2Col(font, 'Store Type : ', f.storeTypeName ?? '',
              "Store Name : ", f.storeName ?? ''),
          pwHeight(4),
          pwText2Col(font, 'Req. No : ', f.reqNo ?? '', "Req. Date : ",
              f.reqDqte ?? ''),
          pwHeight(4),
          pwText2Col(font, 'Req. By : ', f.createdByName ?? '', "Status : ",
              f.currentStatus ?? ''),
          pwTextOne(font, 'Priority : ', f.priorityName ?? '', 9,
              pwMainAxisAlignmentStart),
        ],
        footer: [
          f.currentStatusId == 2
              ? pwText2Col(font, 'Approved By : ', f.appByName ?? '',
                  "App. Date : ", f.appDate ?? '')
              : pwHeight(0),
          pwTextOne(font, 'Printed By : ', user.value.name ?? '', 9,
              pwMainAxisAlignmentStart),
        ],
        body: [
          pwGenerateTable([
            20,
            60,
            30,
            30,
            20,
            20
          ], [
            pwTableColumnHeader('Code', font),
            pwTableColumnHeader('Item Name', font),
            pwTableColumnHeader('Item Type', font),
            pwTableColumnHeader('Unit', font, pwAligmentCenter),
            pwTableColumnHeader('Req.Qty', font, pwAligmentCenter),
            pwTableColumnHeader('App.Qty', font, pwAligmentCenter),
          ], [
            ...list_req_details.map((a) => pwTableRow([
                  pwTableCell(a.code ?? '', font),
                  pwTableCell(a.itemName ?? '', font),
                  pwTableCell(a.subgroupName ?? '', font),
                  pwTableCell(a.unitName ?? '', font, pwAligmentCenter),
                  pwTableCell(
                      (a.reqQty ?? 0).toString(), font, pwAligmentCenter),
                  pwTableCell(
                      (a.appQty ?? 0).toString(), font, pwAligmentCenter)
                ]))
          ])
        ],
        fun: () {
          loader.close();
        },
      ).ShowReport();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  
  void user_store_dialog() async {
    list_users_store_dialog.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      await Inv_Get_Users_Store(api, list_users_store_dialog, user.value.cid!,
          cmb_store_dialog_typeID.value, user.value.uid!);
      // //  print(list_user_store.list_temp.length);

      // list_users_store_dialog.refresh();
      // print(list_users_store_dialog.length);
      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

 
  void view_req_master() async {
    list_req_master.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      loader.show();
      //@cid int=12, @store_type_id int=2, @store_id int=4, @fdate varchar(10)='01/09/2024', @tdate varchar(10)='01/11/2024'
      await mLoadModel_All(
          api,
          [
            {
              "tag": "3",
              "cid": user.value.cid,
              "store_type_id": cmb_store_dialog_typeID.value,
              "store_id": cmb_dialog_storeID.value,
              "fdate": txt_fdate.text,
              "tdate": txt_tdate.text
            },
          ],
          list_req_master,
          (x) => ModelRequisitionMaster.fromJson(x),
          "inv");
      // print(list_req_master.length);

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }
}

class _item {
  String? id;
  String? code;
  String? name;
  String? type;
  String? unit;
  String? req_qty;
  TextEditingController? qty;
  FocusNode? focusNode;
  _item(
      {this.id,
      this.code,
      this.name,
      this.type,
      this.unit,
      this.req_qty,
      this.qty,
      this.focusNode});
}
