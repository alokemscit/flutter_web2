// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
import 'package:intl/intl.dart';
import 'package:web_2/core/config/const.dart';

import '../../inv_item_master/model/inv_model_item_master.dart';

class InvPurchaseRequisitionController extends GetxController
    with MixInController {
  final TextEditingController txt_date = TextEditingController();
  final TextEditingController txt_note = TextEditingController();
  final TextEditingController txt_search_name = TextEditingController();
  final TextEditingController txt_search_qty = TextEditingController();
  final TextEditingController txt_search_note = TextEditingController();

  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_storetypeID = ''.obs;
  var list_priority = <ModelCommonMaster>[].obs;
  var cmb_priorityID = ''.obs;
  var list_item_master = <ModelItemMaster>[].obs;
  var list_item_temp = <ModelItemMaster>[].obs;
  var list_temp = <_item>[].obs;
  var isShowSearch = false.obs;

  void showSearchContainer() {
    dialog = CustomAwesomeDialog(context: context);
    isShowSearch.value = false;
    if (isCheckCondition(
        cmb_storetypeID.value == '', dialog, 'Please Select Store Type')) {
      return;
    }
    isShowSearch.value = true;
  }

  void setStoreType(String id) {
    cmb_storetypeID.value = id;
    cmb_priorityID.value = '';
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
}

class _item {
  String? id;
  String? code;
  String? name;
  String? unit;
  String? group;
  String? subgroup;
  String? company;
  String? qty;
  _item({
    this.id,
    this.code,
    this.name,
    this.unit,
    this.group,
    this.subgroup,
    this.company,
    this.qty,
  });
}
