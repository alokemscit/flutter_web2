class ModelPoDetails {
  int? poId;
  String? prNo;
  String? poNo;
  String? poDate;
  String? deliveryDate;
  String? remarks;
  String? deliveryNote;
  String? code;
  int? itemId;
  String? itemName;
  String? generic;
  String? groupName;
  String? subGroupName;
  String? unitName;
  double? qty;
  double? rate;
  double? disc;
  double? discAmt;
  double? tot;
  double? isFree;
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
  double? app_qty;
  double? rem_qty;
  double? po_tot;

  ModelPoDetails(
      {this.poId,
      this.prNo,
      this.poDate,
      this.deliveryDate,
      this.remarks,
      this.deliveryNote,
      this.code,
      this.itemId,
      this.itemName,
      this.generic,
      this.groupName,
      this.subGroupName,
      this.unitName,
      this.qty,
      this.rate,
      this.disc,
      this.discAmt,
      this.tot,
      this.isFree,
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
      this.app_qty,
      this.poNo,
      this.rem_qty,
      this.po_tot});

  ModelPoDetails.fromJson(Map<String, dynamic> json) {
    poId = json['po_id'];
    prNo = json['pr_no'];
    poNo = json['po_no'];
    poDate = json['po_date'];
    deliveryDate = json['delivery_date'];
    remarks = json['remarks'];
    deliveryNote = json['delivery_note'];
    code = json['code'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    generic = json['generic'];
    groupName = json['group_name'];
    subGroupName = json['sub_group_name'];
    unitName = json['unit_name'];
    qty = json['qty'];
    rate = json['rate'];
    disc = json['disc'];
    discAmt = json['disc_amt'];
    tot = json['tot'];
    isFree = json['is_free'];
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
    app_qty = json['app_qty'];
    rem_qty = json['rem_qty'];
    po_tot = json['po_tot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['po_id'] = this.poId;
    data['pr_no'] = this.prNo;
    data['po_date'] = this.poDate;
    data['delivery_date'] = this.deliveryDate;
    data['remarks'] = this.remarks;
    data['delivery_note'] = this.deliveryNote;
    data['code'] = this.code;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['generic'] = this.generic;
    data['group_name'] = this.groupName;
    data['sub_group_name'] = this.subGroupName;
    data['unit_name'] = this.unitName;
    data['qty'] = this.qty;
    data['rate'] = this.rate;
    data['disc'] = this.disc;
    data['disc_amt'] = this.discAmt;
    data['tot'] = this.tot;
    data['is_free'] = this.isFree;
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
    return data;
  }
}
