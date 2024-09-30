class ModelItemGroupMaster {
  String? id;
  String? storeTypeId;
   String? storeTypeName;
  String? name;
  String? status;

  ModelItemGroupMaster({this.id, this.storeTypeId, this.storeTypeName, this.name, this.status});

  ModelItemGroupMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    storeTypeId = json['store_type_id'].toString();
    storeTypeName=json['store_type_name'].toString();
    name = json['name'];
    status = json['status'].toString();
  }
  //

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_type_id'] = storeTypeId;
     data['store_type_name'] = storeTypeName;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
