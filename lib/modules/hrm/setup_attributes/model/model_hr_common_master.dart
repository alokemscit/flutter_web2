class ModelCommonMaster {
  String? id;
  String? name;
  String? status;
   

  ModelCommonMaster({this.id, this.name, this.status });

  ModelCommonMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
      data['name'] = this.name;
    
    return data;
  }
}
