// ignore: non_constant_identifier_names
List<dynamic> img_data = [
  {"category": "appointment"},
  {"category": "appointment2"},
  {"category": "appointment3"},
  {"category": "bedmanagement"},
  {"category": "billing"},
  {"category": "billing2"},
  {"category": "consultation"},
  {"category": "diet"},
  {"category": "emr"},
  {"category": "feedback"},
  {"category": "housekeeping"},
  {"category": "hrm"},
  {"category": "inventory"},
  {"category": "inventory2"},
  {"category": "laboratory"},
  {"category": "medicalequipment"},
  {"category": "nursing"},
  {"category": "ot"},
  {"category": "pharmacy"},
  {"category": "prescription"},
  {"category": "prescription2"},
  {"category": "prescription3"},
  {"category": "radiology"},
  {"category": "registration"},
  {"category": "registration2"},
  {"category": "settings"}
];

class ModuleImageDate {
  String? category;
  ModuleImageDate({required this.category});

  ModuleImageDate.fromJson(Map<String, dynamic> json) {
    category = json["category"];
  }
}

Future<List<ModuleImageDate>> moduleImageList() async {
  return img_data.map((post) => ModuleImageDate.fromJson(post)).toList();
}
