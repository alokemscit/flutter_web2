class DoctorList {
  String? dOCID;
  String? dOCTORNAME;
  String? uNIT;

  DoctorList({this.dOCID, this.dOCTORNAME, this.uNIT});

  DoctorList.fromJson(Map<String, dynamic> json) {
    dOCID = json['DOC_ID'];
    dOCTORNAME = json['DOCTORNAME'];
    uNIT = json['UNIT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DOC_ID'] = dOCID;
    data['DOCTORNAME'] = dOCTORNAME;
    data['UNIT'] = uNIT;
    return data;
  }
  
}