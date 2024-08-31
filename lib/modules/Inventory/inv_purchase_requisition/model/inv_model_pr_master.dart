class ModelPReqMaster {
  String? id;
  String? code;
  String? prNo;
  String? itemId;
  String? name;
  String? unitName;
  String? genName;
  String? grpName;
  String? sgrpName;
  String? storeTypeName;
  String? remQty;
  String? reqQty;
  String? rem;
  String? remarks;
  String? createdBy;
  String? eno;
  String? ename;
  String? createdDate;
  String? prDate;
  String? storeTypeId;
  String? status;
  String? appBy;
  String? appByName;
  String? appDate;
  String? priorityName;
  String? cancelByName;
  String? cancelDate;

  ModelPReqMaster(
      {this.id,
      this.prNo,
      this.itemId,
      this.name,
      this.unitName,
      this.genName,
      this.grpName,
      this.sgrpName,
      this.storeTypeName,
      this.remQty,
      this.reqQty,
      this.rem,
      this.remarks,
      this.createdBy,
      this.eno,
      this.ename,
      this.createdDate,
      this.prDate,
      this.storeTypeId,
      this.status,
      this.appBy,
      this.appByName,
      this.appDate,
      this.priorityName,
      this.cancelByName,
      this.cancelDate,
      this.code});

  ModelPReqMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    code = json['code'];
    prNo = json['pr_no'];
    itemId = json['item_id'].toString();
    name = json['name'];
    unitName = json['unit_name'];
    genName = json['gen_name'];
    grpName = json['grp_name'];
    sgrpName = json['sgrp_name'];
    storeTypeName = json['store_type_name'];
    remQty = json['rem_qty'].toString();
    reqQty = json['req_qty'].toString();
    rem = json['rem'];
    remarks = json['remarks'];
    createdBy = json['created_by'].toString();
    eno = json['eno'];
    ename = json['ename'];
    createdDate = json['created_date'];
    prDate = json['pr_date'];
    storeTypeId = json['store_type_id'].toString();
    status = json['status'].toString();
    appBy = json['app_by'].toString();
    appByName = json['app_by_name'];
    appDate = json['app_date'];
    priorityName = json['priority_name'];
    cancelByName = json['cancel_by_name'];
    cancelDate = json['cancel_date'];
    
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['pr_no'] = this.prNo;
  //   data['item_id'] = this.itemId;
  //   data['name'] = this.name;
  //   data['unit_name'] = this.unitName;
  //   data['gen_name'] = this.genName;
  //   data['grp_name'] = this.grpName;
  //   data['sgrp_name'] = this.sgrpName;
  //   data['store_type_name'] = this.storeTypeName;
  //   data['rem_qty'] = this.remQty;
  //   data['req_qty'] = this.reqQty;
  //   data['rem'] = this.rem;
  //   data['remarks'] = this.remarks;
  //   data['created_by'] = this.createdBy;
  //   data['eno'] = this.eno;
  //   data['ename'] = this.ename;
  //   data['created_date'] = this.createdDate;
  //   data['pr_date'] = this.prDate;
  //   data['store_type_id'] = this.storeTypeId;
  //   data['status'] = this.status;
  //   data['app_by'] = this.appBy;
  //   data['app_by_name'] = this.appByName;
  //   data['app_date'] = this.appDate;
  //   data['priority_name'] = this.priorityName;
  //   data['cancel_by_name'] = this.cancelByName;
  //   data['cancel_date'] = this.cancelDate;
  //   return data;
  // }
}
