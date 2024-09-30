class ModelPRforApproval {
  int? id;
  String? prNo;
  String? createdDate;
  String? eno;
  String? createdBy;
  String? prDate;
  String? remarks;
  String? priorityName;

  ModelPRforApproval(
      {this.id,
      this.prNo,
      this.createdDate,
      this.eno,
      this.createdBy,
      this.prDate,
      this.remarks,
      this.priorityName});

  ModelPRforApproval.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prNo = json['pr_no'];
    createdDate = json['created_date'];
    eno = json['eno'];
    createdBy = json['created_by'];
    prDate = json['pr_date'];
    remarks = json['remarks'];
    priorityName = json['priority_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pr_no'] = prNo;
    data['created_date'] = createdDate;
    data['eno'] = eno;
    data['created_by'] = createdBy;
    data['pr_date'] = prDate;
    data['remarks'] = remarks;
    data['priority_name'] = priorityName;
    return data;
  }
}
