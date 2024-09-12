class ModelItemSubGroupMaster {
  String? id;
  String? name;
  String? status;
  String? groupId;
  String? groupName;
  String? storeTypeId;
  String? storeTypeName;

  ModelItemSubGroupMaster(
      {this.id,
      this.name,
      this.status,
      this.groupId,
      this.groupName,
      this.storeTypeId,
      this.storeTypeName});

  ModelItemSubGroupMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    groupId = json['group_id'].toString();
    groupName = json['group_name'];
    storeTypeId = json['store_type_id'].toString();
    storeTypeName = json['store_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['group_id'] = groupId;
    data['group_name'] = groupName;
    data['store_type_id'] = storeTypeId;
    data['store_type_name'] = storeTypeName;
    return data;
  }
}
