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
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
