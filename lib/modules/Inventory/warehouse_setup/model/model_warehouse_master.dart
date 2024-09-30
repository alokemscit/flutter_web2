class ModelWareHouseMaster {
  String? id;
  String? name;
  String? status;
  String? isCentral;
  String? storeTypeName;
  String? storeTypeId;

  ModelWareHouseMaster(
      {this.id,
      this.name,
      this.status,
      this.isCentral,
      this.storeTypeName,
      this.storeTypeId});

  ModelWareHouseMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    isCentral = json['is_central'].toString();
    storeTypeName = json['store_type_name'];
    storeTypeId = json['store_type_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['is_central'] = isCentral;
    data['store_type_name'] = storeTypeName;
    data['store_type_id'] = storeTypeId;
    return data;
  }
}
