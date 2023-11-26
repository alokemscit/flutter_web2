import 'package:web_2/data/data_api.dart';

class ModelMenuList {
  int? id;
  int? pid;
  String? name;
  String? img;
  int? isparent;
  String? desc;
  ModelMenuList({this.id, this.pid, this.name, this.img, this.isparent});
  ModelMenuList.fromJson(Map<String, dynamic> json) {
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
Future<List<ModelMenuList>> get_module_list() async {
  List<ModelMenuList> a = [];
  data_api2 repo = data_api2();
  try {
    var x = await repo.createLead([
      {"tag": "3"}
    ]);
    //print("calling"+a.length.toString());
    a = x.map((e) => ModelMenuList.fromJson(e)).toList();
  } on Exception catch (e) {
   print(e.toString());
  }
  return a;
}
