class ModelPoMasterForApp {
  String? monthName;
  String? poNo;
  int? id;
  int? pr_id;
  String? poDate;
  String? deliveryDate;
  String? remarks;
  String? deliveryNote;
  int? supId;
  String? subName;
  String? supAddress;
  String? supMob;
  String? createdDate;
  int? uid;
  String? createdByNo;
  String? createdBy;
  String? appBy;
  String? appDate;
  String? canceledBy;
  String? canceledDate;
  int? isApp;

  ModelPoMasterForApp(
      {this.monthName,
      this.poNo,
      this.id,
      this.poDate,
      this.deliveryDate,
      this.remarks,
      this.deliveryNote,
      this.subName,
      this.supAddress,
      this.supMob,
      this.createdDate,
      this.uid,
      this.createdByNo,
      this.createdBy,
      this.appBy,
      this.appDate,
      this.canceledBy,
      this.canceledDate,
      this.isApp,
      this.supId,
      this.pr_id});

  ModelPoMasterForApp.fromJson(Map<String, dynamic> json) {
    monthName = json['month_name'];
    poNo = json['po_no'];
    id = json['id'];
    poDate = json['po_date'];
    deliveryDate = json['delivery_date'];
    remarks = json['remarks'];
    deliveryNote = json['delivery_note'];
    subName = json['sub_name'];
    supAddress = json['sup_address'];
    supMob = json['sup_mob'];
    createdDate = json['created_date'];
    uid = json['uid'];
    createdByNo = json['created_by_no'];
    createdBy = json['created_by'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    canceledBy = json['canceled_by'];
    canceledDate = json['canceled_date'];
    isApp = json['is_app'];
    supId = json['sup_id'];
    pr_id = json['pr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_name'] = this.monthName;
    data['po_no'] = this.poNo;
    data['id'] = this.id;
    data['po_date'] = this.poDate;
    data['delivery_date'] = this.deliveryDate;
    data['remarks'] = this.remarks;
    data['delivery_note'] = this.deliveryNote;
    data['sub_name'] = this.subName;
    data['sup_address'] = this.supAddress;
    data['sup_mob'] = this.supMob;
    data['created_date'] = this.createdDate;
    data['uid'] = this.uid;
    data['created_by_no'] = this.createdByNo;
    data['created_by'] = this.createdBy;
    data['app_by'] = this.appBy;
    data['app_date'] = this.appDate;
    data['canceled_by'] = this.canceledBy;
    data['canceled_date'] = this.canceledDate;
    data['is_app'] = this.isApp;
    data['sup_id'] = this.supId;
    return data;
  }
}
