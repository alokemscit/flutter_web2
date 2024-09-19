class ModelComapny {
  String? id;
  String? name;
  String? image;

  ModelComapny({this.id, this.name, this.image});

  ModelComapny.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}