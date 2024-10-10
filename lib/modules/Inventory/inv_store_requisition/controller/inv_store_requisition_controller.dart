// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'dart:async';

import 'package:intl/intl.dart';

import 'package:web_2/core/config/const.dart';

import 'package:web_2/modules/Inventory/shared/inv_function.dart';

import '../../../../component/widget/custom_snakbar.dart';

import '../../inv_item_master/model/inv_model_item_master.dart';

class InvSoreRequisitionController extends GetxController with MixInController {
  final TextEditingController txt_remarks = TextEditingController();
  final TextEditingController txt_date = TextEditingController();

  var list_tools = <CustomTool>[].obs;
  var list_store_type = <ModelCommonMaster>[].obs;
  var list_users_store = <ModelCommonMaster>[].obs;
  var list_priority = <ModelCommonMaster>[].obs;

  var list_item_master = <ModelItemMaster>[].obs;
  var list_item_temp = <ModelItemMaster>[].obs;
  var list_temp = <_item>[].obs;

  var cmb_store_typeID = ''.obs;
  var cmb_storeID = ''.obs;
  var cmb_priorityID = ''.obs;
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
          onTextChenge: (v) {
         
       },
          callback: (ModelItemMaster c) {
            return Text(c.name!);
          },
          suggestionList: (String query) {
            return list_item_temp
                .where((item) =>
                    item.name!.toUpperCase().contains(query.toUpperCase()))
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
            x.field!.controller.text = v.name!;
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

    try {
      //  await mLoadModel(api, parameter, listObject, fromJson)
      await Inv_Get_Store_Type(api, list_store_type, user.value.cid!);
      await Inv_Get_priority_master(api, list_priority);
      await Inv_Get_Item_Master_All(api, list_item_master, user.value.cid!);
      list_item_temp.addAll(list_item_master);
      // print(list_item_temp.length);

      list_tools.value = Custom_Tool_List();
      mToolEnableDisable(list_tools, [ToolMenuSet.file],
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

    for (var i = 0; i < list_temp.length; i++) {
      // print(list_temp[i].qty!.text);
      if (list_temp[i].qty!.text == '') {
        b = false;
        break;
      }
    }
    if (isCheckCondition(!b, dialog, 'Item and quantity required!')) return;
    loader.show();

    try {
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
    for (var item in list_temp) {
      item.qty?.dispose();
      item.qty_f?.dispose();
      item.field?.controller.dispose();
      item.field?.focusNode.dispose();
    }

    super.dispose();
  }

  void deleteRow(_item f) {
    list_temp.removeWhere((e) => e.id == f.id);
    if (list_temp.isEmpty) {
      //mToolEnableDisable(list_tools, [ToolMenuSet.file], dtoolList)
      setUndo();
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
