import 'package:web_2/data/data_api.dart';

import '../model/model_for_set_doctor_type.dart';
import '../model/model_ot_type.dart';

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

Future<List<ModelOtType>> get_ot_type() async {
  data_api repo = data_api();
  var x = await repo.createLead([
    { "tag": "66" }
    ]);
   
    return x.map((e) => ModelOtType.fromJson(e)).toList();
}