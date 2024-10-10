import '../../../../core/config/const.dart';
import '../model/fiin_model_subledger_master.dart';

class SubLedgerController extends GetxController with MixInController {
  var list_subledger_main = <FinModelSubLedgerMaster>[].obs;
  var list_subledger_temp = <FinModelSubLedgerMaster>[].obs;

  var isBillByBill = false.obs;
  var editId = ''.obs;
  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_desc = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  var list_tool = <CustomTool>[].obs;
  bool b = true;
  void toolbarEvent(ToolMenuSet? v) {
    if (b) {
      b = false;
      if (v == ToolMenuSet.undo) {
        undo();
        mToolEnableDisable(list_tool, [ToolMenuSet.file],
            [ToolMenuSet.undo, ToolMenuSet.save,ToolMenuSet.update]);
      }
      if (v == ToolMenuSet.file) {
        undo();
        mToolEnableDisable(list_tool, [ToolMenuSet.undo, ToolMenuSet.save],
            [ToolMenuSet.file,ToolMenuSet.update]);
      }
      if (v == ToolMenuSet.save || v==ToolMenuSet.update) {
        save();
      }

      Future.delayed(const Duration(milliseconds: 400), () {
        b = true;
      });
    }
  }

  void search() {
    var x = list_subledger_main
        .where((p0) =>
            p0.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            p0.code!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            p0.description!
                .toUpperCase()
                .contains(txt_search.text.toUpperCase()))
        .toList();
    list_subledger_temp.clear();
    list_subledger_temp.addAll(x);
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(
        txt_name.text == '', dialog, 'Please eneter valid name!')) return;
    try {
//@cid int,@eid int,  @id int,  @code varchar(25),@name nvarchar(150),@desc nvarchar(200),@is_bill_by int

      ModelStatus s1 = await commonSaveUpdate_all(
          api,
          loader,
          dialog,
          [
            {
              "tag": "2",
              "cid": user.value.cid,
              "eid": user.value.uid,
              "id": editId.value == '' ? "0" : editId.value,
              "code": txt_code.text,
              "name": txt_name.text,
              "desc": txt_desc.text,
              "is_bill_by": isBillByBill.value ? "1" : "0"
            }
          ],
          'fin');

      if (s1.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s1.msg!
          ..show()
          ..onTap = () {
            list_subledger_main
                .removeWhere((e) => e.id.toString() == editId.value);
            list_subledger_main.insert(
                0,
                FinModelSubLedgerMaster(
                    id: int.parse(s1.id ?? '0'),
                    name: txt_name.text,
                    code: s1.extra,
                    description: txt_desc.text,
                    isBillByBill: isBillByBill.value ? 1 : 0));
            list_subledger_temp.clear();
            list_subledger_temp.addAll(list_subledger_main);
            editId.value = '';
            txt_search.text = '';
            txt_name.text = '';
            txt_code.text = '';
            txt_desc.text = '';
            isBillByBill.value = false;
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

  void undo() async {
    editId.value = '';
    txt_search.text = '';
    txt_name.text = '';
    txt_code.text = '';
    txt_desc.text = '';
    isBillByBill.value = false;
    list_subledger_temp.clear();
    list_subledger_temp.addAll(list_subledger_main);
  }

  void edit(FinModelSubLedgerMaster e) {
    editId.value = e.id!.toString();
    txt_name.text = e.name ?? '';
    txt_code.text = e.code ?? '';
    txt_desc.text = e.description ?? '';
    isBillByBill.value = (e.isBillByBill ?? 0) == 1 ? true : false;
    mToolEnableDisable(list_tool, [
      ToolMenuSet.undo,
      ToolMenuSet.update
    ], [
      ToolMenuSet.save,
      ToolMenuSet.file,
    ]);
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
            {"tag": "1", "cid": user.value.cid}
          ],
          list_subledger_main,
          (e) => FinModelSubLedgerMaster.fromJson(e),
          'fin');
      list_subledger_temp.addAll(list_subledger_main);
      // print(list_sub_ledger_master.length);
      list_tool.addAll(Custom_Tool_List());
      mToolEnableDisable(
          list_tool, [ToolMenuSet.save, ToolMenuSet.undo], [ToolMenuSet.file]);
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }

    super.onInit();
  }
}
