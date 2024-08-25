 

import '../../../../core/config/const.dart';
import '../controller/inv_item_master_controller.dart';

class InvItemMaster extends StatelessWidget {
  const InvItemMaster({super.key});
  void disposeController() {
    try {
      Get.delete<InvItemMasterController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvItemMasterController controller =
        Get.put(InvItemMasterController());
    controller.context = context;
    return Obx(() =>
        CommonBody3(controller, [Expanded(child: _mainWindow(controller))], 'Item Master::',));
  }
}

Widget _mainWindow(InvItemMasterController controller) =>
    controller.context.width > 1300
        ? Row(
            children: [
              _header(controller),8.widthBox, _tableView(controller),
            ],
          )
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(controller),
              8.heightBox,
              _tableView(controller)
            ],
          );

Widget _tableView(InvItemMasterController controller) => Expanded(
  child: CustomGroupBox(
   // bgColor: Colors.white,
    padingvertical: 0,
      groupHeaderText: 'List of Company',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Flexible(child: CustomSearchBox(caption: 'Company Search', width: 450, controller: controller.txt_search, onChange: (v){}))],)
        
        ,8.heightBox,
        Expanded(
          child: CustomTableGenerator(colWidtList: const[40,120,50,80,80,80,80,20], childrenHeader: [
            CustomTableClumnHeader("Code"),
            CustomTableClumnHeader("Item Name"),
            CustomTableClumnHeader("Unit"),
            CustomTableClumnHeader("Group"),
            CustomTableClumnHeader("Subgroup"),
            CustomTableClumnHeader("Generic"),
            CustomTableClumnHeader("Store Type"),
            CustomTableClumnHeader("*",Alignment.center),
          ], childrenTableRowList: []),
        )

        ],
        

      )),
);

Widget _header(InvItemMasterController controller) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(
          width: 450,
          child: CustomGroupBox(
           // bgColor: Colors.white,
              padingvertical: 4,
              groupHeaderText: 'Item Master',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomDropDown(
                            labeltext: 'Store Type',
                            id: null,
                            width: 250,
                            list: [],
                            onTap: (v) {})
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown(
                                labeltext: 'Company',
                                id: null,
                                width: 400,
                                list: [],
                                onTap: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown(
                                labeltext: 'Group',
                                id: null,
                                width: 400,
                                list: [],
                                onTap: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown(
                                labeltext: 'Sub Group',
                                id: null,
                                width: 400,
                                list: [],
                                onTap: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        CustomTextBox(caption: 'Code', width: 80, controller: controller.txt_code, onChange: (v){}),
                        8.widthBox,
                        Flexible(
                            child: CustomTextBox(
                                caption: 'Item Name',
                                width: 312,
                                controller: controller.txt_name,
                                onChange: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown(
                                labeltext: 'Generic Name',
                                id: null,
                                width: 400,
                                list: [],
                                onTap: (v) {}))
                      ],
                    ),
                   8.heightBox,
                    Row(
                      children: [
                        Flexible(
                            child: CustomDropDown(
                                labeltext: 'Unit',
                                id: null,
                                width: 250,
                                list: [],
                                onTap: (v) {}))
                      ],
                    ),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomSaveUpdateButtonWithUndo(
                            controller.editItemID.value != '', () {}, () {}),
                      ],
                    )
                  ],
                ),
              )),
        ),
  ],
);
