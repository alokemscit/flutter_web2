 

import 'package:web_2/core/config/const.dart';

import '../inv_supplier_master/model/inv_model_supplier_master.dart';

Future<void> Inv_Get_Year(data_api2 api, List<ModelCommonMaster> list, String cid) async {
  try{
  await mLoadModel(
    api,
    [
      {"tag": "75", "cid": cid}
    ],
    list,
    (json) => ModelCommonMaster.fromJson(json),
  );
  }catch(e){  
    throw Exception('Error occurred while loading model: $e');
  
  }
}

Future<void> Inv_Get_Store_Type(data_api2 api, List<ModelCommonMaster> list, String cid) async {
  try{
  await mLoadModel(
    api,
    [
      {"tag": "30", "cid": cid}
    ],
    list,
    (json) => ModelCommonMaster.fromJson(json),
  );
  }catch(e){  
    throw Exception('Error occurred while loading model: $e');
  
  }
}

Future<void> Inv_Get_Suppliers(data_api2 api, List<ModelSupplierMaster> list, String cid) async {
  try{
  await mLoadModel(
          api,
          [
            {"tag": "71", "cid": cid}
          ],
          list,
          (x) => ModelSupplierMaster.fromJson(x));
  }catch(e){  
    throw Exception('Error occurred while loading model: $e');
  
  }
}


Future<void> Inv_Get_MainStore(data_api2 api, List<ModelCommonMaster> list, String cid,String store_type_id)async {
  try{
  await mLoadModel(
          api,
          [
            {"tag": "88", "cid": cid,"store_type_id":store_type_id}
          ],
          list,
          (x) => ModelCommonMaster.fromJson(x));
  }catch(e){  
    throw Exception('Error occurred while loading model: $e');
  
  }
}