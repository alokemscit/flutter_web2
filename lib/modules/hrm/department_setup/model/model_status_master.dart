 

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
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
