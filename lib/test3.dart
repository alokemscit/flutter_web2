import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

@JS('jQuery')
external dynamic get jQuery;
@JS('jQuery.fn.zTree.init')
external dynamic zTreeInit(dynamic element, dynamic settings, dynamic nodes);

class Test3 extends StatelessWidget {
  const Test3({super.key});

  void registerRedDivFactory() {
    ui_web.platformViewRegistry.registerViewFactory(
      'my-view-type',
      (int viewId, {Object? params}) {
        final web.HTMLDivElement myDiv = web.HTMLDivElement()
          ..id = 'some_id_'
          // ..style.backgroundColor = 'red'
          ..style.width = '100%'
          ..style.height = '100%';
        return myDiv;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    registerRedDivFactory();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 400,
            height: 500,
            child: HtmlElementView(
              viewType: 'my-view-type',
              onPlatformViewCreated: (viewId) async {
                final div = ui_web.platformViewRegistry.getViewById(viewId)
                    as html.DivElement;
                div.innerHtml = '</br>';
                
               

                final web.HTMLUListElement ul = web.HTMLUListElement()
                  ..id = '_tree_form_'
                  ..className = 'ztree';
                div.append(ul as html.Node);
 
              final settings = js_util.jsify({
    "view": {"selectedMulti": false},
    "check": {"enable": true},
    "data": {
      "simpleData": {
        "enable": true,
        "idKey": "id",
        "pIdKey": "pId",
        "rootPId": 0
      }
    },
  });

                // Define zTree nodes
                 final nodes = [
    {"id": 1, "pId": 0, "name": "Parent Node 1", "open": false},
    {"id": 11, "pId": 1, "name": "Child Node 1-1", "open": false},
    {"id": 12, "pId": 1, "name": "Child Node 1-2", "open": false},
    {"id": 2, "pId": 0, "name": "Parent Node 1", "open": false},
    {"id": 21, "pId": 2, "name": "Child Node 1-1", "open": false},
    {"id": 22, "pId": 2, "name": "Child Node 1-2", "open": false}
  ];
  final jsNodes = nodes.map((node) => js_util.jsify(node)).toList();

                 
                zTreeInit(jQuery(div).find(ul), settings, jsNodes);

              
              },
            ),
          ),
        ],
      ),
    );
  }
}
