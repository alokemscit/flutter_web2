// ignore_for_file: non_constant_identifier_names

import '../../../../core/config/const.dart';
import '../controller/sub_ledger_controller.dart';

class SubLedgerMaster extends StatelessWidget {
  const SubLedgerMaster({super.key});
  void disposeController() {
    try {
      Get.delete<SubLedgerController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SubLedgerController controller = Get.put(SubLedgerController());
    controller.context = context;
    // print(controller.context.height);
    return Obx(() => CommonBodyWithToolBar(
            controller,
            [
             Expanded(child: CustomGroupBox(child: Column(children: [
               _entryPart(controller),
              _tablePartList(controller),
             ],)))
            ],
            controller.list_tool, (v) {
          controller.toolbarEvent(v);
        }));
  }
}

_tablePartList(SubLedgerController controller) => Expanded(
      child: CustomGroupBox(
          //bgColor: Colors.white,
          borderWidth: 1,
          groupHeaderText: 'Sub Leadger List',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: CustomSearchBox(
                            borderRadious: 4,
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
                12.heightBox,
                 _tablePart(controller),
                
              ],
            ),
          )),
    );

_tablePart(SubLedgerController controller) => Expanded(
      child:  
       CustomTableGenerator(colWidtList: const [50, 120, 140, 80, 30], childrenHeader: [
      CustomTableColumnHeaderBlack('Code'),
      CustomTableColumnHeaderBlack('Sub Ledger name'),
      CustomTableColumnHeaderBlack('Description'),
      CustomTableColumnHeaderBlack('Is Bill by Bill', Alignment.center),
      CustomTableColumnHeaderBlack('*', Alignment.center),
      ], childrenTableRowList: [
       ...controller.list_subledger_temp.map((f)=>TableRow(
        decoration: BoxDecoration(color: controller.editId==f.id!.toString()?Colors.amberAccent.withOpacity(0.3):Colors.white),
        children:[
             CustomTableCellx(text: f.code??''),
             CustomTableCellx(text: f.name??''),
             CustomTableCellx(text: f.description??''),
             CustomTableCellx(text: (f.isBillByBill??0)==0?'No':'Yes', alignment: Alignment.center,),
             CustomTableEditCell(() {
                           controller.edit(f);
                   })
       ] ))
      ]),



    );

_entryPart(SubLedgerController controller) => Row(
  children: [
    Flexible(
      child: SizedBox(
        width: 500,
        child: CustomGroupBox(
            groupHeaderText: 'Entry',
            child: Padding(
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
                      8.widthBox,
                      Expanded(
                          child: CustomTextBox(
                              caption: "Sub Ledger Name",
                              maxlength: 150,
                              controller: controller.txt_name,
                              onChange: (v) {})),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.isBillByBill.value,
                              onChanged: (v) {
                                controller.isBillByBill.value = v!;
                              }),
                          4.widthBox,
                          Text(
                            "Is Bill By Bill",
                            style: customTextStyle.copyWith(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  12.heightBox,
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
                ],
              ),
            )),
      ),
    ),
  ],
);
