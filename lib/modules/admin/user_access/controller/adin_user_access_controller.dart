// import 'dart:html' as html;
// import 'dart:ui_web' as ui_web;

// import 'package:web/web.dart' as web;
// import 'package:js/js.dart';
// import 'dart:js' as js;
// import 'package:js/js_util.dart' as js_util;
 
import 'package:web_2/core/config/const.dart';

import '../../../../core/config/function_js_tree.dart';
import '../../../hrm/employee_master/model/model_employee_master_main.dart';
import '../model/admin_model_tree_menu_all.dart';
 
class AdminUserAccessController extends GetxController with MixInController {
  final TextEditingController txt_search = TextEditingController();
  var list_emp_master = <ModelEmployeeMasterMain>[].obs;
  var list_emp_temp = <ModelEmployeeMasterMain>[].obs;
  var selectedEmployee = ModelEmployeeMasterMain().obs;

  var list_tree_menu = <ModelTreeMenuAll>[].obs;

 
  var htmlView = HtmlElementView(
    viewType: 'my-view',
  ).obs;

  @override
  void onInit() async {
    isLoading.value = true;

    // registerRedDivFactory();

    api = data_api2();

    user.value = await getUserInfo();
    if (!await (isValidLoginUser(this))) return;
    font = await CustomLoadFont(appFontPathLato);
    try {
      var x = await api.createLead([
        {"tag": "36", "cid": user.value.cid}
      ]);
      // print(x);
      if (checkJson(x)) {
        list_emp_master
            .addAll(x.map((e) => ModelEmployeeMasterMain.fromJson(e)));
        list_emp_temp.addAll(list_emp_master);
      }

      x = await api.createLead([
        {"tag": "72"}
      ]);
      if (checkJson(x)) {
        list_tree_menu.addAll(x.map((e) => ModelTreeMenuAll.fromJson(e)));
        //initHtml();
        List<Map<String, dynamic>> node = [];
        list_tree_menu.forEach((e) {
          node.add({
            "id": e.id,
            "pId": e.pId,
            "name": e.name,
            "isParent": e.isParent,
            "open": false
          });
        });

        htmlView.value = await jsTreeWidget(
            'userassess_view', 'user_access_div', 'user_access_tree', node,
            (v) {
          print(v);
        },true);
      }

      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }

  void setEmployee(ModelEmployeeMasterMain f) {
    selectedEmployee.value = f;
  }

  void search() {
    selectedEmployee.value = ModelEmployeeMasterMain();
    list_emp_temp
      ..clear()
      ..addAll(list_emp_master.where((e) =>
          e.eno!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.depName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          e.desigName!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void testing() {
    
    List<int> ckNodes = jsGetSelectedNode('user_access_tree');
     
    for (var i = 0; i < ckNodes.length; i++) {
      // print(ckNodes[i]??0);
      if (ckNodes[i]!=null) {
        print(ckNodes[i]);
      }
    }
  }
}
