// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:pdf/widgets.dart';
import 'package:web_2/component/custom_pdf_report_generator.dart';
import 'package:web_2/core/config/const.dart';

import '../../inv_purchase_requisition/model/inv_model_pr_master.dart';
import '../model/inv_model_pr_for_approval.dart';
import '../model/inv_model_pr_status_master.dart';

class InvPRApprovalController extends GetxController with MixInController {
  var cmb_store_typeID = ''.obs;
  var cmb_store_typeID_history = ''.obs;
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_fdate_history = TextEditingController();
  final TextEditingController txt_tdate_history = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  final TextEditingController txt_note = TextEditingController();
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var list_pr_for_app_master = <ModelPRforApproval>[].obs;
  var list_pr_for_app_temp = <ModelPRforApproval>[].obs;
  var selectedData = ModelPRforApproval().obs;

  var onHoverID = ''.obs;
  late Font? font;
  var list_item_details = <_ItemDetails>[].obs;
  var list_item_details_main = <ModelPReqMaster>[].obs;

  var list_PR_Prv_main = <ModelPReqStatus>[].obs;
  var list_PR_Prv_temp = <ModelPReqStatus>[].obs;

  void showPrvReport(String id) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      var x = await api.createLead([
        {"tag": "66", "prid": id}
      ]);
      loader.close();
      if (checkJson(x)) {
        list_item_details_main.clear();
        list_item_details_main
            .addAll(x.map((e) => ModelPReqMaster.fromJson(e)));
        if (list_item_details_main.isNotEmpty) {
          loader.show();
          Future.delayed(const Duration(microseconds: 10), () {
            showReport(() {
              list_pr_for_app_master
                  .removeWhere((e) => e.id == selectedData.value.id);
              list_pr_for_app_temp
                  .removeWhere((e) => e.id == selectedData.value.id);
              selectedData.value = ModelPRforApproval();
              // print('object');
              loader.close();
            });
          });
        }
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void showHistory() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (isCheckCondition(cmb_store_typeID_history.value == '', dialog,
        'Please select Store Type')) return;
    if (isCheckCondition(
        !isValidDateRange(txt_fdate_history.text, txt_tdate_history.text),
        dialog,
        'Invalid date range!')) return;

    loader.show();
    list_PR_Prv_main.clear();
    list_PR_Prv_temp.clear();
    try {
      var x = await api.createLead([
        {
          "tag": "69",
          "cid": user.value.cid,
          "store_type_id": cmb_store_typeID_history.value,
          "fdate": txt_fdate_history.text,
          "tdate": txt_tdate_history.text
        }
      ]);
      // print(x);
      loader.close();
      if (checkJson(x)) {
        list_PR_Prv_main.addAll(x.map((e) => ModelPReqStatus.fromJson(e)));
        list_PR_Prv_temp.addAll(list_PR_Prv_main);
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void loadItemDetails(String prid) async {
    txt_note.text = '';
    list_item_details.clear();
    list_item_details_main.clear();
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    try {
      var x = await api.createLead([
        {"tag": "66", "prid": prid}
      ]);
      loader.close();
      if (checkJson(x)) {
        list_item_details_main
            .addAll(x.map((e) => ModelPReqMaster.fromJson(e)));
        list_item_details_main.forEach((f) {
          list_item_details.add(_ItemDetails(
              id: f.itemId,
              code: f.code,
              name: f.name,
              group: f.grpName,
              subGroup: f.sgrpName,
              unit: f.unitName,
              genaric: f.genName,
              remarks: f.rem,
              prQty: f.reqQty,
              appQty: TextEditingController(text: f.reqQty)));
        });
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void prApprove_cancel(bool isCancel) async {
    api = data_api2();
    //@eid int,@pr_id int,@str nvarchar(max),@rem nvarchar(150),@isCancel tinyint
    loader = CustomBusyLoader(context: context);
    // loader.show();
    if (isCheckCondition(
        list_item_details.isEmpty, dialog, 'No Item Found for approve P.R')) {
      // loader.close();
      return;
    }
    List<Map<String, dynamic>> list = [];
    list_item_details.forEach((f) {
      list.add({
        "id": f.id.toString(),
        "qty": f.appQty!.text == '' ? "0" : f.appQty!.text
      });
    });
    var t = jsonEncode(list);
    // print({
    //   "tag": "68",
    //   "eid": user.value.uid,
    //   "pr_id": selectedData.value.id!.toString(),
    //   "str": t,
    //   "rem": txt_note.text,
    //   "isCancel": isCancel ? "1" : "0"
    // });
    //return;
    try {
      ModelStatus st = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "68",
          "eid": user.value.uid,
          "pr_id": selectedData.value.id!.toString(),
          "str": t,
          "rem": txt_note.text,
          "isCancel": isCancel ? "1" : "0"
        }
      ]);
      loader.close();
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            try {
              loader.show();
              var x = await api.createLead([
                {"tag": "66", "prid": selectedData.value.id.toString()}
              ]);
              loader.close();
              if (checkJson(x)) {
                list_item_details_main.clear();
                list_item_details_main
                    .addAll(x.map((e) => ModelPReqMaster.fromJson(e)));
                if (list_item_details_main.isNotEmpty) {
                  loader.show();
                  Future.delayed(const Duration(microseconds: 10), () {
                    showReport(() {
                      list_pr_for_app_master
                          .removeWhere((e) => e.id == selectedData.value.id);
                      list_pr_for_app_temp
                          .removeWhere((e) => e.id == selectedData.value.id);
                      selectedData.value = ModelPRforApproval();
                      // print('object');
                      loader.close();
                    });
                  });
                }
              }
            } catch (e) {
              loader.close();
              dialog
                ..dialogType = DialogType.error
                ..message = e.toString()
                ..show();
            }
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

  void setPR(ModelPRforApproval f) async {
    selectedData.value = f;
    loadItemDetails(f.id!.toString());
    txt_note.text = '';
  }

  void setUndoSelectData() {
    selectedData.value = ModelPRforApproval();
    txt_note.text = '';
  }

  @override
  void onInit() async {
    api = data_api2();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    font = await CustomLoadFont(appFontPathLato);
    try {
      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);
      //  print(x);
      if (checkJson(x)) {
        list_storeTypeList
            .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
      }

      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }

  void show() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    list_pr_for_app_master.clear();
    list_pr_for_app_temp.clear();
    if (isCheckCondition(
        cmb_store_typeID.value == '', dialog, 'Please select Store Type!'))
      return;
    if (isCheckCondition(!isValidDateRange(txt_fdate.text, txt_tdate.text),
        dialog, 'Invalid date rande')) return;
    loader.show();
    // print({
    //   "tag": "67",
    //   "cid": user.value.cid,
    //   "store_type_id": cmb_store_typeID.value,
    //   "fdate": txt_fdate.text,
    //   "tdate": txt_tdate.text
    // });
    try {
      var x = await api.createLead([
        {
          "tag": "67",
          "cid": user.value.cid,
          "store_type_id": cmb_store_typeID.value,
          "fdate": txt_fdate.text,
          "tdate": txt_tdate.text
        }
      ]);
      loader.close();
      if (checkJson(x)) {
        list_pr_for_app_master
            .addAll(x.map((e) => ModelPRforApproval.fromJson(e)));
        list_pr_for_app_temp.addAll(list_pr_for_app_master);
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void showReport(Function()? fun) {
    CustomPDFGenerator(
        font: font,
        header: [
          pwTextOne(font, '', user.value.cname!, 12),
          pwHeight(4),
          pwTextOne(font, '', 'Purchase Requisition Report', 9),
          pwHeight(8),
          pwText2Col(font, 'P.R. No: ', list_item_details_main.first.prNo ?? '',
              'P.R Date: ', list_item_details_main.first.prDate ?? ''),
          pwHeight(4),
          (list_item_details_main.first.appDate != '' ||
                  list_item_details_main.first.cancelDate != '')
              ? pwText2Col(
                  font,
                  list_item_details_main.first.appBy != '0'
                      ? 'Approved By : '
                      : 'Canceled By : ',
                  list_item_details_main.first.appBy != '0'
                      ? list_item_details_main.first.appByName ?? ''
                      : list_item_details_main.first.cancelByName ?? '',
                  list_item_details_main.first.appBy != '0'
                      ? 'Approved Date : '
                      : 'Canceled Date : ',
                  list_item_details_main.first.appBy != '0'
                      ? list_item_details_main.first.appDate ?? ''
                      : list_item_details_main.first.cancelDate ?? '')
              : pwHeight(0),
          (list_item_details_main.first.appDate != '' ||
                  list_item_details_main.first.cancelDate != '')
              ? pwHeight(4)
              : pwHeight(0),
          pwTextOne(
              font,
              'Status : ',
              list_item_details_main.first.appBy != '0'
                  ? 'Approved'
                  : list_item_details_main.first.cancelDate != ''
                      ? 'Canceled'
                      : 'Not Approved',
              9),
        ],
        footer: [
          pwTextOne(font, 'Printed By :', user.value.name ?? '', 9,
              pwMainAxisAlignmentStart),
        ],
        body: [
          pwGenerateTable([
            20,
            60,
            20,
            20,
            20
          ], [
            pwTableCell('Code', font),
            pwTableCell('Name', font),
            pwTableCell('Unit', font),
            pwTableCell('Sub.Group', font),
            pwTableCell('Req. Qty', font, pwAligmentRight),
            pwTableCell('App. Qty', font, pwAligmentRight),
          ], [
            ...list_item_details_main.map((f) => pwTableRow([
                  pwTableCell(f.code!, font),
                  pwTableCell(f.name!, font),
                  pwTableCell(f.unitName!, font),
                  pwTableCell(f.sgrpName!, font),
                  pwTableCell(f.reqQty!, font, pwAligmentRight),
                  pwTableCell(f.appQty!, font, pwAligmentRight),
                ]))
          ])
        ],
        fun: () {
          if (fun != null) {
            fun();
          }
          // loader.close();
        }).ShowReport();
  }
}

class _ItemDetails {
  String? id;
  String? code;
  String? name;
  String? unit;
  String? genaric;
  String? group;
  String? subGroup;
  TextEditingController? appQty;
  String? prQty;
  String? remarks;
  _ItemDetails(
      {this.id,
      this.code,
      this.name,
      this.unit,
      this.group,
      this.subGroup,
      this.prQty,
      this.appQty,
      this.remarks,
      this.genaric});
}
