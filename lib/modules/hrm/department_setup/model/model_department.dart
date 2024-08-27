class ModelDepartment {
  String? id;
  String? name;
  String? status;
  String? catId;
  String? catname;

  ModelDepartment({this.id, this.name, this.status, this.catId, this.catname});

  ModelDepartment.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    catId = json['cat_id'].toString();
    catname = json['catname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['cat_id'] = this.catId;
    data['catname'] = this.catname;
    return data;
  }
}
