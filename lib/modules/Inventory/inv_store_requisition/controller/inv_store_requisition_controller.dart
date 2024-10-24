// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:web_2/component/custom_pdf_report_generator.dart';

import 'package:web_2/core/config/const.dart';

import 'package:web_2/modules/Inventory/shared/inv_function.dart';

import '../../../../component/widget/custom_snakbar.dart';

import '../../inv_item_master/model/inv_model_item_master.dart';
import '../model/inv_model_requisition_master.dart';
import '../model/inv_requisition_details.dart';

class InvSoreRequisitionController extends GetxController with MixInController {
  final TextEditingController txt_remarks = TextEditingController();
  final TextEditingController txt_date = TextEditingController();

  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();

  var list_store_type = <ModelCommonMaster>[].obs;
  var list_users_store = <ModelCommonMaster>[].obs;
  var list_users_store_dialog = <ModelCommonMaster>[].obs;
  var list_priority = <ModelCommonMaster>[].obs;

  var list_item_master = <ModelItemMaster>[].obs;
  var list_item_temp = <ModelItemMaster>[].obs;
  var list_temp = <_item>[].obs;

  var cmb_store_typeID = ''.obs;
  var cmb_storeID = ''.obs;
  var cmb_store_dialog_typeID = ''.obs;
  var cmb_dialog_storeID = ''.obs;

  var cmb_priorityID = ''.obs;
  var list_req_details = <ModelRequisitionDetails>[].obs;
  var list_req_master = <ModelRequisitionMaster>[].obs;

  late VoidCallback showDialogMethod;
  bool b = true;
  void toolsEvent(ToolMenuSet v) {
    if (b) {
      b = false;
      if (v == ToolMenuSet.undo) {
        setUndo();
      }
      if (v == ToolMenuSet.file) {
        if (cmb_store_typeID.value == '') {
          dialog = CustomAwesomeDialog(context: context);
          dialog
            ..dialogType = DialogType.error
            ..message = 'Please select Store Type!'
            ..show();
          b = true;
          return;
        }

        mToolEnableDisable(
            list_tools,
            [ToolMenuSet.save, ToolMenuSet.undo, ToolMenuSet.show],
            [ToolMenuSet.file]);
        list_temp.clear();
        _new();
      }
      if (v == ToolMenuSet.save) {
        save();
      }
      if (v == ToolMenuSet.show) {
        // if (showDialogMethod != null) {
        list_req_master.clear();
        showDialogMethod();
        //  }
      }

      Future.delayed(const Duration(milliseconds: 300), () {
        b = true;
      });
    }
  }

