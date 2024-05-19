class ModelHmsSectionMaster {
  String? id;
  String? name;
  String? status;
  String? hmsDeptId;
  String? hmsDeptName;
  String? hrDeptId;
  String? hrDeptName;

  ModelHmsSectionMaster(
      {this.id,
      this.name,
      this.status,
      this.hmsDeptId,
      this.hmsDeptName,
      this.hrDeptId,
      this.hrDeptName});

  ModelHmsSectionMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    hmsDeptId = json['hms_dept_id'].toString();
    hmsDeptName = json['hms_dept_name'];
    hrDeptId = json['hr_dept_id'].toString();
    hrDeptName = json['hr_dept_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['hms_dept_id'] = this.hmsDeptId;
    data['hms_dept_name'] = this.hmsDeptName;
    data['hr_dept_id'] = this.hrDeptId;
    data['hr_dept_name'] = this.hrDeptName;
    return data;
  }
}
