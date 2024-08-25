import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/model/model_inv_brand_company.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/model/model_store_unit.dart';

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
  var cmb_unitID = ''.obs;
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_storetypeID = ''.obs;
  var list_group = <ModelItemGroupMaster>[].obs;
  var cmb_groupID = ''.obs;
  var list_subGroup = <ModelItemSubGroupMaster>[].obs;
  var cmb_subGroupID = ''.obs;

  void setStoreType(ModelCommonMaster f) {
    cmb_storetypeID.value = f.id!;
    
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
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}
