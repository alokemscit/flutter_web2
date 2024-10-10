class FinModelCostCenter {
  int? id;
  String? code;
  String? name;
  String? description;
  int? status;

  FinModelCostCenter(
      {this.id, this.code, this.name, this.description, this.status});

  FinModelCostCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}