  void setUndo() {
    mToolEnableDisable(
        list_tools, [ToolMenuSet.file], [ToolMenuSet.save, ToolMenuSet.undo]);
    cmb_priorityID.value = '';
    cmb_storeID.value = '';
    txt_date.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    txt_remarks.text = '';
    list_temp.clear();
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

  void user_store() async {
    list_users_store.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      await Inv_Get_Users_Store(api, list_users_store, user.value.cid!,
          cmb_store_typeID.value, user.value.uid!);
      // //  print(list_user_store.list_temp.length);

      list_users_store.refresh();
      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void addNew() {
    _new();
  }

  void setStoreType() {
    list_item_temp
      ..clear()
      ..addAll(list_item_master
          .where((f) => f.storeTypeId == cmb_store_typeID.value)
          .toList());
    list_temp.clear();
    mToolEnableDisable(
        list_tools,
        [ToolMenuSet.save, ToolMenuSet.undo, ToolMenuSet.show],
        [ToolMenuSet.file]);
    list_temp.clear();
    _new();
  }

  void _new() {
    list_temp.add(_item(
        generic: '',
        id: "",
        name: '',
        qty: TextEditingController(),
        type: '',
        unit: '',
        qty_f: FocusNode(),
        code: '',
        field: CustomSearchableDropdown<ModelItemMaster>(
          onTextChenge: (v) {},
          callback: (ModelItemMaster c) {
            return Text(c.name ?? '');
          },
          suggestionList: (String query) {
            return list_item_temp
                .where((item) => (item.name ?? '')
                    .toUpperCase()
                    .contains(query.toUpperCase()))
                .toList();
          },
          onSelected: (ModelItemMaster v) {
            if (list_temp.where((e) => e.id == v.id).isNotEmpty) {
              CustomSnackbar(
                  context: context,
                  message: 'this Item Already Axists',
                  type: MsgType.warning);
              return;
            }

            var x = list_temp.last;
            x.field!.controller.text = v.name ?? '';
            x.id = v.id;
            x.code = v.code ?? '';
            x.name = v.name ?? '';
            x.type = v.stypeName ?? '';
            x.unit = v.unitName ?? '';
            x.generic = v.genName ?? '';
            //  print(x.qty!.text);
            list_temp.refresh();

            x.qty_f!.requestFocus();
          },
          controller: TextEditingController(),
          focusNode: FocusNode(),
        )));
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
      await Inv_Get_priority_master(api, list_priority);
      await Inv_Get_Item_Master_All(api, list_item_master, user.value.cid!);
      list_item_temp.addAll(list_item_master);
      // print(list_item_temp.length);

      list_tools.value = Custom_Tool_List();
      mToolEnableDisable(list_tools, [ToolMenuSet.file, ToolMenuSet.show],
          [ToolMenuSet.save, ToolMenuSet.undo, ToolMenuSet.show]);
      //_new();
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    //isLoading
    super.onInit();
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);

    bool b = true;
    if (isCheckCondition(
        cmb_store_typeID.value == '', dialog, 'Please select store type!'))
      return;
    if (isCheckCondition(
        cmb_storeID.value == '', dialog, 'Please select store/Sub store!'))
      return;
    if (isCheckCondition(
        cmb_priorityID.value == '', dialog, 'Please select priority!')) return;
    if (isCheckCondition(list_temp.isEmpty, dialog, 'No Item selected!'))
      return;

    List<Map<String, dynamic>> list = [];
    for (var i = 0; i < list_temp.length; i++) {
      // print(list_temp[i].qty!.text);
      if (list_temp[i].qty!.text == '' || list_temp[i].id == '') {
        b = false;
        break;
      }
      list.add({"id": list_temp[i].id, "qty": list_temp[i].qty!.text});
    }
    if (isCheckCondition(!b, dialog, 'Item and quantity required!')) return;
    // loader.show();

    try {
      //@cid int,@eid int, @req_date varchar(10), @store_type_id int,@store_id int, @rem nvarchar(250),@priority_id int, @str
      ModelStatus s = await commonSaveUpdate_all(
          api,
          loader,
          dialog,
          [
            {
              "tag": "1",
              "cid": user.value.cid,
              "eid": user.value.uid,
              "req_date": txt_date.text,
              "store_type_id": cmb_store_typeID.value,
              "store_id": cmb_storeID.value,
              "rem": txt_remarks.text,
              "priority_id": cmb_priorityID.value,
              "str": jsonEncode(list)
            }
          ],
          'inv');
      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () async {
            try {
              reportView(s.id!);
              list_temp.clear();
              txt_remarks.text = '';
              mToolEnableDisable(list_tools, [ToolMenuSet.file],
                  [ToolMenuSet.undo, ToolMenuSet.save]);
            } catch (e) {
              // loader.close();
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

  @override
  void onClose() {
    //print('Call Dispose');
    // Dispose TextEditingControllers
    txt_remarks.dispose();
    txt_date.dispose();

    // Dispose FocusNodes and TextEditingControllers in list_temp
    // for (var item in list_temp) {
    //   item.qty?.dispose();
    //   item.qty_f?.dispose();
    //   item.field?.controller.dispose();
    //   item.field?.focusNode.dispose();
    // }
    list_temp.clear();

    super.dispose();
  }

  void deleteRow(_item f) {
    list_temp.removeWhere((e) => e.id == f.id);
    if (list_temp.isEmpty) {
      //mToolEnableDisable(list_tools, [ToolMenuSet.file], dtoolList)
      setUndo();
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
            20
          ], [
            pwTableColumnHeader('Code', font),
            pwTableColumnHeader('Item Name', font),
            pwTableColumnHeader('Item Type', font),
            pwTableColumnHeader('Unit', font, pwAligmentCenter),
            pwTableColumnHeader('Qty', font, pwAligmentCenter),
          ], [
            ...list_req_details.map((a) => pwTableRow([
                  pwTableCell(a.code ?? '', font),
                  pwTableCell(a.itemName ?? '', font),
                  pwTableCell(a.subgroupName ?? '', font),
                  pwTableCell(a.unitName ?? '', font, pwAligmentCenter),
                  pwTableCell(
                      (a.reqQty ?? 0).toString(), font, pwAligmentCenter),
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
}

class _item {
  String? id;
  String? code;
  String? name;
  String? generic;
  String? type;
  String? unit;
  TextEditingController? qty;

  FocusNode? qty_f;
  CustomSearchableDropdown? field;
  String? index;
  _item({
    this.id,
    this.name,
    this.generic,
    this.type,
    this.unit,
    this.qty,
    this.qty_f,
    this.code,
    this.field,
    this.index,
  });
}





// Widget SearchFieldForList<T>(
//         Widget Child,
//         FutureOr<List<T>?> Function(String) sugetionList,
//         Function(T) onSelected) =>
//     CupertinoTypeAheadField<T>(
//       focusNode: FocusNode(),
//       controller: TextEditingController(),
//       builder: (context, controller, focusNode) {
//         return CustomTextBox(
//           controller: controller,
//           focusNode: focusNode,
//           width: double.infinity,
//         );
//       },
//       decorationBuilder: (context, child) => Material(
//         type: MaterialType.card,
//         elevation: 4,
//         borderRadius: BorderRadius.circular(2),
//         child: child,
//       ),
//       itemBuilder: (context, c) {
//         return Row(
//           children: [
//             Flexible(
//                 child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//               child: Child,

//               // Text(
//               //   c.name!,
//               //   style: customTextStyle.copyWith(fontSize: 11),
//               // ),
//             ))
//           ],
//         );
//       },
//       suggestionsCallback: (v) {
//         return sugetionList(v);
//         // return list_item_master
//         //     .where((e) => e.name!.toUpperCase().contains(v.toUpperCase()))
//         //     .toList();
//       },
//       onSelected: (v) {
//         onSelected(v);
        //  var index = list_temp;
        // print(index);

        // if (list_temp.where((e) => e.id == v.id).isNotEmpty) {
        //   CustomSnackbar(
        //       context: context,
        //       message: 'this Item Already Axists',
        //       type: MsgType.warning);
        //   return;
        // }

        // var x = list_temp.last;
        // x.field!.controller!.text = v.name!;
        // x.id = v.id;
        // x.code = v.code ?? '';
        // x.name = v.name ?? '';
        // x.type = v.stypeName ?? '';
        // x.unit = v.unitName ?? '';
        // x.generic = v.genName ?? '';
        // list_temp.refresh();

        // x.qty_f!.requestFocus();
//       },
//     );
