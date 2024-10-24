class ModelGrnMasterForApp {
  int? poId;
  String? grnMonth;
  String? poNo;
  int? storeTypeId;
  int? grnId;
  String? grnNo;
  int? suppId;
  String? supName;
  int? storeId;
  String? storeName;
  String? grnDate;
  int? isApp;
  String? createdBy;
  String? createdDate;

  String? chalanNo;
  String? chalanDate;
  String? appBy;
  String? appDate;
  int? status;
  String? cancelBy;
  String? cancelDate;
  String? remarks;
  int? currentStatus;
  String? delivery_date;
  String? delivery_note;

  ModelGrnMasterForApp(
      {this.poId,
      this.grnMonth,
      this.poNo,
      this.storeTypeId,
      this.grnId,
      this.grnNo,
      this.suppId,
      this.supName,
      this.storeId,
      this.storeName,
      this.grnDate,
      this.isApp,
      this.createdBy,
      this.createdDate,
      this.chalanNo,
      this.chalanDate,
      this.appBy,
      this.appDate,
      this.status,
      this.cancelBy,
      this.cancelDate,
      this.remarks,
      this.currentStatus,
      this.delivery_date,
      this.delivery_note});

  ModelGrnMasterForApp.fromJson(Map<String, dynamic> json) {
    poId = json['po_id'];
    grnMonth = json['grn_month'];
    poNo = json['po_no'];
    storeTypeId = json['store_type_id'];
    grnId = json['grn_id'];
    grnNo = json['grn_no'];
    suppId = json['supp_id'];
    supName = json['sup_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    grnDate = json['grn_date'];
    isApp = json['is_app'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];

    chalanNo = json['chalan_no'];
    chalanDate = json['chalan_date'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    status = json['status'];
    cancelBy = json['cancel_by'];
    cancelDate = json['cancel_date'];
    remarks = json['remarks'];
    currentStatus = json['current_status'];
    delivery_date = json['delivery_date'];
    delivery_note = json['delivery_note'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['po_id'] = this.poId;
  //   data['grn_month'] = this.grnMonth;
  //   data['po_no'] = this.poNo;
  //   data['store_type_id'] = this.storeTypeId;
  //   data['grn_id'] = this.grnId;
  //   data['grn_no'] = this.grnNo;
  //   data['supp_id'] = this.suppId;
  //   data['sup_name'] = this.supName;
  //   data['store_id'] = this.storeId;
  //   data['store_name'] = this.storeName;
  //   data['grn_date'] = this.grnDate;
  //   data['is_app'] = this.isApp;
  //   data['created_by'] = this.createdBy;
  //   data['created_date'] = this.createdDate;

  //   data['chalan_no'] = this.chalanNo;
  //   data['chalan_date'] = this.chalanDate;
  //   data['app_by'] = this.appBy;
  //   data['app_date'] = this.appDate;
  //   data['status'] = this.status;
  //   data['cancel_by'] = this.cancelBy;
  //   data['cancel_date'] = this.cancelDate;
  //   data['remarks'] = this.remarks;
  //   data['current_status'] = this.currentStatus;
  //   return data;
  // }
}
