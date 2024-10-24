class FinModelVoucherDetails {
  int? vid;
  int? vtypeId;
  String? vtName;
  String? vtSortName;
  String? vno;
  int? drcrId;
  String? drcrName;
  int? glId;
  String? glName;
  String? glCode;
  int? slId;
  String? slName;
  String? slCode;
  int? ccId;
  String? ccName;
  String? ccCode;
  int? sl;
  int? amount;
  String? narration;
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

  FinModelVoucherDetails(
      {this.vid,
      this.vtypeId,
      this.vtName,
      this.vtSortName,
      this.vno,
      this.drcrId,
      this.drcrName,
      this.glId,
      this.glName,
      this.glCode,
      this.slId,
      this.slName,
      this.slCode,
      this.ccId,
      this.ccName,
      this.ccCode,
      this.sl,
      this.amount,
      this.narration,
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
      this.appCancelNote});

  FinModelVoucherDetails.fromJson(Map<String, dynamic> json) {
    vid = json['vid'];
    vtypeId = json['vtype_id'];
    vtName = json['vt_name'];
    vtSortName = json['vt_sort_name'];
    vno = json['vno'];
    drcrId = json['drcr_id'];
    drcrName = json['drcr_name'];
    glId = json['gl_id'];
    glName = json['gl_name'];
    glCode = json['gl_code'];
    slId = json['sl_id'];
    slName = json['sl_name'];
    slCode = json['sl_code'];
    ccId = json['cc_id'];
    ccName = json['cc_name'];
    ccCode = json['cc_code'];
    sl = json['sl'];
    amount = json['amount'];
    narration = json['narration'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vid'] = this.vid;
    data['vtype_id'] = this.vtypeId;
    data['vt_name'] = this.vtName;
    data['vt_sort_name'] = this.vtSortName;
    data['vno'] = this.vno;
    data['drcr_id'] = this.drcrId;
    data['drcr_name'] = this.drcrName;
    data['gl_id'] = this.glId;
    data['gl_name'] = this.glName;
    data['gl_code'] = this.glCode;
    data['sl_id'] = this.slId;
    data['sl_name'] = this.slName;
    data['sl_code'] = this.slCode;
    data['cc_id'] = this.ccId;
    data['cc_name'] = this.ccName;
    data['cc_code'] = this.ccCode;
    data['sl'] = this.sl;
    data['amount'] = this.amount;
    data['narration'] = this.narration;
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
