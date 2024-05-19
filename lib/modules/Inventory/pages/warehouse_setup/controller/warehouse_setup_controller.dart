import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/awesom_dialog/awesome_dialog.dart';
import 'package:web_2/component/settings/config.dart';
 
import 'package:web_2/component/widget/custom_awesomeDialog.dart';
import 'package:web_2/component/widget/custom_bysy_loader.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/Inventory/pages/warehouse_setup/model/model_warehouse_master.dart';
import 'package:web_2/modules/admin/module_page/form_page.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

class WareHouseSetupController extends GetxController {
  WareHouseSetupController({required this.context});
  final BuildContext context;
  late data_api2 api;
  var user = ModelUser().obs;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  var cmb_StoteTypeID = ''.obs;
  var cmb_SatusID = ''.obs;
  var editWarehouseID = ''.obs;
  var isCentralStore = false.obs;
  final TextEditingController txt_warehouse_name = TextEditingController();

  var storeTypeList = <ModelCommonMaster>[].obs;
  var statusList = <ModelStatusMaster>[].obs;
  var warehouseList = <ModelWareHouseMaster>[].obs;
  var warehouseList_temp = <ModelWareHouseMaster>[].obs;

  void saveWarehouse() async {
    if (user.value == null) {
      dialog
        ..dialogType = DialogType.error
        ..message = "You have to relogin again"
        ..show();
      return;
    }
    if (isCentralStore.value) {
      if (cmb_StoteTypeID.value == '') {
        dialog
          ..dialogType = DialogType.warning
          ..message = "Please select Store Type"
          ..show();
        return;
      }
    }
    loader.show();

    try {
      api.createLead([
        {
          "tag": "34",
          "cid": user.value.cid,
          "id": editWarehouseID.value == '' ? "0" : editWarehouseID.value,
          "name": txt_warehouse_name.text,
          "iscentral": isCentralStore.value ? "1" : "0",
          "store_type_id": (isCentralStore.value ? cmb_StoteTypeID.value : "0"),
          "status": cmb_SatusID.value
        }
      ]).then((x) {
        loader.close();
        getStatusWithDialog(x, dialog).then((value) {
          if (value.status == "1") {
            warehouseList_temp.clear();
            if (editWarehouseID.value != '') {
              warehouseList.removeWhere(
                  (element) => element.id == editWarehouseID.value);
            }
            warehouseList.add(ModelWareHouseMaster(
                id: value.id,
                isCentral: isCentralStore.value ? "1" : "0",
                name: txt_warehouse_name.text,
                status: cmb_SatusID.value,
                storeTypeId:
                    (isCentralStore.value ? cmb_StoteTypeID.value : "0"),
                storeTypeName: !isCentralStore.value
                    ? "All Store"
                    : storeTypeList
                        .where((p0) => p0.id == cmb_StoteTypeID.value)
                        .first
                        .name));
            warehouseList_temp.addAll(warehouseList);
            txt_warehouse_name.text = '';
            editWarehouseID.value = '';
          }
        });
      });
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      loader.close();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    api = data_api2();
    isLoading.value = true;
    isError.value = false;
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

      x = await api.createLead([
        {"tag": "35", "cid": user.value.cid}
      ]);
      warehouseList
          .addAll(x.map((e) => ModelWareHouseMaster.fromJson(e)).toList());
      warehouseList_temp.addAll(warehouseList);
      // storeTypeList.insert(
      //     0, ModelCommonMaster(id: "0", name: "All Type", status: "1"));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value.toString();
    }
  }
}
