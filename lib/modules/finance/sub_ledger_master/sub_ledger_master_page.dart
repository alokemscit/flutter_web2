// ignore_for_file: non_constant_identifier_names

 
 

 

import '../../../core/config/const.dart';
import 'controller/sub_ledger_controller.dart';
 

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
    return Obx(() => CommonBody2(
        controller ,
        _desktop(controller),
       
        //_desktop(controller),
        //_desktop(controller)
        ));
  }
}

_desktop(SubLedgerController controller) => CustomAccordionContainer(
     bgColor:appGray100, //Colors.grey[100]!,
        headerName: "Sub Legder Master",
        height: 0,
        isExpansion: false,
        children: [
          Expanded(
            child: Column(children: [
              _entryPart(controller),
              _tablePartList(controller),
            ]),
          )

          
        ]);

_tablePartList(SubLedgerController controller) => Expanded(
  child: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomGroupBox(
          //bgColor: Colors.white,
          borderWidth: 1,
        groupHeaderText: 'Sub Leadger List',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
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
              Obx(()=>  _tablePart(controller),), 
            ],),
          )
           
       
        ),
      ),
);

_tablePart(SubLedgerController controller) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            

 

            Table(
             border: CustomTableBorderNew,
            columnWidths: CustomColumnWidthGenarator([50, 120, 140, 80, 30]),
            children: [
             TableRow(
              decoration: CustomTableHeaderRowDecorationnew,
              children: [
                  CustomTableClumnHeader('Code'),
                  CustomTableClumnHeader('Sub Ledger Name'),
                   CustomTableClumnHeader('Description'),
                    CustomTableClumnHeader('Is Bill by Bill',Alignment.center),
                     CustomTableClumnHeader('*',Alignment.center),
               ]

              )
              
              ]
            ),
            
            
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                columnWidths: CustomColumnWidthGenarator([50, 120, 140, 80, 30]),
                children:  controller.list_subledger_temp.map(( element)=>TableRow(
                        decoration: BoxDecoration(
                            color: controller.editId ==
                                    element.iD
                                ? appColorPista
                                : Colors.white),
                        children: [
                          CustomTableCell2(
                              element.cODE!),
                          CustomTableCell2(
                              element.nAME!),
                          CustomTableCell2(element.dESCRIPTION ==
                                  null
                              ? ''
                              : element.dESCRIPTION!),
                          CustomTableCell2(
                              element.iSBILLBYBILL! ==
                                      '1'
                                  ? "Yes"
                                  : "No"),
                          CustomTableEditCell(() {
                            controller.edit(element);
                          })
                        ])).toList(),
                border: CustomTableBorder(),
              ),
            ),
          )
        ],
      ),
    );

_entryPart(SubLedgerController controller) {
  bool b = false;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
            flex: 5,
            child: CustomGroupBox(
             //  bgColor: Colors.white,
                // "Sub Ledger",
                groupHeaderText: 'Entry',
                child: 
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
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
                )),
            controller.context.width > 1200
            ? const Expanded(flex: 5, child: SizedBox())
            : const SizedBox(),
      ],
    ),
  );
}
