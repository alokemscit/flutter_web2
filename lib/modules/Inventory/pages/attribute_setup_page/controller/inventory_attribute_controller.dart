// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/data/data_api.dart';

import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/Inventory/pages/attribute_setup_page/model/model_inv_item_group_master.dart';
import 'package:web_2/modules/Inventory/pages/attribute_setup_page/model/model_inv_item_sub_group_master.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

class InvmsAttributeController extends GetxController {
  final BuildContext context;
  late data_api2 api;
  var user = ModelUser().obs;
  late CustomAwesomeDialog dialog;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  var isSearch = false.obs;
  final TextEditingController txt_StoreType = TextEditingController();
  final TextEditingController txt_StoreTypeSearch = TextEditingController();
  final TextEditingController txt_Group = TextEditingController();
  final TextEditingController txt_SubGroup = TextEditingController();

  var cmb_StoreTypeId = ''.obs;
  var cmb_StoreTypeId2 = ''.obs;
  var cmb_StoreTypeId3 = ''.obs;
  var cmb_StoreTypeStatusId = ''.obs;
  var editStoreTypeID = ''.obs;

  var cmb_GroupId = ''.obs;
  var cmb_GroupId2 = ''.obs;
  var cmb_GroupStatusId = ''.obs;
  var cmb_SubGroupId = ''.obs;
  var cmb_SubGroupStatusId = ''.obs;
  var editGroupId = ''.obs;
  var editSubGroupID = ''.obs;
  var statusList = <ModelStatusMaster>[].obs;

  var storeTypeList = <ModelCommonMaster>[].obs;
  var storeTypeList_temp = <ModelCommonMaster>[].obs;

  var groupList = <ModelItemGroupMaster>[].obs;
  var groupList_temp = <ModelItemGroupMaster>[].obs;

  var subGroupList = <ModelItemSubGroupMaster>[].obs;
  var subGroupList_temp = <ModelItemSubGroupMaster>[].obs;

  InvmsAttributeController({required this.context});

  void searchStoreType() {
    storeTypeList_temp.clear();
    storeTypeList_temp.addAll(storeTypeList.where((p0) => p0.name!
        .toUpperCase()
        .contains(txt_StoreTypeSearch.text.toUpperCase())));
  }

  void saveStoreType() async {
    if (txt_StoreType.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid store type name"
        ..show()
        ..onTap = () => print("Ok");
      return;
    }
    if (cmb_StoreTypeStatusId.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select status"
        ..show();
      return;
    }

    try {
      customBusyDialog(context);
      var x = await api.createLead([
        {
          "tag": "31",
          "cid": user.value.cid,
          "id": editStoreTypeID.value,
          "name": txt_StoreType.text,
          "status": cmb_StoreTypeStatusId.value
        }
      ]);
      Navigator.pop(context);
      getStatus(
          x,
          () => dialog
            ..dialogType = DialogType.error
            ..message = "Faillure to save data"
            ..show(), (msg, id) {
        dialog
          ..dialogType = DialogType.error
          ..message = msg
          ..show();
      }, (msg, id) {
        storeTypeList.removeWhere((element) => element.id == id);
        storeTypeList.add(ModelCommonMaster(
            id: id,
            name: txt_StoreType.text,
            status: cmb_StoreTypeStatusId.value));
        storeTypeList_temp.clear();
        storeTypeList_temp.addAll(storeTypeList);
        dialog
          ..dialogType = DialogType.success
          ..message = msg
          ..show();
        txt_StoreType.text = '';
        cmb_StoreTypeStatusId.value = "1";
        editStoreTypeID.value = '';
      });
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      Navigator.pop(context);
    }
  }

