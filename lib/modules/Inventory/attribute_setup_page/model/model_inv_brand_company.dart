

class ModelInvBrandCompany {
  String? id;
  String? name;
  String? address;
  String? mob;
  String? stypeId;
  String? stypeName;

  ModelInvBrandCompany(
      {this.id,
      this.name,
      this.address,
      this.mob,
      this.stypeId,
      this.stypeName});

  ModelInvBrandCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    address = json['address'];
    mob = json['mob'];
    stypeId = json['stype_id'].toString();
    stypeName = json['stype_name'];
  }

   
}
