import 'package:web_2/core/config/functions.dart';
 

import '../../../core/common_model/model_common_master.dart';
import '../../../data/data_api.dart';
import '../cost_center_master/model/model_costcenter_master.dart';
import '../fin_voucher/model/fin_model_voucher_type.dart';
import '../ledger_master_page/model/model_chart_acc_master.dart';
import '../sub_ledger_master/model/fiin_model_subledger_master.dart';
 

Future<void> Fin_Get_Acc_Type(
    data_api2 api, List<ModelCommonMaster> list ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "5"}
          ],
          list,
          (x) => ModelCommonMaster.fromJson(x));
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Fin_Get_Voucher_Type(
    data_api2 api, List<FinModelVoucherType> list ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "6"}
          ],
          list,
          (x) => FinModelVoucherType.fromJson(x));
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Fin_Get_Cost_center(
    data_api2 api, List<FinModelCostCenter> list,String cid ) async {
  try {
   await mLoadModel_All(
          api,
          [
            {"tag": "4", "cid": cid}
          ],
          list,
          (x) => FinModelCostCenter.fromJson(x),
          'fin');
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}
 
Future<void> Fin_Get_sub_ledger(
    data_api2 api, List<FinModelSubLedgerMaster> list,String cid ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "1", "cid":cid}
          ],
          list,
          (e) => FinModelSubLedgerMaster.fromJson(e),
          'fin');
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}
 

 

Future<void> Fin_Get_Chart_of_acc(
    data_api2 api, List<ModelChartAccMaster> list, String cid ) async {
  try {
    await mLoadModel_All(
          api,
          [
            {"tag": "7","p_cid":cid}
          ],
          list,
          (x) => ModelChartAccMaster.fromJson(x));
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}