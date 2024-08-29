// ignore_for_file: use_build_context_synchronously

import 'package:web_2/core/config/config.dart';
import 'package:web_2/core/config/const.dart';

import '../../../../component/widget/custom_snakbar.dart';
import '../../../../model/model_status.dart';
import '../model/model_chart_acc_master.dart';
import '../model/model_ledger_master.dart';

class LedgerMasterController extends GetxController with MixInController {
  var ledger_list = <ModelLedgerMaster>[].obs;
  final TextEditingController txt_geroup_code = TextEditingController();
  final TextEditingController txt_group_Serial = TextEditingController();
  final TextEditingController txt_geroup_name = TextEditingController();

  final TextEditingController txt_ledgerCategory_code = TextEditingController();

  final TextEditingController txt_subgeroup_code = TextEditingController();

  final TextEditingController txt_ledgerCat_Serial = TextEditingController();
  final TextEditingController txt_subgroup_Serial = TextEditingController();
  final TextEditingController txt_subgroup_name = TextEditingController();

  final TextEditingController txt_LedgerCat_name = TextEditingController();

  final TextEditingController txt_ledger_code = TextEditingController();
  final TextEditingController txt_ledger_Serial = TextEditingController();
  final TextEditingController txt_ledger_name = TextEditingController();

  var is_cc = false.obs;
  var is_sl = false.obs;

  var list_chart_master = <ModelChartAccMaster>[].obs;

