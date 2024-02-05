class ModuleCatDeptSection {
  String? id;
  String? name;
  String? status;
  String? fid;
  String? tp;

  ModuleCatDeptSection({this.id, this.name, this.status, this.fid, this.tp});

  ModuleCatDeptSection.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    fid = json['fid'].toString();
    tp = json['tp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['fid'] = this.fid;
    data['tp'] = this.tp;
    return data;
  }
}