  void saveGroup() async {
    if (cmb_StoreTypeId2.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select store type!"
        ..show();
      return;
    }
    if (txt_Group.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid item group name"
        ..show();
      // ..onTap = () => print("Ok");
      return;
    }
    if (cmb_GroupStatusId.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please status"
        ..show();
      // ..onTap = () => print("Ok");
      return;
    }

    try {
      customBusyDialog(context);
      var x = await api.createLead([
        {
          "tag": "29",
          "cid": user.value.cid,
          "stid": cmb_StoreTypeId2.value,
          "id": editGroupId.value,
          "name": txt_Group.text,
          "status": cmb_GroupStatusId.value
        }
      ]);
      Navigator.pop(context);
      getStatus(
          x,
          () => dialog
            ..dialogType = DialogType.error
            ..message = "Faillure to save data"
            ..show(), (msg, id) {
        dialog
          ..dialogType = DialogType.error
          ..message = msg
          ..show();
      }, (msg, id) {
        groupList.removeWhere((element) => element.id == id);
        groupList_temp.removeWhere((element) => element.id == id);
        ModelItemGroupMaster item = ModelItemGroupMaster(
            id: id,
            name: txt_Group.text,
            status: cmb_GroupStatusId.value,
            storeTypeId: cmb_StoreTypeId2.value,
            storeTypeName: storeTypeList
                .where((p0) => p0.id == cmb_StoreTypeId2.value)
                .first
                .name);
        groupList.add(item);
        groupList_temp.add(item);

        // groupList.add(ModelCommonMaster(
        //     id: id, name: txt_Group.text, status: cmb_GroupStatusId.value));
        dialog
          ..dialogType = DialogType.success
          ..message = msg
          ..show();

        editGroupId.value = '';
        txt_Group.text = '';
        cmb_GroupStatusId.value = '1';
      });
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      Navigator.pop(context);
    }
  }

  void saveSubGroup() async {
    if (cmb_StoreTypeId3.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select store type!"
        ..show();
      return;
    }
    if (cmb_GroupId2.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select group!"
        ..show();
      return;
    }
    if (cmb_SubGroupStatusId.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please status!"
        ..show();
      return;
    }

    try {
      customBusyDialog(context);

      //@cid,@stid,@grid, @id,@name,@status
      api.createLead([
        {
          "tag": "33",
          "cid": user.value.cid,
          "stid": cmb_StoreTypeId3.value,
          "grid": cmb_GroupId2.value,
          "id": editSubGroupID.value,
          "name": txt_SubGroup.text,
          "status": cmb_SubGroupStatusId.value
        }
      ]).then((x) {
        Navigator.pop(context);
        getStatus(
            x,
            () => dialog
              ..dialogType = DialogType.error
              ..message = "Faillure"
              ..show(),
            (msg, id) => dialog
              ..dialogType = DialogType.error
              ..message = msg
              ..show(), (msg, id) {
          dialog
            ..dialogType = DialogType.success
            ..message = msg
            ..show();

          subGroupList.removeWhere((element) => element.id == id);
          subGroupList.add(ModelItemSubGroupMaster(
            groupId: cmb_GroupId2.value,
            groupName:
                groupList.where((p0) => p0.id == cmb_GroupId2.value).first.name,
            id: id,
            name: txt_SubGroup.text,
            status: cmb_SubGroupStatusId.value,
            storeTypeId: cmb_StoreTypeId3.value,
            storeTypeName: storeTypeList
                .where((p0) => p0.id == cmb_StoreTypeId3.value)
                .first
                .name,
          ));
          subGroupList_temp.clear();
          subGroupList_temp.addAll(subGroupList);
          editSubGroupID.value = '';
         // cmb_GroupId2.value = '';
          txt_SubGroup.text = '';
          cmb_SubGroupStatusId.value = '1';
          //cmb_StoreTypeId3.value = '';
        });
      });
    } catch (e) {
      Navigator.pop(context);
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dialog = CustomAwesomeDialog(context: context);
    api = data_api2();
    isLoading.value = true;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      // ignore: unnecessary_null_comparison
      if (user.value == null) {
        isLoading.value = false;
        isError.value = true;
        errorMessage.value = 'You have to re-login again';
        return;
      }

      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);
      //print(x);
      storeTypeList
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
      storeTypeList_temp.addAll(storeTypeList);

      x = await api.createLead([
        {"tag": "28", "cid": user.value.cid}
      ]);
      //print(x);
      groupList.addAll(x.map((e) => ModelItemGroupMaster.fromJson(e)).toList());
      groupList_temp.addAll(groupList);

      api.createLead([
        {"tag": "32", "cid": user.value.cid}
      ]).then((x) {
        subGroupList
            .addAll(x.map((e) => ModelItemSubGroupMaster.fromJson(e)).toList());
        subGroupList_temp.addAll(subGroupList);
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }
}
