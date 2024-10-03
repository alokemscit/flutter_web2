// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:web_2/core/config/const.dart';

import '../../inv_grn_create/controller/inv_grn_details_view.dart';
import '../../shared/inv_function.dart';
import '../model/inv_grn_master_for_approval.dart';

class InvGrnApprovalController extends GetxController with MixInController {
  var list_tool = <CustomTool>[].obs;
  var list_grn_for_app = <ModelGrnMasterForApp>[].obs;
  var selectedGRM = ModelGrnMasterForApp().obs;
  var list_year = <ModelCommonMaster>[].obs;
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_store_typeID = ''.obs;
  var cmb_yearID = ''.obs;
  var list_grn_details_view = <ModelGrnDetailsView>[].obs;

  var list_month = <_y>[].obs;

  void getGrn(ModelGrnMasterForApp f) async {
    selectedGRM.value = f;
    list_grn_details_view.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      await mLoadModel(
          api,
          [
            {"tag": "91", "cid": user.value.cid, "grn_id": f.grnId}
          ],
          list_grn_details_view,
          (x) => ModelGrnDetailsView.fromJson(x));
      // print(list_grn_details_view.length);
      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void setGRN() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      loader.show();
      await mLoadModel(
          api,
          [
            {
              "tag": "92",
              "cid": user.value.cid,
              "year": cmb_yearID.value,
              "store_type_id": cmb_store_typeID.value
            }
          ],
          list_grn_for_app,
          (x) => ModelGrnMasterForApp.fromJson(x));

      List<_y> list = [];
      list_grn_for_app.forEach((f) {
        list.add(_y(name: f.grnMonth));
      });
      list_month
        ..clear()
        ..addAll(list.toSet());

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
    isLoading.value = true;
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    cmb_yearID.value = DateFormat("yyyy").format(DateTime.now());
    try {
      await Inv_Get_Store_Type(api, list_storeTypeList, user.value.cid!);
      await Inv_Get_Year(api, list_year, user.value.cid!);

      list_tool.value = Custom_Tool_List();
      mToolEnableDisable(list_tool, [ToolMenuSet.show], [ToolMenuSet.file]);
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }
}

class _y extends Equatable {
  String? name;
  _y({
    this.name,
  });

  @override
  List<Object?> get props => [name];
}
