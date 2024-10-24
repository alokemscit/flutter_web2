// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:web_2/core/config/const.dart';

import '../../inv_store_requisition/model/inv_requisition_details.dart';
import '../../shared/inv_function.dart';
import '../model/inv-model_req_for_tree.dart';

class InvStoreItemIssueController extends GetxController with MixInController {
  var cmb_store_typeID = ''.obs;
  var list_store_type = <ModelCommonMaster>[].obs;
  var list_year = <ModelCommonMaster>[].obs;
  var cmb_yearID = ''.obs;

  var list_req_tree = <ModelRequisitionForTree>[].obs;
  var list_mn = <_ms>[].obs;
  var list_month = <_m>[].obs;
  var selectedRequisition = ModelRequisitionForTree().obs;
  var list_req_details = <ModelRequisitionDetails>[].obs;

  var list_temp = <_item>[].obs;

  bool b = true;
  void toolEvent(ToolMenuSet v) {
    if (b) {
      b = false;
      if (v == ToolMenuSet.undo) {
        undo();
      }
      Future.delayed(const Duration(milliseconds: 300), () {
        b = true;
      });
    }
  }

  void setSelect(ModelRequisitionForTree f) async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    list_req_details.clear();
    list_temp.clear();
    selectedRequisition.value = f;
    mToolEnableDisable(
        list_tools, [ToolMenuSet.save, ToolMenuSet.undo], [ToolMenuSet.show]);

    try {
      await mLoadModel_All(
          api,
          [
            {"tag": "2", "reqid": f.id}
          ],
          list_req_details,
          (x) => ModelRequisitionDetails.fromJson(x),
          'inv');
      list_temp.addAll(list_req_details
          .map((f) => _item(
              id: f.itemId.toString(),
              code: f.code ?? '',
              app_qty: (f.appQty ?? 0).toString(),
              focusnode: FocusNode(),
              name: f.itemName ?? '',
              type: f.subgroupName ?? '',
              unit: f.unitName ?? '',
              pending_qty: (f.pendingQty ?? 0).toString(),
              stock_qty: (f.c_stock ?? 0).toString(),
              qty: TextEditingController(
                  text: (f.c_stock ?? 0).toString() == '0'
                      ? '0'
                      : (f.pendingQty ?? 0).toString())))
          .toList());

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void undo() {
    selectedRequisition.value = ModelRequisitionForTree();
    list_req_details.clear();
    list_temp.clear();
    mToolEnableDisable(
      list_tools,
      [ToolMenuSet.show],
      [ToolMenuSet.save, ToolMenuSet.undo],
    );
  }

  void loadData() async {
    list_req_tree.clear();
    list_month.clear();
    list_mn.clear();
    list_req_details.clear();
    list_temp.clear();
    selectedRequisition.value = ModelRequisitionForTree();

    if (cmb_store_typeID.value == '' || cmb_yearID.value == '') {
      return;
    }
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      //@store_type_id int=2, @yr_id varchar(4)=2024, @cid int=12
      await mLoadModel_All(
          api,
          [
            {
              "tag": "6",
              "store_type_id": cmb_store_typeID.value,
              "yr_id": cmb_yearID.value,
              "cid": user.value.cid
            }
          ],
          list_req_tree,
          (x) => ModelRequisitionForTree.fromJson(x),
          'inv');
      // print(list_req_tree.length);
      loader.close();
      list_mn.addAll(list_req_tree
          .map((f) => _ms(
              mname: f.monthName,
              storeId: f.store_id,
              storeName: f.storeName,
              mid: f.mid))
          .toSet()
          .toList());
      list_month.addAll(list_req_tree
          .map((f) => _m(mname: f.monthName, mid: f.mid))
          .toSet()
          .toList());

      // print(list_mn.length);
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
    font = await CustomLoadFont(appFontPathLato);
    cmb_yearID.value = DateFormat("yyyy").format(DateTime.now());
    try {
      await Inv_Get_Store_Type(api, list_store_type, user.value.cid!);
      await Inv_Get_Year(api, list_year, user.value.cid!);
      mToolEnableDisable(list_tools, [ToolMenuSet.show], [ToolMenuSet.file]);
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }

  void remove(_item f) {
    list_temp.removeWhere((e) => e.id == f.id);
  }
}

// ignore: unused_element, camel_case_types
class _item {
  String? id;
  String? code;
  String? name;
  String? type;
  String? unit;
  String? app_qty;
  String? stock_qty;

  String? pending_qty;
  TextEditingController? qty;
  FocusNode? focusnode;
  _item(
      {this.id,
      this.code,
      this.name,
      this.type,
      this.unit,
      this.app_qty,
      this.pending_qty,
      this.qty,
      this.focusnode,
      this.stock_qty});
}

// ignore: must_be_immutable, camel_case_types
class _ms extends Equatable {
  String? mname;
  String? storeName;
  int? storeId;
  int? mid;
  _ms({this.mname, this.storeName, this.storeId, this.mid});

  @override
  List<Object?> get props => [mname, storeName, storeId, mid];
}

// ignore: must_be_immutable, unused_element
class _m extends Equatable {
  int? mid;
  String? mname;
  _m({
    this.mid,
    this.mname,
  });

  @override
  List<Object?> get props => [mid, mname];
}