  void exportExcelFile() async {
    api = data_api2();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      // isLoading.value = true;
      var x = await api.createLead([
        {"tag": "55", "p_cid": user.value.cid}
      ]);

      list_chart_master.addAll(x.map((e) => ModelChartAccMaster.fromJson(e)));
      List<Map<String, dynamic>> jsonData = [];
      for (int i = 0; i < list_chart_master.length; i++) {
        ModelChartAccMaster row = list_chart_master[i];
        jsonData.add({
          "Chart Name": row.cHARTNAME!.replaceAll(',', ' '),
          "Group Name": row.gROUPNAME!.replaceAll(',', ' '),
          "Sub Group": row.sUBNAME!.replaceAll(',', ' '),
          "Ledger Category": row.cATNAME!.replaceAll(',', ' '),
          // ignore: prefer_interpolation_to_compose_strings
          "GL Code": row.gLCODE!,
          "GL Name": row.gLNAME!.replaceAll(',', ' ')
        });
      }
      exportJsonToExcel(jsonData);

      //  print(x);
      loader.close();
      //isLoading.value = false;
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      // errorMessage.value = e.toString();
      //isError.value = true;
      // isLoading.value = false;
    }
  }

  void exportData() {
    //  print('export');
    List<Map<String, dynamic>> jsonData = [];
    for (int i = 0; i < ledger_list.length; i++) {
      ModelLedgerMaster row = ledger_list[i];
      jsonData.add(row.toJson());
    }
    exportJsonToExcel(jsonData);
  }

  void saveLedgerCategory(
      String pid, bool isupdate, ModelLedgerMaster e) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    if (txt_LedgerCat_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please eneter valid Ledger Category name!'
        ..show();
      return;
    }
    try {
     
      var x = await api.createLead([
        {
          "tag": "54",
          "p_cid": user.value.cid,
          "p_id": isupdate ? e.iD : "0",
          "p_name": txt_LedgerCat_name.text,
          "p_pid": pid,
          "p_code": txt_ledgerCategory_code.text,
          "p_sl": txt_ledgerCat_Serial.text,
          "p_isgroup": "3",
          "p_is_cc": "0",
          "p_is_sl": "0"
        }
      ]);
      loader.close();
      // print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == "1") {
        if (isupdate) {
          //ledger_list.removeWhere((element) => element.iD == e.iD);
          int index = ledger_list.indexWhere((model) => model.iD == e.iD);
          ledger_list.removeWhere((element) => element.iD == e.iD);

          ledger_list.insert(
              index,
              ModelLedgerMaster(
                  cODE: txt_ledgerCategory_code.text,
                  iD: e.iD,
                  iSPARENT: '1',
                  nAME: txt_LedgerCat_name.text,
                  pARENTID: e.pARENTID,
                  sL: txt_ledgerCat_Serial.text,
                  isCC: "0",
                  isSL: "0"));
        } else {
          ledger_list.add(ModelLedgerMaster(
              cODE: s.extra!,
              iD: s.id,
              iSPARENT: '1',
              nAME: txt_LedgerCat_name.text,
              pARENTID: pid,
              sL: "1",
              isCC: "0",
              isSL: "0"));
        }
        txt_ledgerCategory_code.text = '';
        txt_LedgerCat_name.text = '';
        txt_ledgerCat_Serial.text = '';
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show()
        //   ..onTap = () => Navigator.pop(context);
        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveSubGroup(bool isUpdate, ModelLedgerMaster e) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);

    loader.show();
    if (txt_subgroup_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please eneter valid Sub Group name!'
        ..show();
      return;
    }

    try {
      var x = await api.createLead([
        {
          "tag": "54",
          "p_cid": user.value.cid,
          "p_id": isUpdate ? e.iD : "0",
          "p_name": txt_subgroup_name.text,
          "p_pid": isUpdate ? e.pARENTID : e.iD,
          "p_code": txt_subgeroup_code.text,
          "p_sl": txt_subgroup_Serial.text,
          "p_isgroup": "2",
          "p_is_cc": "0",
          "p_is_sl": "0"
        }
      ]);
      loader.close();
      // print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == "1") {
        if (isUpdate) {
          // ledger_list.removeWhere((element) => element.iD == e.iD);

          int index = ledger_list.indexWhere((model) => model.iD == e.iD);
          ledger_list.removeWhere((element) => element.iD == e.iD);

          ledger_list.insert(
              index,
              ModelLedgerMaster(
                  cODE: txt_subgeroup_code.text,
                  iD: e.iD,
                  iSPARENT: '1',
                  nAME: txt_subgroup_name.text,
                  pARENTID: e.pARENTID,
                  sL: txt_subgroup_Serial.text,
                  isCC: "0",
                  isSL: "0"));
        } else {
          ledger_list.add(ModelLedgerMaster(
              cODE: s.extra!,
              iD: s.id,
              iSPARENT: '1',
              nAME: txt_subgroup_name.text,
              pARENTID: e.iD,
              sL: "1",
              isCC: "0",
              isSL: "0"));
        }
        txt_subgeroup_code.text = '';
        txt_subgroup_name.text = '';
        txt_subgroup_Serial.text = '';
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show()
        //   ..onTap = () => Navigator.pop(context);
        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveLedger(ModelLedgerMaster e, bool isUpdate) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    if (txt_ledger_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please enter valid Ledger name!'
        ..show();
      return;
    }
    try {
 
      var x = await api.createLead([
        {
          "tag": "54",
          "p_cid": user.value.cid,
          "p_id": isUpdate ? e.iD : "0",
          "p_name": txt_ledger_name.text,
          "p_pid": isUpdate ? e.pARENTID : e.iD,
          "p_code": txt_ledger_code.text,
          "p_sl": txt_ledger_Serial.text,
          "p_isgroup": "0",
          "p_is_sl": is_sl.value ? "1" : "0",
          "p_is_cc": is_cc.value ? "1" : "0",
        }
      ]);
      loader.close();
      // print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == "1") {
        if (isUpdate) {
          int index = ledger_list.indexWhere((model) => model.iD == e.iD);
          ledger_list.removeWhere((element) => element.iD == e.iD);

          ledger_list.insert(
              index,
              ModelLedgerMaster(
                  cODE: txt_ledger_code.text,
                  iD: e.iD,
                  iSPARENT: '0',
                  nAME: txt_ledger_name.text,
                  pARENTID: e.pARENTID,
                  sL: txt_ledger_Serial.text,
                  isCC: is_cc.value ? "1" : "0",
                  isSL: is_sl.value ? "1" : "0"));
        } else {
          ledger_list.add(ModelLedgerMaster(
              cODE: s.extra!,
              iD: s.id,
              iSPARENT: '0',
              nAME: txt_ledger_name.text,
              pARENTID: e.iD,
              sL: txt_ledger_Serial.text != ''
                  ? txt_ledger_Serial.text
                  : (ledger_list.where((p0) => p0.pARENTID == e.iD).length + 1)
                      .toString(),
              isCC: is_cc.value ? "1" : "0",
              isSL: is_sl.value ? "1" : "0"));
        }

        txt_ledger_code.text = '';
        txt_ledger_name.text = '';
        txt_ledger_Serial.text = '';
        is_cc.value = false;
        is_sl.value = false;
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show()
        //   ..onTap = () => Navigator.pop(context);
        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveGroup(ModelLedgerMaster e, bool isUpdate) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    if (txt_geroup_name.text.isEmpty) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please eneter valid Group name!'
        ..show();

      return;
    }


    try {
      var x = await api.createLead([
        {
          "tag": "54",
          "p_cid": user.value.cid,
          "p_id": isUpdate ? e.iD : "0",
          "p_name": txt_geroup_name.text,
          "p_pid": isUpdate ? e.pARENTID : e.iD,
          "p_code": txt_geroup_code.text,
          "p_sl": txt_group_Serial.text == '' ? '1' : txt_group_Serial.text,
          "p_isgroup": "1",
          "p_is_cc": "0",
          "p_is_sl": "0"
        }
      ]);
      loader.close();
       //print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
     // print(s);
      if (s.status == "1") {
        if (isUpdate) {
          int index = ledger_list.indexWhere((model) => model.iD == e.iD);
          ledger_list.removeWhere((element) => element.iD == e.iD);

          ledger_list.insert(
              index,
              ModelLedgerMaster(
                  cODE: txt_geroup_code.text,
                  iD: e.iD,
                  iSPARENT: '1',
                  nAME: txt_geroup_name.text,
                  pARENTID: e.pARENTID,
                  sL: txt_group_Serial.text,
                  isCC: "0",
                  isSL: "0"));
        } else {
          ledger_list.add(ModelLedgerMaster(
              cODE: s.extra!,
              iD: s.id,
              iSPARENT: '1',
              nAME: txt_geroup_name.text,
              pARENTID: e.iD,
              sL: "1",
              isCC: "0",
              isSL: "0"));
        }

        txt_geroup_code.text = '';
        txt_geroup_name.text = '';
        txt_group_Serial.text = '';

        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
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
    try {
      user.value = await getUserInfo();
      if (user.value.uid == null) {
        isError.value = true;
        isLoading.value = false;
        errorMessage.value = "User re-login required!";
        return;
      }
     // print(user.value.cid);
      isError.value = false;

      var x = await api.createLead([
        {"tag": "53", "p_cid": user.value.cid}
      ]);
      //print(x);
      ledger_list.addAll(x.map((e) => ModelLedgerMaster.fromJson(e)));
      //print(ledger_list.length);
      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}
