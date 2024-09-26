class ModelSupplierMaster {
  int? id;
  String? code;
  String? name;
  String? address;
  String? mob;
  int? slId;
  int? status;

  ModelSupplierMaster(
      {this.id,
      this.code,
      this.name,
      this.address,
      this.mob,
      this.slId,
      this.status});

  ModelSupplierMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
    mob = json['mob'];
    slId = json['sl_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['address'] = address;
    data['mob'] = mob;
    data['sl_id'] = slId;
    data['status'] = status;
    return data;
  }
}
