import 'dart:convert';

import 'package:get/get.dart';

import '../data/data_api.dart';

// class MenuData {
//   int? mid;
//   List<Menu>? menu;

//   MenuData({this.mid, this.menu});

//   MenuData.fromJson(Map<String, dynamic> json) {
//     mid = json['mid'];
//     if (json['menu'] != null) {
//       menu = <Menu>[];
//       json['menu'].forEach((v) {
//         menu!.add(Menu.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['mid'] = mid;
//     if (menu != null) {
//       data['menu'] = menu!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Menu {
  int? id;
  String? name;
  List<Smenu>? smenu;

  Menu({this.id, this.name, this.smenu});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
   //print(":::::"+json['smenu']);
    if (json['smenu'] != null) {
       
      smenu = <Smenu>[];
      jsonDecode(json['smenu']).forEach((v) {
        smenu!.add(Smenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    
    if (smenu != null) {
      
      data['smenu'] = smenu!.map((v) => v.toJson()).toList();
    }
    //print(data);
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
Future<List<Menu>> get_menu_data_list(String id) async {
  List<Menu> list = [];
  data_api2 repo = data_api2();
  try {
    var x = await repo.createLead([
      //@name, @pid int,@img
      {"tag": "4", "pid": id}
    ]);
    // print(x);
    list = x.map((e) => Menu.fromJson(e)).toList().where((element) => element.smenu!=null).toList();
  } on Exception {
    return [];
  }

  return list;
  //List<Menu> x = menu_data.map((e) => MenuData.fromJson(e)).toList();
  // return (list.where((o) => o.mid!.toString() == id).first).menu!.toList();
}
