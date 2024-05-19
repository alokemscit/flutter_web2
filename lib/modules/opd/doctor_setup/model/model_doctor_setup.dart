class ModuleDoctorSetup {
  String? cid;
  String? jobCatId;
  String? catname;
  String? depId;
  String? dpname;
  String? sectionId;
  String? secname;
  String? dname;
  String? eno;
  String? uid;
  Null? img;

  ModuleDoctorSetup(
      {this.cid,
      this.jobCatId,
      this.catname,
      this.depId,
      this.dpname,
      this.sectionId,
      this.secname,
      this.dname,
      this.eno,
      this.uid,
      this.img});

  ModuleDoctorSetup.fromJson(Map<String, dynamic> json) {
    cid = json['cid'].toString();
    jobCatId = json['job_cat_id'].toString();
    catname = json['catname'];
    depId = json['dep_id'].toString();
    dpname = json['dpname'];
    sectionId = json['section_id'].toString();
    secname = json['secname'];
    dname = json['dname'];
    eno = json['eno'];
    uid = json['uid'].toString();
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cid'] = this.cid;
    data['job_cat_id'] = this.jobCatId;
    data['catname'] = this.catname;
    data['dep_id'] = this.depId;
    data['dpname'] = this.dpname;
    data['section_id'] = this.sectionId;
    data['secname'] = this.secname;
    data['dname'] = this.dname;
    data['eno'] = this.eno;
    data['uid'] = this.uid;
    data['img'] = this.img;
    return data;
  }
}
