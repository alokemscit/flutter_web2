class ModelRequisitionDetails {
  int? reqId;
  String? reqNo;
  String? reqDqte;
  String? remarks;
  int? storeId;
  String? storeName;
  int? storeTypeId;
  String? storeTypeName;
  int? status;
  int? createdBy;
  String? createdDate;
  String? createdByName;
  int? appBy;
  String? appDate;
  String? appByName;
  int? cancelBy;
  String? cancelDate;
  String? cancelByName;
  String? currentStatus;
  int? currentStatusId;
  String? code;
  int? itemId;
  String? itemName;
  String? genName;
  int? comId;
  String? comName;
  int? groupId;
  String? groupName;
  int? subgroupId;
  String? subgroupName;
  int? genId;
  int? unitId;
  String? unitName;
  double? reqQty;
  double? pendingQty;
  double? appQty;
  String? priorityName;
  double? c_stock;

  ModelRequisitionDetails(
      {this.reqId,
      this.reqNo,
      this.reqDqte,
      this.remarks,
      this.storeId,
      this.storeName,
      this.storeTypeId,
      this.storeTypeName,
      this.status,
      this.createdBy,
      this.createdDate,
      this.createdByName,
      this.appBy,
      this.appDate,
      this.appByName,
      this.cancelBy,
      this.cancelDate,
      this.cancelByName,
      this.currentStatus,
      this.currentStatusId,
      this.code,
      this.itemId,
      this.itemName,
      this.genName,
      this.comId,
      this.comName,
      this.groupId,
      this.groupName,
      this.subgroupId,
      this.subgroupName,
      this.genId,
      this.unitId,
      this.unitName,
      this.reqQty,
      this.pendingQty,
      this.appQty,
      this.priorityName,
      this.c_stock});

  ModelRequisitionDetails.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    reqNo = json['req_no'];
    reqDqte = json['req_dqte'];
    remarks = json['remarks'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeTypeId = json['store_type_id'];
    storeTypeName = json['store_type_name'];
    status = json['status'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    createdByName = json['created_by_name'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    appByName = json['app_by_name'];
    cancelBy = json['cancel_by'];
    cancelDate = json['cancel_date'];
    cancelByName = json['cancel_by_name'];
    currentStatus = json['current_status'];
    currentStatusId = json['current_status_id'];
    code = json['code'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    genName = json['gen_name'];
    comId = json['com_id'];
    comName = json['com_name'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    subgroupId = json['subgroup_id'];
    subgroupName = json['subgroup_name'];
    genId = json['gen_id'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    reqQty = json['req_qty'];
    pendingQty = json['pending_qty'];
    appQty = json['app_qty'];
    priorityName = json['priority_name'];
    c_stock = json['c_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_id'] = this.reqId;
    data['req_no'] = this.reqNo;
    data['req_dqte'] = this.reqDqte;
    data['remarks'] = this.remarks;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_type_id'] = this.storeTypeId;
    data['store_type_name'] = this.storeTypeName;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['created_by_name'] = this.createdByName;
    data['app_by'] = this.appBy;
    data['app_date'] = this.appDate;
    data['app_by_name'] = this.appByName;
    data['cancel_by'] = this.cancelBy;
    data['cancel_date'] = this.cancelDate;
    data['cancel_by_name'] = this.cancelByName;
    data['current_status'] = this.currentStatus;
    data['current_status_id'] = this.currentStatusId;
    data['code'] = this.code;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['gen_name'] = this.genName;
    data['com_id'] = this.comId;
    data['com_name'] = this.comName;
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['subgroup_id'] = this.subgroupId;
    data['subgroup_name'] = this.subgroupName;
    data['gen_id'] = this.genId;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    data['req_qty'] = this.reqQty;
    data['pending_qty'] = this.pendingQty;
    data['app_qty'] = this.appQty;
    data['priority_name'] = this.priorityName;
    data['c_stock'] = this.c_stock;
    return data;
  }
}
