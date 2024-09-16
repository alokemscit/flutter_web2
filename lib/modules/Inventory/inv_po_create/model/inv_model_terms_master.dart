class ModelInvTermsMaster {
  int? id;
  String? name;
  int? status;
  int? isDefault;

  ModelInvTermsMaster({this.id, this.name, this.status, this.isDefault});

  ModelInvTermsMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['is_default'] = this.isDefault;
    return data;
  }
}
