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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sec_id'] = secId;
    data['charge_id'] = chargeId;
    data['issec'] = issec;
    data['ischarge'] = ischarge;
    return data;
  }
}
