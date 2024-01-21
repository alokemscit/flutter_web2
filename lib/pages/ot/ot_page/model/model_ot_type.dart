class ModelOtType {
  String? tYPEID;
  String? tYPETITLE;
  String? rEMARKS;
  String? aCTIVE;

  ModelOtType({this.tYPEID, this.tYPETITLE, this.rEMARKS, this.aCTIVE});

  ModelOtType.fromJson(Map<String, dynamic> json) {
    tYPEID = json['TYPE_ID'];
    tYPETITLE = json['TYPE_TITLE'] ?? "";
    rEMARKS = json['REMARKS']??"";
    aCTIVE = json['ACTIVE']??"0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TYPE_ID'] = this.tYPEID;
    data['TYPE_TITLE'] = this.tYPETITLE;
    data['REMARKS'] = this.rEMARKS;
    data['ACTIVE'] = this.aCTIVE;
    return data;
  }
}