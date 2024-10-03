
import 'package:web_2/core/config/const.dart';

import '../../shared/inv_shared_widget.dart';
import '../controller/inv_item_issue_to_store_controller.dart';

class InvStoreItemIssue extends StatelessWidget implements MyInterface {
  const InvStoreItemIssue({super.key});
  @override
  void disposeController() {
    mdisposeController<InvStoreItemIssueController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvStoreItemIssueController c = Get.put(InvStoreItemIssueController());
    c.context = context;
    return Obx(() => CommonBodyWithToolBar(
        c,
        [
          Expanded(
              child: CustomTwoPanelGroupBox(
            leftChild: _leftpanel(c),
            rightChild: _rightPanel(c),
          )),
        ],
        c.list_tool,
        (v) {}));
  }
}

Widget _rightPanel(InvStoreItemIssueController c) => Column(
      children: [],
    );

Widget _leftpanel(InvStoreItemIssueController c) => InvleftPanelWithTree(
    CustomDropDown2(id: null, list: [], onTap: (v) {}),
    CustomDropDown2(id: null, list: [], onTap: (v) {}),
    [],
    null);
