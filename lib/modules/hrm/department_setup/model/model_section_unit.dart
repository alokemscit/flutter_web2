class ModelSectionUnit {
  String? id;
  String? name;
  String? depId;
  String? depName;
  String? catId;
  String? status;
  String? catname;

  ModelSectionUnit(
      {this.id,
      this.name,
      this.depId,
      this.depName,
      this.catId,
      this.status,
      this.catname});

  ModelSectionUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    depId = json['dep_id'].toString();
    depName = json['dep_name'];
    catId = json['cat_id'].toString();
    status = json['status'].toString();
    catname = json['catname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dep_id'] = depId;
    data['dep_name'] = depName;
    data['cat_id'] = catId;
    data['status'] = status;
    data['catname'] = catname;
    return data;
  }
}
