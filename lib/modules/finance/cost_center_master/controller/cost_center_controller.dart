import 'package:web_2/core/config/const.dart';

import '../model/model_costcenter_master.dart';

class CostcenterController extends GetxController with MixInController {
  var list_tool = <CustomTool>[].obs;

  var list_costcenter_main = <FinModelCostCenter>[].obs;
  var list_costcenter_temp = <FinModelCostCenter>[].obs;
  var selectedCC = FinModelCostCenter().obs;

  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_desc = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  void search() {
    list_costcenter_temp
      ..clear()
      ..addAll(list_costcenter_main
          .where((p0) =>
              p0.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
              p0.code!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
              (p0.description ?? '')
                  .toUpperCase()
                  .contains(txt_search.text.toUpperCase()))
          .toList());
  }

  void edit(FinModelCostCenter e) {
    selectedCC.value = e;
    txt_name.text = e.name!;
    txt_code.text = e.code!;
    txt_desc.text = e.description ?? '';
    mToolEnableDisable(list_tool, [ToolMenuSet.update, ToolMenuSet.undo],
        [ToolMenuSet.file, ToolMenuSet.save]);
  }

  void undo() {
    selectedCC.value = FinModelCostCenter();
    txt_search.text = '';
    txt_name.text = '';
    txt_code.text = '';
    txt_desc.text = '';
    list_costcenter_temp
      ..clear()
      ..addAll(list_costcenter_main);
    mToolEnableDisable(list_tool, [ToolMenuSet.save, ToolMenuSet.undo],
        [ToolMenuSet.file, ToolMenuSet.update]);
  }

  void save() async {
    //p_cid in int, p_id in int, p_name in varchar2,p_desc in varchar2, p_code in varchar2, v_user in int
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      if (txt_name.text == '') {
        dialog
          ..dialogType = DialogType.warning
          ..message = "Please enter valid sub leadeger name!"
          ..show();
        return;
      }

      // loader.show();
//@cid int,@eid int,  @id int,  @code varchar(25),@name nvarchar(150),@desc nvarchar(200   )
      ModelStatus s1 = await commonSaveUpdate_all(
          api,
          loader,
          dialog,
          [
            {
              "tag": "3",
              "cid": user.value.cid,
              "eid": user.value.uid,
              "id": selectedCC.value.id ?? 0,
              "code": txt_code.text,
              "name": txt_name.text,
              "desc": txt_desc.text
            }
          ],
          'fin');

      if (s1.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s1.msg!
          ..show()
          ..onTap = () {
            list_costcenter_main
                .removeWhere((e) => e.id == selectedCC.value.id);
            list_costcenter_main.insert(
                0,
                FinModelCostCenter(
                    id: int.parse(s1.id ?? '0'),
                    name: txt_name.text,
                    code: s1.extra,
                    description: txt_desc.text,
                    status: 1));

            list_costcenter_temp
              ..clear()
              ..addAll(list_costcenter_main);
            selectedCC.value = FinModelCostCenter();
            txt_search.text = '';
            txt_name.text = '';
            txt_code.text = '';
            txt_desc.text = '';
            undo();
          };
      }
    } catch (e) {
      // loader.close();
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

    try {
      await mLoadModel_All(
          api,
          [
            {"tag": "4", "cid": user.value.cid}
          ],
          list_costcenter_main,
          (x) => FinModelCostCenter.fromJson(x),
          'fin');

      list_costcenter_temp
        ..clear()
        ..addAll(list_costcenter_main);

      list_tool.addAll(Custom_Tool_List());
      mToolEnableDisable(
          list_tool, [ToolMenuSet.save, ToolMenuSet.undo], [ToolMenuSet.file]);

      isLoading.value = false;
      //print(x);
    } catch (e) {
      CustomInitError(this, e.toString());
    }

    super.onInit();
  }

  var b = true;
  void toolbarevent(ToolMenuSet? v) {
    if (b) {
      b = false;
      if (v == ToolMenuSet.undo) {
        undo();
      }
      if (v == ToolMenuSet.save || v == ToolMenuSet.update) {
        save();
      }

      Future.delayed(const Duration(milliseconds: 400), () {
        b = true;
      });
    }
  }
}
