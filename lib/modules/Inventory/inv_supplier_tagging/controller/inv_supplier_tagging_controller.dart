import 'dart:convert';

import 'package:pdf/widgets.dart';
import 'package:web_2/core/config/const.dart';

import '../../attribute_setup_page/model/model_inv_brand_company.dart';
import '../../inv_supplier_master/model/inv_model_supplier_master.dart';

class InvSupplierTaggingController extends GetxController with MixInController {
  late Font font;
  final TextEditingController txt_search_company = TextEditingController();
  final TextEditingController txt_search_supplier = TextEditingController();
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_store_type = ''.obs;

  var list_company_master = <ModelInvBrandCompany>[].obs;
  var list_company_temp = <ModelInvBrandCompany>[].obs;

  var list_supp_master = <ModelSupplierMaster>[].obs;
  var list_supp_temp = <ModelSupplierMaster>[].obs;

  var list_supp_tag = <ModelSupplierMaster>[].obs;

  var selectedCompany = ModelInvBrandCompany().obs;
  var isAdd = false.obs;

  void addSupp(ModelSupplierMaster f) {
    dialog = CustomAwesomeDialog(context: context);
    if (list_supp_tag.where((e) => e.id == f.id).isNotEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Suppler Already Exists!'
        ..show();
      return;
    }
    list_supp_tag.add(f);
  }

  void deleteTagSup(ModelSupplierMaster f) {
    list_supp_tag.removeWhere((e) => e.id == f.id);
  }

  void searchSuppEntry() {
    list_supp_temp
      ..clear()
      ..addAll(list_supp_master.where((e) =>
          e.code!
              .toUpperCase()
              .contains(txt_search_supplier.text.toUpperCase()) ||
          e.name!
              .toUpperCase()
              .contains(txt_search_supplier.text.toUpperCase()) ||
          e.mob!
              .toUpperCase()
              .contains(txt_search_supplier.text.toUpperCase()) ||
          e.address!
              .toUpperCase()
              .contains(txt_search_supplier.text.toUpperCase())));
  }

  void setStoreType(String id) {
    list_supp_tag.clear();
    txt_search_company.text = '';
    txt_search_supplier.text = '';
    selectedCompany.value = ModelInvBrandCompany();
    cmb_store_type.value = id;
    list_company_temp
      ..clear()
      ..addAll(list_company_master.where((e) => e.stypeId == id));
  }

  void save() async {
    loader = CustomBusyLoader(context: context);

    dialog = CustomAwesomeDialog(context: context);
    if (isCheckCondition(selectedCompany.value.stypeId == null, dialog,
        'Selease select company')) return;
    if (isCheckCondition(
        list_supp_tag.isEmpty, dialog, 'No supplier selected for taging!'))
      return;

    try {
      List<Map<String, dynamic>> list = [];
      list_supp_tag.forEach((f) {
        list.add({"id": f.id!});
      });
      var s = jsonEncode(list);
      print(s);

      ModelStatus st = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "73",
          "cid": user.value.cid,
          "com_id": selectedCompany.value.id,
          "str": s
        }
      ]);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () {
            list_supp_tag.clear();
            selectedCompany.value = ModelInvBrandCompany();
            txt_search_supplier.text = '';
            isAdd.value = false;
          };
      }

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
  void onInit() async {
    api = data_api2();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (!(await isValidLoginUser(this))) return;
    font = await CustomLoadFont(appFontPathLato);
    try {
      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);

      if (checkJson(x)) {
        list_storeTypeList
            .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
      }
      x = await api.createLead([
        {"tag": "59", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_company_master
            .addAll(x.map((e) => ModelInvBrandCompany.fromJson(e)));
      }
      x = await api.createLead([
        {"tag": "71", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_supp_master.addAll(x.map((e) => ModelSupplierMaster.fromJson(e)));
        list_supp_temp.addAll(list_supp_master);
      }
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }

    super.onInit();
  }

  void setCompanyForSettiongs(ModelInvBrandCompany f) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    isAdd.value = false;
    selectedCompany.value = f;
    list_supp_tag.clear();
    try {
      loader.show();
      var x = await api.createLead([
        {"tag": "74", "cid": user.value.cid, "com_id": f.id}
      ]);
      loader.close();
      if (checkJson(x)) {
        list_supp_tag.addAll(x.map((e) => ModelSupplierMaster.fromJson(e)));
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void searchCompany() {
    list_company_temp
      ..clear()
      ..addAll(list_company_master.where((e) =>
          e.name!
              .toUpperCase()
              .contains(txt_search_company.text.toUpperCase()) ||
          e.address!
              .toUpperCase()
              .contains(txt_search_company.text.toUpperCase()) ||
          e.mob!
              .toUpperCase()
              .contains(txt_search_company.text.toUpperCase())));
  }

  void closeClick() {
    list_supp_tag.clear();
    selectedCompany.value = ModelInvBrandCompany();
    txt_search_supplier.text = '';
    isAdd.value = false;
  }
}
