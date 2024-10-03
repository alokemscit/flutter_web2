class ModelGrnMAsterView {
  int? poId;
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
  String? grnDate1;
  String? chalanNo;
  String? chalanDate;
  String? appBy;
  String? appDate;
  int? status;
  String? cancelBy;
  String? cancelDate;
  String? remarks;
  int? cur_status;

  ModelGrnMAsterView(
      {this.poId,
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
      this.grnDate1,
      this.chalanNo,
      this.chalanDate,
      this.appBy,
      this.appDate,
      this.status,
      this.cancelBy,
      this.cancelDate,
      this.remarks,
      this.cur_status});

  ModelGrnMAsterView.fromJson(Map<String, dynamic> json) {
    poId = json['po_id'];
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
    grnDate1 = json['grn_date1'];
    chalanNo = json['chalan_no'];
    chalanDate = json['chalan_date'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    status = json['status'];
    cancelBy = json['cancel_by'];
    cancelDate = json['cancel_date'];
    remarks = json['remarks'];
    cur_status = json['current_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['po_id'] = this.poId;
    data['po_no'] = this.poNo;
    data['store_type_id'] = this.storeTypeId;
    data['grn_id'] = this.grnId;
    data['grn_no'] = this.grnNo;
    data['supp_id'] = this.suppId;
    data['sup_name'] = this.supName;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['grn_date'] = this.grnDate;
    data['is_app'] = this.isApp;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['grn_date1'] = this.grnDate1;
    data['chalan_no'] = this.chalanNo;
    data['chalan_date'] = this.chalanDate;
    data['app_by'] = this.appBy;
    data['app_date'] = this.appDate;
    data['status'] = this.status;
    data['cancel_by'] = this.cancelBy;
    data['cancel_date'] = this.cancelDate;
    data['remarks'] = this.remarks;
    data['current_status'] = this.cur_status;
    return data;
  }
}
