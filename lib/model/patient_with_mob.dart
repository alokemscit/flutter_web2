// ignore: camel_case_types
class patient_with_mob {
  String? hCN;
  String? pATNAME;
  String? dOB;
  String? sEX;
  String? eMAIL;
  String? cELLPHONE;
  String? hOMEPHONE;
  String? tHANACODE;
  String? dISTRICTCODE;
  String? cOUNTRY;
  patient_with_mob({
    this.hCN,
    this.pATNAME,
    this.dOB,
    this.sEX,
    this.eMAIL,
    this.cELLPHONE,
    this.hOMEPHONE,
    this.tHANACODE,
    this.dISTRICTCODE,
    this.cOUNTRY,
  });

  patient_with_mob.fromJson(Map<String, dynamic> json) {
    hCN = json['HCN'];
    pATNAME = json['PAT_NAME'];
    dOB = json['DOB'];
    sEX = json['SEX'];
    eMAIL = json['EMAIL'];
    cELLPHONE = json['CELL_PHONE'];
    hOMEPHONE = json['HOME_PHONE'];
    tHANACODE = json['THANA_CODE'];
    dISTRICTCODE = json['DISTRICT_CODE'];
    cOUNTRY = json['COUNTRY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HCN'] = hCN;
    data['PAT_NAME'] = pATNAME;
    data['DOB'] = dOB;
    data['SEX'] = sEX;
    data['EMAIL'] = eMAIL;
    data['CELL_PHONE'] = cELLPHONE;
    data['HOME_PHONE'] = hOMEPHONE;
    data['THANA_CODE'] = tHANACODE;
    data['DISTRICT_CODE'] = dISTRICTCODE;
    data['COUNTRY'] = cOUNTRY;
    return data;
  }
}
