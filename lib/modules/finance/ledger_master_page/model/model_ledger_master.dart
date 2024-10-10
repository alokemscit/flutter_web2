class ModelLedgerMaster {
  String? pARENTID;
  String? iD;
  String? nAME;
  String? iSPARENT;
  String? sL;
  String? cODE;
  String? isCC;
   String? isSL;

  ModelLedgerMaster(
      {this.pARENTID, this.iD, this.nAME, this.iSPARENT, this.sL, this.cODE,this.isCC,this.isSL});

  ModelLedgerMaster.fromJson(Map<String, dynamic> json) {
    pARENTID = json['PARENTID'].toString();
    iD = json['ID'].toString();
    nAME = json['NAME'].toString();
    iSPARENT = json['ISPARENT'].toString();
    sL = json['SL'].toString();
    cODE = json['CODE'].toString();
    isCC = json['IS_CC'].toString();
    isSL = json['IS_SL'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PARENTID'] = pARENTID;
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['ISPARENT'] = iSPARENT;
    data['SL'] = sL;
    data['CODE'] = cODE;
     data['IS_CC'] = isCC;
      data['IS_SL'] = isSL;
    return data;
  }
}
