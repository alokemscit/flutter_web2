class ModelGenericMaster {
  String? id;
  String? name;
  String? status;
  String? stypeId;
  String? stypeName;

  ModelGenericMaster(
      {this.id, this.name, this.status, this.stypeId, this.stypeName});

  ModelGenericMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    stypeId = json['stype_id'].toString();
    stypeName = json['stype_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['status'] = this.status;
  //   data['stype_id'] = this.stypeId;
  //   data['stype_name'] = this.stypeName;
  //   return data;
  // }
}
