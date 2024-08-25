import '../../../../core/config/const.dart';

import '../model/model_inv_brand_company.dart';
import '../model/model_inv_generic_master.dart';
import '../model/model_inv_item_group_master.dart';
import '../model/model_inv_item_sub_group_master.dart';

import '../model/model_store_unit.dart';

class InvmsAttributeController extends GetxController with MixInController {
  var isFullScreen = false.obs;

  var isSearch = false.obs;
  final TextEditingController txt_StoreType = TextEditingController();
  final TextEditingController txt_StoreTypeSearch = TextEditingController();
  final TextEditingController txt_Group = TextEditingController();
  final TextEditingController txt_SubGroup = TextEditingController();
  final TextEditingController txt_Unit = TextEditingController();
  final TextEditingController txt_Unit_search = TextEditingController();

  final TextEditingController txt_company_name = TextEditingController();
  final TextEditingController txt_company_address = TextEditingController();
  final TextEditingController txt_company_contactno = TextEditingController();
  final TextEditingController txt_company_search = TextEditingController();

  final TextEditingController txt_genericName = TextEditingController();
  final TextEditingController txt_genericSearch = TextEditingController();

  var cmb_StoreTypeId = ''.obs;
  var cmb_StoreTypeId2 = ''.obs;
  var cmb_StoreTypeId3 = ''.obs;
  var cmb_StoreTypeId4 = ''.obs;
  var cmb_StoreTypeId5 = ''.obs;
  var cmb_StoreTypeId6 = ''.obs;
  var cmb_GenericStatusID = ''.obs;
  var cmb_StoreTypeStatusId = ''.obs;
  var editStoreTypeID = ''.obs;
  var editCompanyStoreTypeID = ''.obs;
  var editCompanyID = ''.obs;
  var editGenericId = ''.obs;

  var cmb_GroupId = ''.obs;
  var cmb_GroupId2 = ''.obs;
  var cmb_GroupStatusId = ''.obs;
  var cmb_SubGroupId = ''.obs;
  var cmb_SubGroupStatusId = ''.obs;
  var editGroupId = ''.obs;
  var editSubGroupID = ''.obs;
  var editUnitID = ''.obs;
  var cmb_UnitStatusId = ''.obs;

  var storeTypeList = <ModelCommonMaster>[].obs;
  var storeTypeList_temp = <ModelCommonMaster>[].obs;

  var groupList = <ModelItemGroupMaster>[].obs;
  var groupList_temp = <ModelItemGroupMaster>[].obs;

  var subGroupList = <ModelItemSubGroupMaster>[].obs;
  var subGroupList_temp = <ModelItemSubGroupMaster>[].obs;
  var list_task = <ModelCommonMaster>[].obs;
  var selectedAccordianId = ''.obs;

  var list_unit_master = <ModelStoreUnit>[].obs;
  var list_unit_temp = <ModelStoreUnit>[].obs;

  var statusList = <ModelCommonMaster>[].obs;

  var list_company_master = <ModelInvBrandCompany>[].obs;
  var list_company_temp = <ModelInvBrandCompany>[].obs;

  var list_generic_master = <ModelGenericMaster>[].obs;
  var list_generic_temp = <ModelGenericMaster>[].obs;

  void setGenericStoreType(String id) {
    cmb_StoreTypeId6.value = id;
    list_generic_temp.clear();
    list_generic_temp.addAll(list_generic_master.where((e) => e.stypeId == id));
  }

  void setGenericEdit(ModelGenericMaster f) {
    editGenericId.value = f.id!;
    cmb_StoreTypeId6.value = f.stypeId!;
    txt_genericName.text = f.name!;
    cmb_GenericStatusID.value = f.status!;
  }

  void saveUpdateGeneric() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    //@cid int,@id int,@name varchar(200), @stype_id int,@status
    if (isCheckCondition(
        cmb_StoreTypeId6.value == '', dialog, 'Store Type Required!')) {
      return;
    }

    if (isCheckCondition(
        txt_genericName.text == '', dialog, 'Generic Name Required!')) {
      return;
    }

