 
import '../../../core/config/const.dart';
import 'controller/cost_center_controller.dart';

class ConstcenterPage extends StatelessWidget {
  const ConstcenterPage({super.key});
  void disposeController() {
    try {
      Get.delete<CostcenterController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CostcenterController controller = Get.put(CostcenterController());
    controller.context = context;
   // print(controller.context.height);
    return Obx(() => CommonBody2(controller, _desktop(controller)));
  }
}

_desktop(CostcenterController controller) => CustomAccordionContainer(
        headerName: "Cost Center Master",
        height: 0,
        isExpansion: false,
        bgColor: appGray100,
        children: [
          Expanded(
            child: Column(children: [
              _entryPart(controller),
             _tablePartList(controller),
            ]),
          )

          // _entryPart(controller),
          //_tablePartList(controller),
        ]);

_tablePartList(CostcenterController controller) => Expanded(
  child: CustomGroupBox(
    
    groupHeaderText: 'Cost Cenet List',
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: CustomSearchBox(
                    caption: "Search",
                    controller: controller.txt_search,
                    onChange: (v) {
                      controller.search();
                    })),
                  controller.context.width > 1200
                ? const Expanded(flex: 5, child: SizedBox())
                : const SizedBox(),
          ],
        ),
      ),
      _tablePart(controller),
    ],),
  ),
);

_tablePart(CostcenterController controller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              columnWidths: CustomColumnWidthGenarator([50, 120, 140,  40]),
              children: [
          TableRow(
            decoration: CustomTableHeaderRowDecorationnew,
            children: [
                CustomTableClumnHeader('Code'),
                CustomTableClumnHeader('Cost Center Name'),
                 CustomTableClumnHeader('Description'),
                  
                   CustomTableClumnHeader('*',Alignment.center),
             ]
      
            ),
                
      
              ],
              border: CustomTableBorder(),
            ),
            Expanded(
          child: SingleChildScrollView(
            child: Table(
              columnWidths: CustomColumnWidthGenarator([50, 120, 140,  40]),
              children: controller.list_costcenter_temp.map((element)=>TableRow(
                decoration: BoxDecoration(
                   color: controller.editId.value ==
                                    element.iD
                                ? appColorPista
                                : Colors.white
                ),
                children: [
                   CustomTableCell2(
                              element.cODE!),
                               CustomTableCell2(
                              element.nAME),
                               CustomTableCell2(
                              element.dESCRIPTION),
                               CustomTableEditCell((){})
                ]

              )).toList(),
            )))
      
          ],
        ),
      ),
    );

_entryPart(CostcenterController controller) {
  bool b = false;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
            flex: 5,
            child:  CustomGroupBox(
                 groupHeaderText: 'Enrty',
              child: Column(
                   
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomTextBox(
                                  caption: "Code",
                                  isReadonly: true,
                                  isDisable: true,
                                  disableBackColor: appColorGrayLight,
                                  maxlength: 10,
                                  width: 100,
                                  controller: controller.txt_code,
                                  onChange: (C) {}),
                              10.widthBox,
                              Expanded(
                                  child: CustomTextBox(
                                      caption: "Cost Center Name",
                                      maxlength: 150,
                                      controller: controller.txt_name,
                                      onChange: (v) {})),
                              
                            ],
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextBox(
                                      caption: "Description",
                                      maxlength: 150,
                                      controller: controller.txt_desc,
                                      onChange: (v) {})),
                            ],
                          ),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(Icons.undo, "Undo", () {
                                controller.undo();
                              }, Colors.white, Colors.white, appColorGrayDark),
                              18.widthBox,
                              CustomButton(Icons.save, "Save", () async {
                                if (!b) {
                                  b = true;
                                  controller.save();
                                  Future.delayed(const Duration(seconds: 2), () {
                                    b = false;
                                  });
                                }
                              })
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            )),
              controller.context.width > 1200
            ? const Expanded(flex: 5, child: SizedBox())
            : const SizedBox(),
      ],
    ),
  );
}
