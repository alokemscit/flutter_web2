class ModelDepartmentCategory {
  String? id;
  String? name;
  String? status;

  ModelDepartmentCategory({this.id, this.name, this.status});

  ModelDepartmentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
