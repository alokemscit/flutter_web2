// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/model/model_inv_brand_company.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/model/model_store_unit.dart';

import '../../attribute_setup_page/model/model_inv_generic_master.dart';
import '../../attribute_setup_page/model/model_inv_item_group_master.dart';
import '../../attribute_setup_page/model/model_inv_item_sub_group_master.dart';

class InvItemMasterController extends GetxController with MixInController {
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  var editItemID = ''.obs;
  var list_company_master = <ModelInvBrandCompany>[].obs;
  var cmb_companyID = ''.obs;
  var list_company_temp = <ModelInvBrandCompany>[].obs;
  var list_storeUnit = <ModelStoreUnit>[].obs;
  var list_storeUnit_temp = <ModelStoreUnit>[].obs;
  var cmb_unitID = ''.obs;
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_storetypeID = ''.obs;
  var list_group = <ModelItemGroupMaster>[].obs;
  var list_group_temp = <ModelItemGroupMaster>[].obs;
  var cmb_groupID = ''.obs;
  var list_subGroup = <ModelItemSubGroupMaster>[].obs;
  var list_subGroup_temp = <ModelItemSubGroupMaster>[].obs;
  var cmb_subGroupID = ''.obs;
  var list_generic_master = <ModelGenericMaster>[].obs;
  var list_generic_temp = <ModelGenericMaster>[].obs;
  var cmb_generic = ''.obs;

  void saveUpdateItem() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(
        cmb_storetypeID.value == '', dialog, 'Please select store type!'))
      return;
    if (isCheckCondition(
        cmb_companyID.value == '', dialog, 'Please select company!')) return;
    if (isCheckCondition(
        cmb_groupID.value == '', dialog, 'Please select group!')) return;
    if (isCheckCondition(
        cmb_subGroupID.value == '', dialog, 'Please select sub group!')) return;
    if (isCheckCondition(
        txt_name.text == '', dialog, 'Please enter valid item name!')) return;
    if (isCheckCondition(
        cmb_generic.value == '', dialog, 'Please select generic/brand name!'))
      return;
    if (isCheckCondition(
        cmb_unitID.value == '', dialog, 'Please select unit name!')) return;

//@cid int,@id int,@name varchar(200),@code varchar(15), @com_id int, @stype_id int,
//@grp_id int,@sgrp_id int, @gen_id int,@unit_id int,
//@status tinyint,@emp_id int
    ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
      {
        "tag": "62",
        "cid": user.value.cid,
        "id": editItemID.value == '' ? "0" : editItemID.value,
        "name": txt_name.text,
        "code": txt_code.text,
        "com_id": cmb_companyID.value,
        "stype_id": cmb_storetypeID.value,
        "grp_id": cmb_groupID.value,
        "sgrp_id": cmb_subGroupID.value,
        "gen_id": cmb_generic.value,
        "unit_id": cmb_unitID.value,
        "status": "1",
        "emp_id": user.value.uid
      }
    ]);
    if (s.status == '1') {
      dialog
        ..dialogType = DialogType.success
        ..message = s.msg!
        ..show()
        ..onTap = () {
          if(editItemID.value!=''){
          
          }
        };
    }
  }

  void setGroup(String id) {
    cmb_groupID.value = id;

    list_subGroup_temp.clear();
    list_subGroup_temp.addAll(list_subGroup.where(
        (f) => f.storeTypeId == cmb_storetypeID.value && f.groupId == id));
    cmb_subGroupID.value = '';
  }

  void setStoreType(String id) {
    cmb_storetypeID.value = id;
    list_company_temp.clear();
    list_company_temp.addAll(list_company_master.where((f) => f.stypeId == id));
    list_group_temp.clear();
    list_group_temp.addAll(list_group.where((f) => f.storeTypeId == id));
    list_generic_temp.clear();
    list_generic_temp.addAll(list_generic_master.where((f) => f.stypeId == id));
    list_storeUnit_temp.clear();
    list_storeUnit_temp.addAll(list_storeUnit.where((f) => f.stypeID == id));
    cmb_companyID.value = '';
    cmb_generic.value = '';
    cmb_groupID.value = '';
    cmb_subGroupID.value = '';
    cmb_unitID.value = '';
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
        {"tag": "28", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_group
            .addAll(x.map((e) => ModelItemGroupMaster.fromJson(e)).toList());
      }
      api.createLead([
        {"tag": "32", "cid": user.value.cid}
      ]).then((x) {
        if (checkJson(x)) {
          list_subGroup.addAll(
              x.map((e) => ModelItemSubGroupMaster.fromJson(e)).toList());
        }
      });

      x = await api.createLead([
        {"tag": "57", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_storeUnit.addAll(x.map((e) => ModelStoreUnit.fromJson(e)));
      }

      x = await api.createLead([
        {"tag": "59", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_company_master
            .addAll(x.map((e) => ModelInvBrandCompany.fromJson(e)));
      }
      x = await api.createLead([
        {"tag": "61", "cid": user.value.cid}
      ]);
      // print(x);
      if (checkJson(x)) {
        list_generic_master
            .addAll(x.map((e) => ModelGenericMaster.fromJson(e)));
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

// class _a {
//   _a({
//     this.list = const [],
//     this.val = '',
//     this.onTap,
//     this.label = '',
//   });

//   dynamic list;
//   String val;
//   String label;
//   void Function(String vv)? onTap;
//   CustomDropDown create() {
//     return CustomDropDown(
//         id: val,
//         list: list,
//         onTap: (v) {
//           val = v!;
//           if (onTap != null) {
//             onTap!(v);
//           }
//         });
//   }

//   // CustomDropDown getCombo(dynamic list, String val) {

//   // }
// }
