import 'package:web_2/core/config/const.dart';

import '../../fin_shared/fin_function.dart';
import '../model/fin_model_voucher_type.dart';

class FinVoucherEntryController extends GetxController with MixInController {
  var list_acc_type = <ModelCommonMaster>[].obs;
  var list_voucher_type = <FinModelVoucherType>[].obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedVoucherType = FinModelVoucherType().obs;

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    font = await CustomLoadFont(appFontPathOpenSans);
    list_tool.addAll(Custom_Tool_List());

    try {
      await Fin_Get_Acc_Type(api, list_acc_type);
      await Fin_Get_Voucher_Type(api, list_voucher_type);
      mToolEnableDisable(list_tool, [ToolMenuSet.file],
          [ToolMenuSet.undo, ToolMenuSet.save, ToolMenuSet.update]);
    } catch (e) {
      CustomInitError(this, e.toString());
    } finally {
      isLoading.value = false; // Ensure loading state is false after completion
    }

    super.onInit();
  }

  void setNew() {
    mToolEnableDisable(
        list_tool, [ToolMenuSet.save, ToolMenuSet.undo], [ToolMenuSet.file]);
  }

  void setUndo() {
    mToolEnableDisable(
        list_tool, [ToolMenuSet.file], [ToolMenuSet.save, ToolMenuSet.undo]);
  }

  bool b = true;
  void toolevent(ToolMenuSet? v) async {
    if (b) {
      b = false;
      if (v == ToolMenuSet.file) {
        setNew();
      }
      if (v == ToolMenuSet.undo) {
        setUndo();
      }
      Future.delayed(const Duration(milliseconds: 400), () {
        b = true; // Re-enable events after the delay
      });
    }
  }
}
