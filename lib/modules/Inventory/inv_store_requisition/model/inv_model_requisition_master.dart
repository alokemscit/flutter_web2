class ModelRequisitionMaster {
  int? reqId;
  String? reqNo;
  String? reqDate;
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
  String? priority;
  int? currentStatusId;

  ModelRequisitionMaster(
      {this.reqId,
      this.reqNo,
      this.reqDate,
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
      this.priority});

  ModelRequisitionMaster.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    reqNo = json['req_no'];
    reqDate = json['req_dqte'];
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
    priority = json['priority_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_id'] = this.reqId;
    data['req_no'] = this.reqNo;
    data['req_dqte'] = this.reqDate;
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
    data['priority_name'] = this.priority;
    return data;
  }
}
