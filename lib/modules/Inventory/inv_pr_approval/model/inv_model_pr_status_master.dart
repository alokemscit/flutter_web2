class ModelPReqStatus {
  String? id;
  String? prNo;
  String? createdDate;
  String? createdEmpno;
  String? createdBy;
  String? prDate;
  String? remarks;
  String? priorityName;
  String? appBy;
  String? appDate;
  String? cancelBy;
  String? cancelDate;
  String? appNote;

  ModelPReqStatus(
      {this.id,
      this.prNo,
      this.createdDate,
      this.createdEmpno,
      this.createdBy,
      this.prDate,
      this.remarks,
      this.priorityName,
      this.appBy,
      this.appDate,
      this.cancelBy,
      this.cancelDate,
      this.appNote});

  ModelPReqStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    prNo = json['pr_no'];
    createdDate = json['created_date'];
    createdEmpno = json['created_empno'];
    createdBy = json['created_by'];
    prDate = json['pr_date'];
    remarks = json['remarks'];
    priorityName = json['priority_name'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    cancelBy = json['cancel_by'];
    cancelDate = json['cancel_date'];
    appNote = json['app_note'];
  }

}
