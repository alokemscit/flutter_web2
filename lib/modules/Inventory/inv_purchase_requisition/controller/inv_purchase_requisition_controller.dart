// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element, deprecated_member_use, library_private_types_in_public_api, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:pdf/widgets.dart';
import 'package:web_2/component/widget/custom_snakbar.dart';
import 'package:web_2/core/config/const.dart';

 
import '../../../../component/custom_pdf_report_generator.dart';
import '../../inv_item_master/model/inv_model_item_master.dart';
import '../model/inv_model_pr_master.dart';
import 'package:pdf/widgets.dart' as pw;

class InvPurchaseRequisitionController extends GetxController
    with MixInController {
  final TextEditingController txt_date = TextEditingController();
  final TextEditingController txt_note = TextEditingController();
  final TextEditingController txt_search_name = TextEditingController();
  final TextEditingController txt_search_qty = TextEditingController();
  final TextEditingController txt_search_note = TextEditingController();
  final FocusNode focusnode_search = FocusNode();
  final FocusNode focusnode_search_down = FocusNode();
  final FocusNode focusnode_qty = FocusNode();
  final FocusNode focusnode_note = FocusNode();
  var selectedIndex = ''.obs;
  late Font? font;

  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_storetypeID = ''.obs;
  var list_priority = <ModelCommonMaster>[].obs;
  var cmb_priorityID = '1'.obs;
  var list_item_master = <ModelItemMaster>[].obs;
  var list_item_temp = <ModelItemMaster>[].obs;
  var list_temp = <_item>[].obs;
  var isShowSearch = false.obs;
  var selectedItem = ModelItemMaster().obs;

  var list_pr = <ModelPReqMaster>[].obs;

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);

    if (isCheckCondition(
        list_temp.isEmpty, dialog, 'No Item listed for save Requisition'))
      return;

    if (isCheckCondition(
        cmb_priorityID.value == '', dialog, 'Please Select Priority!')) return;
    List<Map<String, dynamic>> list = [];
    list_temp.forEach((v) {
      list.add({"id": v.id.toString(), "qty": v.qty, "rem": v.rem});
    });
    // print(jsonEncode(list));

    //@cid int,@eid int,@str_type_id int,@str text,@rem nvarchar(250),@priority_id
    ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
      {
        "tag": "65",
        "cid": user.value.cid,
        "eid": user.value.uid,
        "str_type_id": cmb_storetypeID.value,
        "str": jsonEncode(list),
        "rem": txt_note.text,
        "priority_id": cmb_priorityID.value,
        "prdate": txt_date.text
      }
    ]);
    if (s.status == '1') {
      dialog
        ..dialogType = DialogType.success
        ..message = s.msg!
        ..show()
        ..onTap = () async {
          list_pr.clear();
          loader.show();
          var x = await api.createLead([
            {"tag": "66", "prid": s.id}
          ]);

          if (checkJson(x)) {
            list_pr.addAll(x.map((e) => ModelPReqMaster.fromJson(e)));
           
          } else {
            loader.close();
          }
        };
    }
  }

  void minus(_item e) {
    selectedItem.value = ModelItemMaster();
    // isShowSearch.value = false;
    if (list_temp.where((f) => f.id == e.id).isNotEmpty) {
      var x = list_temp.where((f) => f.id == e.id).first.qty.toString();
      var y = (double.parse(x) - 1);
      if (y > 0) {
        list_temp.where((f) => f.id == e.id).first.qty = y.toString();
        list_temp.refresh();
      } else {
        list_temp.remove(e);
      }
    }
  }

  void add(ModelItemMaster e) {
    // isShowSearch.value = false;

    if (list_temp.where((f) => f.id == e.id).isNotEmpty) {
      var x = list_temp.where((f) => f.id == e.id).first.qty.toString();
      var y = (double.parse(x) + 1).toString();
      list_temp.where((f) => f.id == e.id).first.qty = y;
      list_temp.refresh();
      selectedItem.value = ModelItemMaster();
    } else {
      list_temp.insert(
          0,
          _item(
              id: e.id,
              Generic: e.genName,
              code: e.code,
              company: e.conName,
              group: e.grpName,
              name: e.name,
              qty: '1',
              rem: '',
              subgroup: e.sgrpName,
              unit: e.unitName));
      selectedItem.value = ModelItemMaster();
    }
  }

  void delete(_item f) {
    // isShowSearch.value = false;
    selectedItem.value = ModelItemMaster();
    list_temp.remove(f);
  }

  void remKeyEnter() {
    if (selectedItem.value.id == null) {
      CustomSnackbar(
          context: context,
          message: 'No Item Selected!',
          type: MsgType.warning);
      focusnode_search.requestFocus();
      return;
    }
    if ((double.parse(txt_search_qty.text == '' ? '0' : txt_search_qty.text)) <=
        0) {
      CustomSnackbar(
          context: context,
          message: 'Quantity required!',
          type: MsgType.warning);
      focusnode_qty.requestFocus();
      return;
    }
    if (list_temp.where((f) => f.id == selectedItem.value.id).isNotEmpty) {
      CustomSnackbar(
          context: context,
          message: 'Item already selected!',
          type: MsgType.warning);
      focusnode_search.requestFocus();
      return;
    }

    list_temp.insert(
        0,
        _item(
            id: selectedItem.value.id,
            Generic: selectedItem.value.genName,
            code: selectedItem.value.code,
            company: selectedItem.value.conName,
            group: selectedItem.value.grpName,
            name: selectedItem.value.name,
            qty: txt_search_qty.text,
            rem: txt_search_note.text,
            subgroup: selectedItem.value.sgrpName,
            unit: selectedItem.value.unitName));
    txt_search_note.text = '';
    txt_search_name.text = '';
    txt_search_qty.text = '';
    selectedItem.value = ModelItemMaster();
    selectedIndex.value = '';
    list_item_temp.clear();

    list_item_temp.addAll(
        list_item_master.where((e) => e.storeTypeId == cmb_storetypeID.value));

    focusnode_search.requestFocus();
  }

  void qtyKeyEnter() {
    if ((double.parse(txt_search_qty.text == '' ? '0' : txt_search_qty.text)) <=
        0) {
      CustomSnackbar(
          context: context,
          message: 'Quantity required!',
          type: MsgType.warning);
      return;
    }
    if (selectedItem.value.id == null) {
      CustomSnackbar(
          context: context,
          message: 'No Item Selected!',
          type: MsgType.warning);
      focusnode_search.requestFocus();
      return;
    }
    if (list_temp.where((f) => f.id == selectedItem.value.id).isNotEmpty) {
      CustomSnackbar(
          context: context,
          message: 'Item already selected!',
          type: MsgType.warning);
      focusnode_search.requestFocus();
      return;
    }
    focusnode_note.requestFocus();
  }

  void searchKeyEnter() {
    if (selectedItem.value.id == null) {
      CustomSnackbar(
          context: context,
          message: 'No Item Selected!',
          type: MsgType.warning);
      return;
    }
    if (list_temp.where((f) => f.id == selectedItem.value.id).isNotEmpty) {
      CustomSnackbar(
          context: context,
          message: 'Item already selected!',
          type: MsgType.warning);
      return;
    }
    txt_search_name.text = selectedItem.value.name!;
    focusnode_qty.requestFocus();
  }

  void handleKeyPress_search(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowDown &&
        list_item_temp.isNotEmpty) {
      final currentIndex = int.tryParse(selectedIndex.value) ?? -1;
      final nextIndex = currentIndex + 1;

      if (nextIndex < list_item_temp.length) {
        selectedIndex.value = nextIndex.toString();
        selectedItem.value = list_item_temp[nextIndex];
      }
    }
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowUp &&
        list_item_temp.isNotEmpty) {
      final currentIndex = int.tryParse(selectedIndex.value) ?? 1;
      final nextIndex = currentIndex - 1;

      if (nextIndex < list_item_temp.length && nextIndex != -1) {
        selectedIndex.value = nextIndex.toString();
        selectedItem.value = list_item_temp[nextIndex];
      }
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      final currentPosition = txt_search_name.selection.baseOffset;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        txt_search_name.selection = TextSelection.fromPosition(
          TextPosition(offset: currentPosition),
        );
      });
      return;
    }
  }

  void search() {
    txt_search_note.text = '';
    txt_search_note.text = '';
    selectedItem.value = ModelItemMaster();
    selectedIndex.value = '';
    list_item_temp.clear();

    list_item_temp.addAll(list_item_master.where((e) =>
        e.storeTypeId == cmb_storetypeID.value &&
        (e.name!.toUpperCase().contains(txt_search_name.text.toUpperCase()) ||
            e.genName!
                .toUpperCase()
                .contains(txt_search_name.text.toUpperCase()) ||
            e.grpName!
                .toUpperCase()
                .contains(txt_search_name.text.toUpperCase()) ||
            e.sgrpName!
                .toUpperCase()
                .contains(txt_search_name.text.toUpperCase()) ||
            e.code!
                .toUpperCase()
                .contains(txt_search_name.text.toUpperCase()))));
  }

  void showSearchContainer() {
    dialog = CustomAwesomeDialog(context: context);
    isShowSearch.value = false;
    if (isCheckCondition(
        cmb_storetypeID.value == '', dialog, 'Please Select Store Type')) {
      return;
    }
    isShowSearch.value = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //FocusScope.of(context).requestFocus(focusnode_search);
      focusnode_search.requestFocus();
    });
  }

  void setStoreType(String id) {
    selectedItem.value = ModelItemMaster();
    cmb_storetypeID.value = id;
    cmb_priorityID.value = '1';
    txt_date.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    txt_note.text = '';
    txt_search_name.text = '';
    txt_search_note.text = '';
    txt_search_qty.text = '';
    list_temp.clear();
    isShowSearch.value = false;
    list_item_temp.clear();
    if (id != '') {
      list_item_temp.addAll(list_item_master.where((e) => e.storeTypeId == id));
    }
  }

  @override
  void onInit() async {
    api = data_api2();
    isLoading.value = true;
    font = await CustomLoadFont('assets/fonts/roboto/Roboto-Regular.ttf');
    user.value = await getUserInfo();
    if (user.value.uid == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Login Required';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);
      //  print(x);
      if (checkJson(x)) {
        list_storeTypeList
            .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
      }
      x = await api.createLead([
        {
          "tag": "64",
        }
      ]);
      // print(x);
      if (checkJson(x)) {
        list_priority.addAll(x.map((e) => ModelCommonMaster.fromJson(e)));
      }
      x = await api.createLead([
        {"tag": "63", "cid": user.value.cid}
      ]);
      // print(x);
      if (checkJson(x)) {
        list_item_master.addAll(x.map((e) => ModelItemMaster.fromJson(e)));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  void rptPrint() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    var x = await api.createLead([
      {"tag": "66", "prid": "1"}
    ]);
    // print(x);
    if (checkJson(x)) {
      list_pr.addAll(x.map((e) => ModelPReqMaster.fromJson(e)));

       CustomPDFGenerator(
                font: font,
                user: user.value,
                loader: loader,
                header: [
                 
                ],
                body: [
                  pwGenerateTable(
            [30, 100, 40, 60, 60, 60, 40],
             [
                pwTableColumnHeader('Code', font),
                pwTableColumnHeader('Item Name', font),
                pwTableColumnHeader('Unit', font),
                pwTableColumnHeader('Generic', font),
                pwTableColumnHeader('Sub Group', font),
                pwTableColumnHeader('Remarks', font),
                pwTableColumnHeader('Rq. Qty', font, pw.Alignment.center),
              ],
            
            list_pr
                .map((f) => pw.TableRow(children: [
                      pwTableCell(f.code ?? '', font),
                      pwTableCell(f.name ?? '', font),
                      pwTableCell(f.unitName ?? '', font),
                      pwTableCell(f.genName ?? '', font),
                      pwTableCell(f.sgrpName ?? '', font),
                      pwTableCell(f.rem ?? '', font),
                      pwTableCell(f.reqQty ?? '', font, pw.Alignment.center),
                    ]))
                .toList()),
                ],
                footer: []).ShowReport();
    } else {
      loader.close();
    }
  }
}

class _item {
  String? id;
  String? code;
  String? name;
  String? unit;
  String? group;
  String? subgroup;
  String? Generic;
  String? company;
  String? qty;
  String? rem;
  _item({
    this.id,
    this.code,
    this.name,
    this.unit,
    this.group,
    this.subgroup,
    this.Generic,
    this.company,
    this.qty,
    this.rem,
  });
}


