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
    data['id'] = this.id;
    data['name'] = this.name;
    data['dep_id'] = this.depId;
    data['dep_name'] = this.depName;
    data['cat_id'] = this.catId;
    data['status'] = this.status;
    data['catname'] = this.catname;
    return data;
  }
}
