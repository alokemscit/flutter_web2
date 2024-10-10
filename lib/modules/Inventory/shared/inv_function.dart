import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';
import 'package:web_2/core/config/const.dart';

import '../../../component/custom_pdf_report_generator.dart';
import '../inv_grn_create/model/inv_grn_details_view.dart';
import '../inv_item_master/model/inv_model_item_master.dart';
import '../inv_supplier_master/model/inv_model_supplier_master.dart';

Future<void> Inv_Get_Year(
    data_api2 api, List<ModelCommonMaster> list, String cid) async {
  try {
    await mLoadModel(
      api,
      [
        {"tag": "75", "cid": cid}
      ],
      list,
      (json) => ModelCommonMaster.fromJson(json),
    );
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Inv_Get_Store_Type(
    data_api2 api, List<ModelCommonMaster> list, String cid) async {
  try {
    await mLoadModel(
      api,
      [
        {"tag": "30", "cid": cid}
      ],
      list,
      (json) => ModelCommonMaster.fromJson(json),
    );
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

//  {"tag": "63", "cid": user.value.cid}

Future<void> Inv_Get_Item_Master_All(
    data_api2 api, List<ModelItemMaster> list ,String cid ) async {
  try {
    await mLoadModel(
      api,
      [
       {"tag": "63", "cid": cid}
      ],
      list,
      (json) => ModelItemMaster.fromJson(json),
    );
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Inv_Get_priority_master(
    data_api2 api, List<ModelCommonMaster> list ) async {
  try {
    await mLoadModel(
      api,
      [
        {"tag": "64" }
      ],
      list,
      (json) => ModelCommonMaster.fromJson(json),
    );
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}


Future<void> Inv_Get_Users_Store(
    data_api2 api, List<ModelCommonMaster> list, String cid,String store_type_id,String empid) async {
  try {
    //@store_type_id int, @cid int=12,@emp_id
   
    await mLoadModel(
      api,
      [
        {"tag": "94", "store_type_id": store_type_id,"cid":cid,"emp_id":empid}
      ],
      list,
      (json) => ModelCommonMaster.fromJson(json),
    );
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}


Future<void> Inv_Get_Suppliers(
    data_api2 api, List<ModelSupplierMaster> list, String cid) async {
  try {
    await mLoadModel(
        api,
        [
          {"tag": "71", "cid": cid}
        ],
        list,
        (x) => ModelSupplierMaster.fromJson(x));
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

Future<void> Inv_Get_MainStore(data_api2 api, List<ModelCommonMaster> list,
    String cid, String store_type_id) async {
  try {
    await mLoadModel(
        api,
        [
          {"tag": "88", "cid": cid, "store_type_id": store_type_id}
        ],
        list,
        (x) => ModelCommonMaster.fromJson(x));
  } catch (e) {
    throw Exception('Error occurred while loading model: $e');
  }
}

void report_grn(Font font,  List<ModelGrnDetailsView> list_grn_details_view,
    Rx<ModelUser> user, Function()? fun) async {
  

  var x = list_grn_details_view.first;
  var total = list_grn_details_view.fold(0.0, (previousValue, element) {
    return previousValue + (element.tot ?? 0.0);
  });

  CustomPDFGenerator(
      font: font,
      header: [
        pwTextOne(font, '', user.value.cname ?? ''),
        pwHeight(),
        pwTextOne(font, 'Store Type : ', x.storeName ?? '', 9,
            pwMainAxisAlignmentStart),
        pwHeight(4),
        pwText2Col(
            font, "GRN. No : ", x.grnNo ?? '', 'GRN. Date : ', x.grnDate ?? ''),
        pwHeight(4),
        pwText2Col(font, "Chalan. No : ", x.chalanNo ?? '', 'Chalan. Date : ',
            x.chalanDate ?? ''),
        pwHeight(4),
        pwText2Col(
            font,
            "PO. No : ",
            x.poNo ?? '',
            'GRN. Status : ',
            (x.currentStatus ?? 0) == 0
                ? 'Canceled'
                : (x.currentStatus ?? 0) == 2
                    ? "Approved"
                    : "Approval Pending"),
        pwHeight(4),
        pwTextOne(
            font, 'Remarks : ', x.remarks ?? '', 9, pwMainAxisAlignmentStart)
      ],
      footer: [
        pwText2Col(font, "GRN. Created By : ", x.createdBy ?? '',
            'Created. Date : ', x.createdDate ?? ''),
        pwHeight(4),
        (x.currentStatus ?? 0) == 2
            ? pwText2Col(font, "Approved By : ", x.appBy ?? '',
                'Created. Date : ', x.appDate ?? '')
            : (x.currentStatus ?? 0) == 0
                ? pwText2Col(font, "Canceled By : ", x.cancelBy ?? '',
                    'Created. Date : ', x.cancelDate ?? '')
                : pwSizedBox(),
        pwText2Col(
            font,
            "Printed By : ",
            user.value.name ?? '',
            'Printed Date : ',
            DateFormat('dd/MM/yyyy hh:mm PM').format(DateTime.now())),
      ],
      body: [
        pwGenerateTable([
          15,
          50,
          20,
          20,
          20,
          20,
          20,
          20,
          20,
          30
        ], [
          pwTableColumnHeader('Code', font),
          pwTableColumnHeader('Name', font),
          pwTableColumnHeader('Type', font, pwAligmentCenter),
          pwTableColumnHeader('Unit', font, pwAligmentCenter),
          pwTableColumnHeader('Batch', font, pwAligmentCenter),
          pwTableColumnHeader('MRP', font, pwAligmentCenter),
          pwTableColumnHeader('Price', font, pwAligmentCenter),
          pwTableColumnHeader('Disc(%)', font, pwAligmentCenter),
          pwTableColumnHeader('Qty', font, pwAligmentCenter),
          pwTableColumnHeader('Total', font, pwAligmentRight),
        ], [
          ...list_grn_details_view.map((f) => pwTableRow([
                pwTableCell(f.code ?? '', font, pwAligmentLeft, 8),
                pwTableCell(f.itemName ?? '', font, pwAligmentLeft, 8),
                pwTableCell(f.subgroupName ?? '', font, pwAligmentCenter, 8),
                pwTableCell(f.unitName ?? '', font, pwAligmentCenter, 8),
                pwTableCell(f.batch_no ?? '', font, pwAligmentCenter, 8),
                pwTableCell(
                    (f.mrp ?? 0).toStringAsFixed(2), font, pwAligmentCenter, 8),
                pwTableCell((f.price ?? 0).toStringAsFixed(2), font,
                    pwAligmentCenter, 8),
                pwTableCell((f.disc ?? 0).toStringAsFixed(2), font,
                    pwAligmentCenter, 8),
                pwTableCell(
                    (f.qty ?? 0).toStringAsFixed(2), font, pwAligmentCenter, 8),
                pwTableCell(
                    (f.tot ?? 0).toStringAsFixed(2), font, pwAligmentRight, 8),
              ])),
        ]),
        pwGenerateTable([
          15 + 50 + 20 + 20 + 20 + 20 + 20,
          20 + 20,
          30,
        ], [
          pwTableColumnHeader('', font),
          pwTableColumnHeader('Grand Total', font, pwAligmentRight, 9.5),
          pwTableColumnHeader(
              total.toStringAsFixed(2), font, pwAligmentRight, 9.5)
        ], []),
          pwSizedBox(8),
      x.app_cancel_remarks==null?pwSizedBox(): pwTextOne(font, 'Approval Remarks : ', x.app_cancel_remarks??'',9,pwMainAxisAlignmentStart)
      ],
      fun: () {
        // loader.close();
        if (fun != null) {
          fun();
        }
      }).ShowReport();
}
