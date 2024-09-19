class DoctorLeaveList {
  String? dOCID;
  String? dOCTORNAME;
  String? uNIT;
  String? lEAVESDATE;
  String? lEAVEEDATE;
  int? lEAVESERIAL;
  String? lEAVECAUSE;
  String? eNTRYDATE;
  String? rEFDID;
  String? rEFDNAME;

  DoctorLeaveList(
      {this.dOCID,
      this.dOCTORNAME,
      this.uNIT,
      this.lEAVESDATE,
      this.lEAVEEDATE,
      this.lEAVESERIAL,
      this.lEAVECAUSE,
      this.eNTRYDATE,
      this.rEFDID,
      this.rEFDNAME});

  DoctorLeaveList.fromJson(Map<String, dynamic> json) {
    dOCID = json['DOC_ID'];
    dOCTORNAME = json['DOCTORNAME'];
    uNIT = json['UNIT'];
    lEAVESDATE = json['LEAVE_S_DATE'];
    lEAVEEDATE = json['LEAVE_E_DATE'];
    lEAVESERIAL = json['LEAVE_SERIAL'];
    lEAVECAUSE = json['LEAVE_CAUSE'];
    eNTRYDATE = json['ENTRY_DATE'];
    rEFDID = json['REF_DID'];
    rEFDNAME = json['REF_DNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DOC_ID'] = dOCID;
    data['DOCTORNAME'] = dOCTORNAME;
    data['UNIT'] = uNIT;
    data['LEAVE_S_DATE'] = lEAVESDATE;
    data['LEAVE_E_DATE'] = lEAVEEDATE;
    data['LEAVE_SERIAL'] = lEAVESERIAL;
    data['LEAVE_CAUSE'] = lEAVECAUSE;
    data['ENTRY_DATE'] = eNTRYDATE;
    data['REF_DID'] = rEFDID;
    data['REF_DNAME'] = rEFDNAME;
    return data;
  }
}