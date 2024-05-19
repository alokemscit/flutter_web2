 

class ModelStatusMaster {
  String? id;
  String? name;

  ModelStatusMaster({this.id, this.name});

  ModelStatusMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

 List<ModelStatusMaster> getStatusMaster() {
  List<ModelStatusMaster> ml = [];
  ml.add(ModelStatusMaster(id: "1", name: "Active"));
  ml.add(ModelStatusMaster(id: "0", name: "Inactive"));
  return ml;
}
