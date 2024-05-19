class ModelHmsChargesConfig {
  String? secId;
  String? chargeId;
  String? issec;
  String? ischarge;

  ModelHmsChargesConfig({this.secId, this.chargeId, this.issec, this.ischarge});

  ModelHmsChargesConfig.fromJson(Map<String, dynamic> json) {
    secId = json['sec_id'].toString();
    chargeId = json['charge_id'].toString();
    issec = json['issec'].toString();
    ischarge = json['ischarge'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sec_id'] = this.secId;
    data['charge_id'] = this.chargeId;
    data['issec'] = this.issec;
    data['ischarge'] = this.ischarge;
    return data;
  }
}
