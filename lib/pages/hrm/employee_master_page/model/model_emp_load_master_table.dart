class ModelMasterEmpTable {
  String? id;
  String? name;
  String? tp;
  String? status;

  ModelMasterEmpTable({this.id, this.name, this.tp, this.status});

  // @override
  // int get hashCode => id.hashCode ^ name.hashCode;
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is ModelMasterEmpTable &&
  //         runtimeType == other.runtimeType &&
  //         //id == other.id &&
  //         name == other.name;

  ModelMasterEmpTable.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    tp = json['tp'];
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tp'] = tp;
    data['status'] = status;
    return data;
  }
}
