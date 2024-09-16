// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/inv_supplier_master/model/inv_model_supplier_master.dart';

import '../model/inv_model_pr_for_app_model.dart';
import '../model/inv_model_pr_item_details.dart';
import '../model/inv_model_terms_master.dart';

class InvPoCreateController extends GetxController with MixInController {
  final TextEditingController txt_po_date = TextEditingController();
  final TextEditingController txt_delivery_date = TextEditingController();
  final TextEditingController txt_delivery_note = TextEditingController();
  final TextEditingController txt_remarks = TextEditingController();
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var list_year = <ModelCommonMaster>[].obs;
  var list_pr_master = <ModelInvPrForApp>[].obs;
  var list_terms_master = <ModelInvTermsMaster>[].obs;
  var list_supplier = <ModelSupplierMaster>[].obs;
  var list_pr_item_details = <ModelInvPrItemDetails>[].obs;
  var list_pr_item_tems = <ModelInvPrItemDetails>[].obs;
  var cmb_store_typeID = ''.obs;
  var cmb_yearID = ''.obs;
  var cmb_supplierID = ''.obs;
  var list_month = <_m>[].obs;
  var selectedMrr = ModelInvPrForApp().obs;
  void setUndo() {
    selectedMrr.value = ModelInvPrForApp();
    list_terms_master.clear();
  }

  void setMRR(ModelInvPrForApp f) {
    selectedMrr.value = f;
    cmb_supplierID.value = '';
    txt_delivery_note.text = '';
    txt_remarks.text = '';
    setStore();
  }

  void setStore() async {
    list_terms_master.clear();
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
      mLoadModel(
          api,
          [
            {"tag": "78", "prid": selectedMrr.value.id}
          ],
          list_pr_item_details,
          (x) => ModelInvPrItemDetails.fromJson(x));
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
}

class _m extends Equatable {
  String? name;
  _m({
    this.name,
  });
  @override
  List<Object?> get props => [name];
}
