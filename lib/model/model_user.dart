class ModelUser {
  String? status;
  String? msg;
  String? uid;
  String? cid;
  String? depId;
  String? desigId;
  String? name;
  String? img;
  String? code;
  String? cname;
  String? dpname;
  String? dgname;
  String? face1;
   String? face2;
    String? mob;
  ModelUser(
      {this.status,
      this.msg,
      this.uid,
      this.cid,
      this.depId,
      this.desigId,
      this.name,
      this.img,
      this.code,
      this.cname,
      this.dpname,
      this.dgname,
      this.face1,
      this.face2,
      this.mob,
      });

  ModelUser.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    msg= json['msg'].toString();
    uid = json['uid'].toString();
    cid = json['cid'].toString();
    depId = json['dep_id'].toString();
    desigId = json['desig_id'].toString();
    name = json['name'].toString();
    img = json['img'].toString();
    code = json['code'].toString();
    cname = json['cname'].toString();
    dpname = json['dpname'].toString();
    dgname = json['dgname'].toString();
    face1 = json['face1'].toString();
    face2 = json['face2'].toString();
    mob = json['mob'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['uid'] = uid;
    data['cid'] = cid;
    data['dep_id'] = depId;
    data['desig_id'] = desigId;
    data['name'] = name;
    data['img'] = img;
    data['code'] = code;
    data['cname'] = cname;
    data['dpname'] = dpname;
    data['dgname'] = dgname;
    data['face1'] = face1;
    data['face2'] = face2;
    data['mob'] = mob;
    return data;
  }
}
