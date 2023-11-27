import 'package:web_2/data/data_api.dart';

class ModuleMenuList {
  int? id;
  int? pid;
  String? name;
  String? img;
  int? isparent;
  String? desc;
  ModuleMenuList({this.id, this.pid, this.name, this.img, this.isparent});
  ModuleMenuList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    name = json['name'];
    img = json['img'];
    desc = json['des'];
    isparent = json['isparent'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pid'] = pid;
    data['name'] = name;
    data['img'] = img;
    data['des'] = desc;
    data['isparent'] = isparent;
    return data;
  }
}

// ignore: non_constant_identifier_names
Future<List<ModuleMenuList>> get_module_list() async {
  List<ModuleMenuList> a = [];
  data_api2 repo = data_api2();
  try {
    var x = await repo.createLead([
      {"tag": "3"}
    ]);
    //print("calling"+x.toString());
    a = x.map((e) => ModuleMenuList.fromJson(e)).toList();
  } on Exception catch (e) {
   print(e.toString());
  }
  return a;
}
