class ModelItemMaster {
  String? id;
  String? cid;
  String? code;
  String? comId;
  String? genId;
  String? groupId;
  String? subGroupId;
  String? storeTypeId;
  String? unitId;
  String? name;
  String? conName;
  String? genName;
  String? grpName;
  String? sgrpName;
  String? stypeName;
  String? unitName;

  ModelItemMaster(
      {
        this.id,
        this.cid,
      this.code,
      this.comId,
      this.genId,
      this.groupId,
      this.subGroupId,
      this.storeTypeId,
      this.unitId,
      this.name,
      this.conName,
      this.genName,
      this.grpName,
      this.sgrpName,
      this.stypeName,
      this.unitName});

  ModelItemMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() ;
    cid = json['cid'].toString() ;
    code = json['code'];
    comId = json['com_id'].toString();
    genId = json['gen_id'].toString();
    groupId = json['group_id'].toString();
    subGroupId = json['sub_group_id'].toString();
    storeTypeId = json['store_type_id'].toString();
    unitId = json['unit_id'].toString();
    name = json['name'];
    conName = json['con_name'];
    genName = json['gen_name'];
    grpName = json['grp_name'];
    sgrpName = json['sgrp_name'];
    stypeName = json['stype_name'];
    unitName = json['unit_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cid'] = this.cid;
  //   data['code'] = this.code;
  //   data['com_id'] = this.comId;
  //   data['gen_id'] = this.genId;
  //   data['group_id'] = this.groupId;
  //   data['sub_group_id'] = this.subGroupId;
  //   data['store_type_id'] = this.storeTypeId;
  //   data['unit_id'] = this.unitId;
  //   data['name'] = this.name;
  //   data['con_name'] = this.conName;
  //   data['gen_name'] = this.genName;
  //   data['grp_name'] = this.grpName;
  //   data['sgrp_name'] = this.sgrpName;
  //   data['stype_name'] = this.stypeName;
  //   data['unit_name'] = this.unitName;
  //   return data;
  // }
}
