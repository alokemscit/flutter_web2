// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelStoreUnit {
  String? id;
  String? name;
  String? status;
  String? stypeID;
  String? stypeName;
  ModelStoreUnit({
    this.id,
    this.name,
    this.status,
    required this.stypeID,
    required this.stypeName,
  });
  ModelStoreUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    stypeID = json['store_type_id'].toString();
    stypeName = json['store_type_name'];
  }
}
