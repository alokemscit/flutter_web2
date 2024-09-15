import 'dart:convert';

import 'package:web_2/core/config/const.dart';
import 'dart:html' as html;

import 'dart:ui_web' as ui_web;
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:web/web.dart' as web;

@JS('jQuery')
external dynamic get jQuery;

@JS('observeElement')
external void observeElement(dynamic treeId, Function() fun);

@JS('initTree')
external void initTree(dynamic treeId, dynamic node, Function(dynamic id) fun);

@JS('getTreeNode')
external List<String> getTreeNode(String element);

Future<HtmlElementView> jsTreeWidget(String viewID, String divid,
    String tree_id, List<Map<String, dynamic>> nodes,
    [Function(String id)? onCallback]) async {
  ui_web.platformViewRegistry.registerViewFactory(
    viewID,
    (int viewId, {Object? params}) {
      final styleElement = html.StyleElement()
        ..text =
            '.custom-scrollbar{overflow-y:auto}.custom-scrollbar::-webkit-scrollbar{width:8px}.custom-scrollbar::-webkit-scrollbar-thumb{background-color:rgba(0,0,0,0.05);border-radius:6px}.custom-scrollbar::-webkit-scrollbar-thumb:hover{background-color:rgba(0,0,0,0.4)}.custom-scrollbar::-webkit-scrollbar-track{background-color:rgba(0,0,0,0.1)}';
      html.document.head?.append(styleElement);

      final web.HTMLDivElement myDiv = web.HTMLDivElement()
        ..id = divid
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.overflow = 'auto'
        ..className = 'custom-scrollbar';

      final web.HTMLUListElement ul = web.HTMLUListElement()
        ..id = tree_id
        ..className = 'ztree';
      myDiv.append(ul);

      return myDiv;
    },
  );

  return HtmlElementView(
    viewType: viewID,
    onPlatformViewCreated: (viewId) {
      try {
        var jsonString = jsonEncode(
            nodes.map((node) => Map<String, dynamic>.from(node)).toList());
        observeElement(tree_id, allowInterop(() {
          // print(tree_id);

          initTree(jQuery('#$tree_id'), jsonString, allowInterop((dynamic id) {
            if (onCallback != null) {
              onCallback(id.toString());
            }
          }));
        }));
      } catch (e) {
        print('Error initializing zTree: $e');
      }
    },
  );
}


List<int> _extractIdsFromNodes(List<dynamic> nodes) {
  return nodes.map((node) {
    if (node is Map<String, dynamic>) {
      // Extract the 'id' field from the map
      return node['id'] as int;
    } else {
      print('Unexpected node format: $node');
      return null;
    }
  }).where((id) => id != null).cast<int>().toList();
}

List<int> jsGetSelectedNode(String treeID) {
  try {
    // Retrieve the raw data from JavaScript as strings
    List<String> nodeJsonStrings = getTreeNode(treeID);
    
    // Decode JSON strings into Dart objects
    List<dynamic> nodes = nodeJsonStrings
        .map((jsonString) {
          try {
            return jsonDecode(jsonString);
          } catch (e) {
            print('Error decoding JSON string: $e');
            return null;
          }
        })
        .where((node) => node != null)
        .toList();
    
    // Extract IDs from the decoded objects
    List<int> ids = _extractIdsFromNodes(nodes);
    
   // print('Extracted IDs: $ids');
    return ids;
  } catch (e) {
    print('Error getting selected nodes: $e');
    return [];
  }
}


// List<dynamic> jsGetSelectedNode(String treeID) {
//   try {
//     List<String> nodeJsonStrings = getTreeNode(treeID);
//      List<dynamic> nodes = nodeJsonStrings
//         .map((jsonString) {
//           try {
//             return jsonDecode(jsonString);
//           } catch (e) {
//             print('Error decoding JSON string: $e');
//             return null;
//           }
//         })
//         .where((node) => node != null)
//         .toList();
  

//     return nodes;
//   } catch (e) {
//     print('Error getting selected nodes: $e');
//     return [];
//   }
// }
