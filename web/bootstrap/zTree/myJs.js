
$(document).ready(function(){
 

    window.initTree = function(tree_id, node, fun) {
    var settings = {
      view: {
        showLine: true,
        selectedMulti: false,
        dblClickExpand: false
    },
    check: {
            enable: true
        },
    data: {
        simpleData: {
            enable: true
        }
    },
      callback: {
        beforeClick: function (treeId, treeNode) {
          if (treeNode.isParent) return false;
          else {
            fun(treeNode.id); // Call the Dart function passed from allowInterop
          }
          return true;
        }
      }
    };
   // console.log( node);
   var k = JSON.parse(node);
    $.fn.zTree.init(tree_id, settings, k);
  }

  window.getTreeNode = function(tree_id) {
    if ($('#' + tree_id)!=null) {
    var zTree = $.fn.zTree.getZTreeObj(tree_id);
    if (!zTree) {
      console.error('zTree not found for tree_id:', tree_id);
      return [];
    }
    var ckNodes = zTree.getCheckedNodes();
   // console.log('zTree  found ', ckNodes);
    return   ckNodes.map(node => JSON.stringify({
        id: node.id,
        name: node.name,
        // Add other properties if needed
      }));
    //return ckNodes;
}else{
    console.error('zTree dom not found for tree_id:', tree_id);
}
  }
   

  window.observeElement = function(elementId, callback) {
    var observer = new MutationObserver(function(mutations) {
      mutations.forEach(function(mutation) {
        if (document.querySelector('#' + elementId)) {
          callback();  // Call the callback when the element is found
          observer.disconnect();  // Stop observing once the element is ready
        }
      });
    });
  
    observer.observe(document.body, {
      childList: true,
      subtree: true
    });
  };

  });

