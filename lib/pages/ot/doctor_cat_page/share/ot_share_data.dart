import 'package:web_2/data/data_api.dart';

import '../model/module_for_set_doctor_type.dart';

// ignore: non_constant_identifier_names
Future<List<ModelForSetDoctorType>> get_doctor() async {
  data_api repo = data_api();
  var x = await repo.createLead([
    { "tag": "65",
    "Pcontrol":"getregidFromhrm",
    "Pwhere":"D"}
    ]);
   
    return x.map((e) => ModelForSetDoctorType.fromJson(e)).toList();
}
