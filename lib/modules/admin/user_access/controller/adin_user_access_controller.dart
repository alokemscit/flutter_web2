import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:web/web.dart' as web;
import 'package:js/js.dart';
import 'dart:js' as js;
import 'package:js/js_util.dart' as js_util;
import 'package:pdf/widgets.dart';
import 'package:web_2/core/config/const.dart';

import '../../../hrm/employee_master_page/model/model_employee_master_main.dart';
import '../model/admin_model_tree_menu_all.dart';

@JS('jQuery')
external dynamic get jQuery;
@JS('jQuery.fn.zTree.init')
external dynamic zTreeInit(dynamic element, dynamic settings, dynamic nodes);
@JS('jQuery.fn.zTree.getZTreeObj')
external dynamic getZTreeObj(dynamic element);

class AdminUserAccessController extends GetxController with MixInController {
  final TextEditingController txt_search = TextEditingController();
  var list_emp_master = <ModelEmployeeMasterMain>[].obs;
  var list_emp_temp = <ModelEmployeeMasterMain>[].obs;
  var selectedEmployee = ModelEmployeeMasterMain().obs;

  var list_tree_menu = <ModelTreeMenuAll>[].obs;

  late Font? font;
  var htmlView = HtmlElementView(
    viewType: 'my-view',
  ).obs;
  late dynamic zTree ;

  @override
  void onInit() async {
    isLoading.value = true;

    registerRedDivFactory();

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
        initHtml();
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

  void initHtml() {
    htmlView.value = HtmlElementView(
      viewType: 'my-view',
      onPlatformViewCreated: (viewId) async {
        final div =
            ui_web.platformViewRegistry.getViewById(viewId) as html.DivElement;

        final web.HTMLUListElement ul = web.HTMLUListElement()
          ..id = '_tree_form_'
          ..className = 'ztree';
        div.append(ul as html.Node);

        final settings = js_util.jsify({
          "view": {"selectedMulti": false},
          "check": {"enable": true},
          "data": {
            "simpleData": {"enable": true}
          },
          "callback": {
            "onCheck": ((jsThis, treeNode) {
              // print('Node checked: ${js_util.getProperty(treeNode, 'name')}');
            })
          }
        });

        List<Map<String, Object>> nodes = [];
        list_tree_menu.forEach((f) {
          nodes.add({
            "id": f.id!,
            "pId": f.pId!,
            "name": f.name!,
            "open": false,
           // "checked": true
          });
        });

        // Define zTree nodes
        // final nodes = [
        //   {"id": 1, "pId": 0, "name": "Parent Node 1", "open": false},
        //   {"id": 11, "pId": 1, "name": "Child Node 1-1", "open": false},
        //   {"id": 12, "pId": 1, "name": "Child Node 1-2", "open": false},
        //   {"id": 2, "pId": 0, "name": "Parent Node 1", "open": false},
        //   {"id": 21, "pId": 2, "name": "Child Node 1-1", "open": false},
        //   {"id": 22, "pId": 2, "name": "Child Node 1-2", "open": false}
        // ];
        final jsNodes = nodes.map((node) => js_util.jsify(node)).toList();

        zTreeInit(jQuery(div).find(ul), settings, jsNodes);
        

        //div1.value = div;

        //void abc() {
        
        // }
      },
    );
  }

  void testing(){
     var zTree = getZTreeObj('_tree_form_');
          var ckNodes = zTree.getCheckedNodes();
        for (var i = 0; i < ckNodes.length; i++) {
          print(ckNodes[i].id);
        }
  }
}

void registerRedDivFactory() {
  ui_web.platformViewRegistry.registerViewFactory(
    'my-view',
    (int viewId, {Object? params}) {
      final web.HTMLDivElement myDiv = web.HTMLDivElement()
        ..id = 'div_id'
        // ..style.backgroundColor = 'red'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.overflow = 'auto';
      return myDiv;
    },
  );
}
