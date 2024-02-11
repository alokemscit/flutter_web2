class ModelCountry {
  int? id;
  String? code;
  String? name;
  int? sl;

  ModelCountry({this.id, this.code, this.name, this.sl});

  ModelCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    sl = json['sl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['sl'] = sl;
    return data;
  }
}