class ModelForSetDoctorType {
  String? eMPID;
  String? eMPNAME;

  ModelForSetDoctorType({this.eMPID, this.eMPNAME});

  ModelForSetDoctorType.fromJson(Map<String, dynamic> json) {
    eMPID = json['EMP_ID'];
    eMPNAME = json['EMPNAME']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EMP_ID'] = eMPID;
    data['EMPNAME'] = eMPNAME;
    return data;
  }
}