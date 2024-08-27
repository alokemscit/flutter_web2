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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PARENTID'] = this.pARENTID;
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['ISPARENT'] = this.iSPARENT;
    data['SL'] = this.sL;
    data['CODE'] = this.cODE;
     data['IS_CC'] = this.isCC;
      data['IS_SL'] = this.isSL;
    return data;
  }
}
