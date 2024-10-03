class ModelHrDesignationMaster {
  int? id;
  String? name;
  int? status;
  int? corpDesigId;
  String? corpDesigName;

  ModelHrDesignationMaster(
      {this.id, this.name, this.status, this.corpDesigId, this.corpDesigName});

  ModelHrDesignationMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    corpDesigId = json['corp_desig_id'];
    corpDesigName = json['corp_desig_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['corp_desig_id'] = this.corpDesigId;
    data['corp_desig_name'] = this.corpDesigName;
    return data;
  }
}
