class ModelStatus {
  String? status;
  String? msg;
  String? id;

  ModelStatus({this.status, this.msg, this.id});

  ModelStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    msg = json['msg'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['id'] = id;
    return data;
  }
}