    if (isCheckCondition(
        cmb_GenericStatusID.value == '', dialog, 'Status Required!')) {
      return;
    }
    ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
      {
        "tag": "60",
        "cid": user.value.cid,
        "id": editGenericId.value == '' ? "0" : editGenericId.value,
        "name": txt_genericName.text,
        "stype_id": cmb_StoreTypeId6.value,
        "status": cmb_GenericStatusID.value
      }
    ]);
    if (s.status == '1') {
      dialog
        ..dialogType = DialogType.success
        ..message = s.msg!
        ..show()
        ..onTap = () {
          if (editGenericId.value != '') {
            list_generic_master.removeWhere((e) => e.id == editGenericId.value);
          }
          list_generic_master.add(ModelGenericMaster(
              id: s.id!,
              name: txt_genericName.text,
              status: cmb_GenericStatusID.value,
              stypeId: cmb_StoreTypeId6.value,
              stypeName: storeTypeList
                  .where((a) => a.id == cmb_StoreTypeId6.value)
                  .first
                  .name));
          list_generic_temp.clear();
          list_generic_temp.addAll(list_generic_master
              .where((e) => e.stypeId == cmb_StoreTypeId6.value));
          editGenericId.value = '';
          txt_genericName.text = '';
        };
    }
  }

  void setCompanyForEdit(ModelInvBrandCompany f) {
    editCompanyID.value = f.id!;
    cmb_StoreTypeId5.value = f.stypeId!;
    txt_company_name.text = f.name!;
    txt_company_address.text = f.address!;
    txt_company_contactno.text = f.mob!;
  }

  void loadCompanyList(String v) {
    cmb_StoreTypeId5.value = v;
    list_company_temp.clear();
    list_company_temp.addAll(
        list_company_master.where((e) => e.stypeId == cmb_StoreTypeId5.value));
  }

  void saveUpdateCompany() async {
    //@cid int,@id int,@name varchar(150),@mob varchar(25),  @address nvarchar(500), @stype_id
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (isCheckCondition(
        cmb_StoreTypeId5.value == '', dialog, 'Please select Store Type!')) {
      return;
    }
    if (isCheckCondition(
        txt_company_name.text.isEmpty, dialog, 'Company Name Required!')) {
      return;
    }

    ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
      {
        "tag": "58",
        "cid": user.value.cid,
        "id": editCompanyID.value == '' ? "0" : editCompanyID.value,
        "name": txt_company_name.text,
        "mob": txt_company_contactno.text,
        "address": txt_company_address.text,
        "stype_id": cmb_StoreTypeId5.value
      }
    ]);
    if (s.status == '1') {
      if (editCompanyID.value != '') {
        list_company_master.removeWhere((e) => e.id == editCompanyID.value);
      }
      list_company_master.add(ModelInvBrandCompany(
          id: s.id!,
          address: txt_company_address.text,
          mob: txt_company_contactno.text,
          name: txt_company_name.text,
          stypeId: cmb_StoreTypeId5.value,
          stypeName: storeTypeList
              .where((e) => e.id == cmb_StoreTypeId5.value)
              .first
              .name));
      editCompanyID.value = '';
      txt_company_name.text = '';
      txt_company_address.text = '';
      txt_company_contactno.text = '';
      dialog
        ..dialogType = DialogType.success
        ..message = s.msg!
        ..show();
    }
  }

  void searchStoreType() {
    storeTypeList_temp.clear();
    storeTypeList_temp.addAll(storeTypeList.where((p0) => p0.name!
        .toUpperCase()
        .contains(txt_StoreTypeSearch.text.toUpperCase())));
  }

  void saveStoreType() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
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
      loader.show();
      // customBusyDialog(context);
      var x = await api.createLead([
        {
          "tag": "31",
          "cid": user.value.cid,
          "id": editStoreTypeID.value,
          "name": txt_StoreType.text,
          "status": cmb_StoreTypeStatusId.value
        }
      ]);
      loader.close();
      //Navigator.pop(context);
      if (checkJson(x)) {
        ModelStatus st = await getStatusWithDialog(x, dialog);
        if (st.status == '1') {
          storeTypeList.removeWhere((element) => element.id == st.id);
          storeTypeList.add(ModelCommonMaster(
              id: st.id,
              name: txt_StoreType.text,
              status: cmb_StoreTypeStatusId.value));
          storeTypeList_temp.clear();
          storeTypeList_temp.addAll(storeTypeList);
          dialog
            ..dialogType = DialogType.success
            ..message = st.msg!
            ..show();
          txt_StoreType.text = '';
          cmb_StoreTypeStatusId.value = "1";
          editStoreTypeID.value = '';
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

  void saveGroup() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
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
      // customBusyDialog(context);
      loader.show();
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
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        groupList.removeWhere((element) => element.id == st.id);
        groupList_temp.removeWhere((element) => element.id == st.id);
        ModelItemGroupMaster item = ModelItemGroupMaster(
            id: st.id,
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
          ..message = st.msg!
          ..show();

        editGroupId.value = '';
        txt_Group.text = '';
        cmb_GroupStatusId.value = '1';
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveSubGroup() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
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
      loader.show();
      // customBusyDialog(context);

      //@cid,@stid,@grid, @id,@name,@status
      var x = await api.createLead([
        {
          "tag": "33",
          "cid": user.value.cid,
          "stid": cmb_StoreTypeId3.value,
          "grid": cmb_GroupId2.value,
          "id": editSubGroupID.value,
          "name": txt_SubGroup.text,
          "status": cmb_SubGroupStatusId.value
        }
      ]);
      loader.close();
      if (checkJson(x)) {
        ModelStatus st = await getStatusWithDialog(x, dialog);
        if (st.status == '1') {
          subGroupList.removeWhere((element) => element.id == st.id);
          subGroupList.add(ModelItemSubGroupMaster(
            groupId: cmb_GroupId2.value,
            groupName:
                groupList.where((p0) => p0.id == cmb_GroupId2.value).first.name,
            id: st.id,
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
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void loadStoreTypeForUnt(String id) {
    cmb_StoreTypeId4.value = id;
    list_unit_temp.clear();
    list_unit_temp.addAll(list_unit_master.where((e) => e.stypeID == id));
  }

  void saveUpdateUnit() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    if (cmb_StoreTypeId4.value == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select Store Type!'
        ..show();
      return;
    }
    if (txt_Unit.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Unit Name Required!'
        ..show();
      return;
    }
    if (cmb_UnitStatusId.value == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select Status!'
        ..show();
      return;
    }
    try {
      //@cid int,@id int,@name nvarchar(100),@status tinyint, @stype_id
      var x = await api.createLead([
        {
          "tag": "56",
          "cid": user.value.cid,
          "id": editUnitID.value == '' ? "0" : editUnitID.value,
          "name": txt_Unit.text,
          "status": cmb_UnitStatusId.value,
          "stype_id": cmb_StoreTypeId4.value
        }
      ]);
      loader.close();
      var s = await getStatusWithDialog(x, dialog);
      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () {
            if (editUnitID.value != '') {
              list_unit_master.removeWhere((f) => f.id == editUnitID.value);
            }
            list_unit_master.insert(
                0,
                ModelStoreUnit(
                    stypeID: cmb_StoreTypeId4.value,
                    stypeName: '',
                    id: s.id!,
                    name: txt_Unit.text,
                    status: cmb_UnitStatusId.value));
            list_unit_temp.clear();
            list_unit_temp.addAll(list_unit_master
                .where((e) => e.stypeID == cmb_StoreTypeId4.value));
            txt_Unit.text = '';
            editUnitID.value = '';
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

  void editUnit(ModelStoreUnit a) {
    editUnitID.value = a.id!;
    txt_Unit.text = a.name!;
    cmb_StoreTypeId4.value = a.stypeID!;
    cmb_UnitStatusId.value = a.status!;
  }

  @override
  void onInit() async {
    super.onInit();
    list_task.add(ModelCommonMaster(id: "1", name: "Store Type", status: "0"));
    list_task.add(ModelCommonMaster(id: "2", name: "Item Group", status: "0"));
    list_task
        .add(ModelCommonMaster(id: "3", name: "Store Sub Group", status: "0"));
    list_task.add(ModelCommonMaster(id: "4", name: "Unit Master", status: "0"));
    list_task
        .add(ModelCommonMaster(id: "6", name: "Item Generic", status: "0"));
    list_task
        .add(ModelCommonMaster(id: "5", name: "Brand Comppany", status: "0"));

    api = data_api2();
    isLoading.value = true;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      // ignore: unnecessary_null_comparison
      if (user.value.uid == null) {
        isLoading.value = false;
        isError.value = true;
        errorMessage.value = 'You have to re-login again';
        return;
      }

      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);
      //  print(x);
      if (checkJson(x)) {
        storeTypeList
            .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
        storeTypeList_temp.addAll(storeTypeList);
      }

      x = await api.createLead([
        {"tag": "28", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        groupList
            .addAll(x.map((e) => ModelItemGroupMaster.fromJson(e)).toList());
        groupList_temp.addAll(groupList);
      }
      api.createLead([
        {"tag": "32", "cid": user.value.cid}
      ]).then((x) {
        if (checkJson(x)) {
          subGroupList.addAll(
              x.map((e) => ModelItemSubGroupMaster.fromJson(e)).toList());
          subGroupList_temp.addAll(subGroupList);
        }
      });

      x = await api.createLead([
        {"tag": "57", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_unit_master.addAll(x.map((e) => ModelStoreUnit.fromJson(e)));
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
      errorMessage.value = e.toString();
    }
  }
}
