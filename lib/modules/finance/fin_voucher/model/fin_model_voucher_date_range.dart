class FinModelVoucherDateRange {
  int? vid;
  int? vtypeId;
  String? vtName;
  String? vtSortName;
  String? vno;
  String? remarks;
  String? vdate;
  String? createdDate;
  int? status;
  String? createdBy;
  String? createdByEno;
  String? appDate;
  String? appBy;
  String? cancelDate;
  String? cancelBy;
  String? appCancelNote;
  double? amt;

  FinModelVoucherDateRange(
      {this.vid,
      this.vtypeId,
      this.vtName,
      this.vtSortName,
      this.vno,
      this.remarks,
      this.vdate,
      this.createdDate,
      this.status,
      this.createdBy,
      this.createdByEno,
      this.appDate,
      this.appBy,
      this.cancelDate,
      this.cancelBy,
      this.appCancelNote,
      this.amt});

  FinModelVoucherDateRange.fromJson(Map<String, dynamic> json) {
    vid = json['vid'];
    vtypeId = json['vtype_id'];
    vtName = json['vt_name'];
    vtSortName = json['vt_sort_name'];
    vno = json['vno'];
    remarks = json['remarks'];
    vdate = json['vdate'];
    createdDate = json['created_date'];
    status = json['status'];
    createdBy = json['created_by'];
    createdByEno = json['created_by_eno'];
    appDate = json['app_date'];
    appBy = json['app_by'];
    cancelDate = json['cancel_date'];
    cancelBy = json['cancel_by'];
    appCancelNote = json['app_cancel_note'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vid'] = this.vid;
    data['vtype_id'] = this.vtypeId;
    data['vt_name'] = this.vtName;
    data['vt_sort_name'] = this.vtSortName;
    data['vno'] = this.vno;
    data['remarks'] = this.remarks;
    data['vdate'] = this.vdate;
    data['created_date'] = this.createdDate;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_by_eno'] = this.createdByEno;
    data['app_date'] = this.appDate;
    data['app_by'] = this.appBy;
    data['cancel_date'] = this.cancelDate;
    data['cancel_by'] = this.cancelBy;
    data['app_cancel_note'] = this.appCancelNote;
    return data;
  }
}
