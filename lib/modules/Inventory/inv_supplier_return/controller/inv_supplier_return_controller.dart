import 'package:web_2/core/config/const.dart';

class InvSupplierReturnController extends GetxController with MixInController {
  var list_tool = <CustomTool>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    font = await CustomLoadFont(appFontPathOpenSans);
    try {
      list_tool.addAll(Custom_Tool_List());
      mToolEnableDisable(list_tool, [], [ToolMenuSet.file]);

      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }

    super.onInit();
  }
}
