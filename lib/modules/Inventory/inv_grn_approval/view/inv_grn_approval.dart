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
            leftPanelWidth: 320,
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
      CustomDropDown2(
          id: c.cmb_store_typeID.value,
          list: c.list_storeTypeList,
          onTap: (v) {
            c.cmb_store_typeID.value = v!;
            c.setGRN();
          }),
      CustomDropDown2(
          id: c.cmb_yearID.value,
          list: c.list_year,
          onTap: (v) {
            c.cmb_yearID.value = v!;
             c.setGRN();
          }),
      [
        ...c.list_month.map((f) => tree_node(8, f.name ?? '', [
          ...c.list_grn_for_app.where((e)=>e.grnMonth==f.name!).map((f)=>
          InvTree_child(
                        f.grnNo ?? '', c.selectedGRM.value.grnId == f.grnId, () {
                       c.getGrn(f);
                    })
          )
        ])),
      ],
      null,
      c.context.width,
    );
