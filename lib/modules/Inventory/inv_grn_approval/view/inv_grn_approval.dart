
 
import 'package:web_2/core/config/const.dart';

import '../../shared/inv_shared_widget.dart';
import '../controller/inv_grn_approval_controller.dart';

class InvGrnApproval extends StatelessWidget implements MyInterface {
  const InvGrnApproval({super.key});
  @override
  void disposeController() {
    mdisposeController<InvGrnApprovalController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvGrnApprovalController c = Get.put(InvGrnApprovalController());
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

Widget _rightPanel(InvGrnApprovalController c) => Column(
      children: [],
    );

Widget _leftpanel(InvGrnApprovalController c) => InvleftPanelWithTree(
    CustomDropDown2(id: null, list: [], onTap: (v) {}),
    CustomDropDown2(id: null, list: [], onTap: (v) {}),
    [],
    null);
