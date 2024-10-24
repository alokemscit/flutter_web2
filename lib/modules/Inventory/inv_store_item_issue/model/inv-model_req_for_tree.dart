class ModelRequisitionForTree {
  String? monthName;
  String? reqNo;
  int? id;
  String? storeName;
  int? store_id;
  int? mid;

  ModelRequisitionForTree(
      {this.monthName, this.reqNo, this.id, this.storeName, this.mid});

  ModelRequisitionForTree.fromJson(Map<String, dynamic> json) {
    monthName = json['month_name'];
    reqNo = json['req_no'];
    id = json['id'];
    storeName = json['store_name'];
    store_id = json['store_id'];
    mid = json['mid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_name'] = this.monthName;
    data['req_no'] = this.reqNo;
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['store_id'] = this.store_id;
    data['mid'] = this.mid;
    return data;
  }
}
