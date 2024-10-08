// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:web_2/core/config/const.dart';

import '../../inv_grn_create/model/inv_grn_details_view.dart';
import '../../shared/inv_function.dart';
import '../model/inv_grn_master_for_approval.dart';

class InvGrnApprovalController extends GetxController with MixInController {
  final TextEditingController txt_remarks = TextEditingController();

  var list_tool = <CustomTool>[].obs;
  var list_grn_for_app = <ModelGrnMasterForApp>[].obs;
  var selectedGRM = ModelGrnMasterForApp().obs;
  var list_year = <ModelCommonMaster>[].obs;
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_store_typeID = ''.obs;
  var cmb_yearID = ''.obs;
  var list_grn_details_view = <ModelGrnDetailsView>[].obs;
  var list_month = <_y>[].obs;
  var grn_total = ''.obs;

  void report(String grn_id) async {
    print(grn_id);
    list_grn_details_view.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      loader.show();
      await mLoadModel(
          api,
          [
            {"tag": "91", "cid": user.value.cid, "grn_id": grn_id}
          ],
          list_grn_details_view,
          (x) => ModelGrnDetailsView.fromJson(x));
      if (list_grn_details_view.isEmpty) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = 'No Report Data Found!'
          ..show();
        return;
      }
      // var x = list_grn_details_view.first;
      // var total = list_grn_details_view.fold(0.0, (previousValue, element) {
      //   return previousValue + (element.tot ?? 0.0);
      // });

      report_grn(font, list_grn_details_view, user, () {
        loader.close();
        setUndo();
        setGRN();
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void app_cancel(bool isCancel) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    // loader.show();
    try {
      //@grn_id int,@cid int,@desc nvarchar(250), @is_cancel int,@emp_id
      ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "93",
          "grn_id": selectedGRM.value.grnId,
          "cid": user.value.cid,
          "desc": txt_remarks.text,
          "is_cancel": isCancel ? "1" : "0",
          "emp_id": user.value.uid
        }
      ]);

      if (s.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () {
            report(s.id ?? '');
            //setUndo();
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

  void setUndo() {
    mToolEnableDisable(list_tool, [],
        [ToolMenuSet.cancel, ToolMenuSet.approve, ToolMenuSet.undo]);
    list_grn_details_view.clear();
    selectedGRM.value = ModelGrnMasterForApp();
  }

  void grabdTotal() {
    grn_total.value = '';
    var total = list_grn_details_view.fold(0.0, (previousValue, element) {
      return previousValue + (element.tot ?? 0.0);
    });
    if (total > 0) {
      grn_total.value = total.toStringAsFixed(2);
    }
  }

  void getGrnDetails(ModelGrnMasterForApp f) async {
    selectedGRM.value = f;
    list_grn_details_view.clear();
    //list_grn_for_app.clear();
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
      grabdTotal();
      if (list_grn_details_view.isNotEmpty) {
        mToolEnableDisable(list_tool,
            [ToolMenuSet.cancel, ToolMenuSet.approve, ToolMenuSet.undo], []);
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

  void setGRN() async {
    list_grn_for_app.clear();
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
    font = await CustomLoadFont(appFontPathOpenSans);
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

  void toolbarEvent(ToolMenuSet? v) {
    if (v == ToolMenuSet.undo) {
      setUndo();
    }
    if (v == ToolMenuSet.cancel) {
      app_cancel(true);
    }
    if (v == ToolMenuSet.approve) {
      app_cancel(false);
    }
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
