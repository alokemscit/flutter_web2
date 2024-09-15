// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/config/const.dart';
import '../controller/inv_po_create_controller.dart';

class InvPOCreate extends StatelessWidget {
  const InvPOCreate({super.key});
  void disposeController() {
    try {
      Get.delete<InvPoCreateController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvPoCreateController controller = Get.put(InvPoCreateController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          Expanded(
              child: CustomTwoPanelGroupBox(
                  leftPanelWidth: 350,
                  leftChild: _leftPanel(controller),
                  rightChild: Column(),
                  minWidth: 1050))
        ],
        'Create Purchase Order::'));
  }
}

Widget _leftPanel(InvPoCreateController controller) => Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomGroupBox(
                padingvertical: 0,
                  groupHeaderText: '',
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Store Type',
                              id: null,
                              list: [],
                              onTap: (v) {})),
                      12.widthBox,
                      CustomDropDown2(
                        labeltext: 'Year',
                          id: null, width: 120, list: [], onTap: (v) {})
                    ],
                  )),
            )
          ],
        ),8.heightBox,
        Expanded(child: ListView(children: [
          for(var i=0;i<100;i++)
          Text('data')
        ],))
      ],
    );
