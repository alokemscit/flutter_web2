class ModelInvPrItemDetails {
  int? itemId;
  String? code;
  String? itemName;
  String? comName;
  String? genericName;
  String? groupName;
  String? subgroupName;
  String? initName;
  double? reqQty;
  double? appQty;
  double? remQty;
  double? qty;
   double? rate;

  ModelInvPrItemDetails(
      {this.itemId,
      this.code,
      this.itemName,
      this.comName,
      this.genericName,
      this.groupName,
      this.subgroupName,
      this.initName,
      this.reqQty,
      this.appQty,
      this.remQty,
      this.qty,
      this.rate});

  ModelInvPrItemDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    code = json['code'];
    itemName = json['item_name'];
    comName = json['com_name'];
    genericName = json['generic_name'];
    groupName = json['group_name'];
    subgroupName = json['subgroup_name'];
    initName = json['init_name'];
    reqQty = json['req_qty'];
    appQty = json['app_qty'];
    remQty = json['rem_qty'];
    qty = json['qty'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['code'] = this.code;
    data['item_name'] = this.itemName;
    data['com_name'] = this.comName;
    data['generic_name'] = this.genericName;
    data['group_name'] = this.groupName;
    data['subgroup_name'] = this.subgroupName;
    data['init_name'] = this.initName;
    data['req_qty'] = this.reqQty;
    data['app_qty'] = this.appQty;
    data['rem_qty'] = this.remQty;
    data['qty'] = this.qty;
     data['rate'] = this.rate;
    return data;
  }
}
