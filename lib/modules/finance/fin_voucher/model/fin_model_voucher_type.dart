class FinModelVoucherType {
  int? id;
  String? name;
  String? nameShort;

  FinModelVoucherType({this.id, this.name, this.nameShort});

  FinModelVoucherType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameShort = json['name_short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_short'] = this.nameShort;
    return data;
  }
}
