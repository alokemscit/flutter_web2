class ModelHmsDepartmentMaster {
  String? id;
  String? deptId;
  String? name;
  String? status;
  String? deptName;

  ModelHmsDepartmentMaster(
      {this.id, this.deptId, this.name, this.status, this.deptName});

  ModelHmsDepartmentMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    deptId = json['dept_id'].toString();
    name = json['name'];
    status = json['status'].toString();
    deptName = json['dept_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dept_id'] = deptId;
    data['name'] = name;
    data['status'] = status;
    data['dept_name'] = deptName;
    return data;
  }
}
