class ModelStatus {
  String? status;
  String? msg;
  String? id;
  String? extra;

  ModelStatus({
    this.status,
    this.msg,
    this.id,
    this.extra,
  });

  ModelStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    msg = json['msg'];
    id = json['id'].toString();
    extra = json['extra'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['id'] = id;
     data['extra'] = extra;
    return data;
  }
}
