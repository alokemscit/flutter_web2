import 'package:web_2/core/config/functions.dart';
 

import '../../../core/common_model/model_common_master.dart';
import '../../../data/data_api.dart';
import '../fin_voucher/model/fin_model_voucher_type.dart';

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
