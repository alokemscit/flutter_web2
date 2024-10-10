class ModelGrnDetailsView {
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

  String? chalanNo;
  String? chalanDate;
  String? appBy;
  String? appDate;
  int? status;
  String? cancelBy;
  String? cancelDate;
  String? remarks;
  int? currentStatus;
  int? itemId;
  String? code;
  String? itemName;

  int? genId;
  String? genName;
  int? groupId;
  String? groupName;
  int? subgroupId;
  String? subgroupName;
  int? unitId;
  String? unitName;
  int? comId;
  String? comName;
  int? is_free;
  String? exp_date;
  String? batch_no;
  double? qty;
  double? price;
  double? disc;
  double? mrp;
  double? tot;
  double? po_app_qty;
  double? rem_qty;
  String? app_cancel_remarks;

  ModelGrnDetailsView(
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
      this.chalanNo,
      this.chalanDate,
      this.appBy,
      this.appDate,
      this.status,
      this.cancelBy,
      this.cancelDate,
      this.remarks,
      this.currentStatus,
      this.code,
      this.itemId,
      this.itemName,
      this.genId,
      this.genName,
      this.groupId,
      this.groupName,
      this.subgroupId,
      this.subgroupName,
      this.unitId,
      this.unitName,
      this.comId,
      this.comName,
      this.batch_no,
      this.disc,
      this.exp_date,
      this.is_free,
      this.mrp,
      this.price,
      this.qty,
      this.tot,
      this.po_app_qty,
      this.rem_qty,
      this.app_cancel_remarks});

  ModelGrnDetailsView.fromJson(Map<String, dynamic> json) {
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

    chalanNo = json['chalan_no'];
    chalanDate = json['chalan_date'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    status = json['status'];
    cancelBy = json['cancel_by'];
    cancelDate = json['cancel_date'];
    remarks = json['remarks'];
    currentStatus = json['current_status'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    code = json['code'];
    genId = json['gen_id'];
    genName = json['gen_name'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    subgroupId = json['subgroup_id'];
    subgroupName = json['subgroup_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    comId = json['com_id'];
    comName = json['com_name'];
    is_free = json['is_free'];
    exp_date = json['exp_date'];
    batch_no = json['batch_no'];
    qty = json['qty'];
    price = json['price'];
    disc = json['disc'];
    mrp = json['mrp'];
    tot = json['tot'];
    rem_qty = json['rem_qty'];
    po_app_qty = json['po_app_qty'];
    app_cancel_remarks = json['app_cancel_remarks'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['po_id'] = this.poId;
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
  //   data['grn_date1'] = this.grnDate1;
  //   data['chalan_no'] = this.chalanNo;
  //   data['chalan_date'] = this.chalanDate;
  //   data['app_by'] = this.appBy;
  //   data['app_date'] = this.appDate;
  //   data['status'] = this.status;
  //   data['cancel_by'] = this.cancelBy;
  //   data['cancel_date'] = this.cancelDate;
  //   data['remarks'] = this.remarks;
  //   data['current_status'] = this.currentStatus;
  //   data['item_id'] = this.itemId;
  //   data['item_name'] = this.itemName;
  //   data['status1'] = this.status1;
  //   data['gen_id'] = this.genId;
  //   data['gen_name'] = this.genName;
  //   data['group_id'] = this.groupId;
  //   data['group_name'] = this.groupName;
  //   data['subgroup_id'] = this.subgroupId;
  //   data['subgroup_name'] = this.subgroupName;
  //   data['unit_id'] = this.unitId;
  //   data['unit_name'] = this.unitName;
  //   data['com_id'] = this.comId;
  //   data['com_name'] = this.comName;
  //   return data;
  // }
}
