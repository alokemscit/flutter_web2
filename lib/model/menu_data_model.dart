import '../data/module_menu_list.dart';

class MenuData {
  int? id;
  String? name;
  List<Smenu>? smenu;
  String? icon;

  MenuData({this.id, this.name, this.smenu, this.icon});

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['smenu'] != null) {
      smenu = <Smenu>[];
      json['smenu'].forEach((v) {
        smenu!.add(Smenu.fromJson(v));
      });
    }
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (smenu != null) {
      data['smenu'] = smenu!.map((v) => v.toJson()).toList();
    }
    data['icon'] = icon;
    return data;
  }
}

class Smenu {
  int? smId;
  String? smName;

  Smenu({this.smId, this.smName});

  Smenu.fromJson(Map<String, dynamic> json) {
    smId = json['sm_id'];
    smName = json['sm_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sm_id'] = smId;
    data['sm_name'] = smName;
    return data;
  }
}

//mList.map((post) => User_Model.fromJson(post)).toList();
// ignore: non_constant_identifier_names
Future<List<MenuData>> get_menu_data_list() async{
 return menu_data.map((e) => MenuData.fromJson(e)).toList();
}
