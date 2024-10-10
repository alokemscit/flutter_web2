import '../../../../core/config/const.dart';
import '../controller/inv_store_requisition_controller.dart';

class InvSoreRequisition extends StatelessWidget implements MyInterface {
  const InvSoreRequisition({super.key});
  @override
  void disposeController() {
    mdisposeController<InvSoreRequisitionController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvSoreRequisitionController c =
        Get.put(InvSoreRequisitionController());
    c.context = context;
    return Obx(() => CommonBodyWithToolBar(
            c,
            [
              _headerPart(c),
              4.heightBox,
              _itemEntryPanel(c),
            ],
            c.list_tools, (v) {
          c.toolsEvent(v!);
        }));
  }
}

Widget _itemEntryPanel(InvSoreRequisitionController c) => Expanded(
        child: CustomGroupBox(
      child: CustomTableGenerator(colWidtList: const [
        20,
        60,
        50,
        30,
        30,
        20,
        10
      ], childrenHeader: [
        CustomTableColumnHeaderBlack(
          'Code',
        ),
        CustomTableColumnHeaderBlack('item Name'),
        CustomTableColumnHeaderBlack('Generic'),
        CustomTableColumnHeaderBlack('Type', Alignment.center),
        CustomTableColumnHeaderBlack('Unit', Alignment.center),
        CustomTableColumnHeaderBlack('Req. Qty', Alignment.center),
        CustomTableColumnHeaderBlack('*', Alignment.center),
      ], childrenTableRowList: [
        ...c.list_temp.map((f) => TableRow(
              decoration:
                  BoxDecoration(color: f.code != '' ? Colors.white : kBgColorG),
              children: [
                CustomTableCellx(
                  text: f.code!,
                  fontWeight: FontWeight.bold,
                ),
                f.code != ''
                    ? CustomTableCellx(text: f.field!.controller.text)
                    : TableCell(
                        verticalAlignment: TableCellVerticalAlignment.fill,
                        child: f.field!),
                CustomTableCellx(text: f.generic!),
                CustomTableCellx(text: f.type!),
                CustomTableCellx(text: f.unit!),
                f.id == ''
                    ? CustomTableCellx(text: '')
                    : TableCell(
                        child: CustomTextBox(
                        textAlign: TextAlign.center,
                        textInputType: TextInputType.number,
                        controller: f.qty!,
                        focusNode: f.qty_f,
                        width: double.infinity,
                        onSubmitted: (p0) {
                          if (p0.isNotEmpty) {
                            c.addNew();

                            // Ensure the list is updated first
                            c.list_temp.refresh();
                            c.list_temp[c.list_temp.length - 1].field!.focusNode
                                .requestFocus();

                            // Add a post-frame callback to ensure focus happens after UI update
                          }
                        },
                      )),
                CustomTableEditCell(() {
                  c.deleteRow(f);
                }, Icons.delete, 14, Colors.red)
              ],
            ))
      ]),
    ));

Widget _headerPart(InvSoreRequisitionController c) => Row(
      children: [
        Expanded(
          child: CustomGroupBox(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomTextHeader(text: 'Store Type : '),
                    4.widthBox,
                    CustomDropDown2(
                        width: 342,
                        id: c.cmb_store_typeID.value,
                        list: c.list_store_type.toList(),
                        onTap: (v) {
                          c.cmb_store_typeID.value = v!;
                          c.cmb_storeID.value = '';
                          c.setStoreType();
                          c.user_store();
                        }),
                    12.widthBox,
                    const CustomTextHeader(text: 'Store  : '),
                    4.widthBox,
                    CustomDropDown2( width: 302, id: c.cmb_storeID.value, list: c.list_users_store.toList(), onTap: (v){
                       c.cmb_storeID.value = v!;
                    })
                    // MyWidget().DropDown
                    //   ..list = c.list_users_store.toList()
                    //   ..id = c.cmb_storeID.value
                    //   ..width = 302
                    //   ..onTap = (v) {
                    //     c.cmb_storeID.value = v!;
                    //   },
                  ],
                ),
                8.heightBox,
                Row(
                  children: [
                    const CustomTextHeader(text: 'Req/ Date  : '),
                    4.widthBox,
                    MyWidget().DatePicker
                      ..date_controller = c.txt_date
                      ..width = 120
                      ..isShowCurrentDate = true,
                    12.widthBox,
                    const CustomTextHeader(text: 'Priority  : '),
                    4.widthBox,
                    MyWidget().DropDown
                      ..list = c.list_priority.toList()
                      ..id = c.cmb_priorityID.value
                      ..width = 150
                      ..onTap = (v) {
                        c.cmb_priorityID.value = v!;
                      },
                    12.widthBox,
                    MyWidget().TextBox
                      ..controller = c.txt_remarks
                      ..caption = 'Remarks'
                      ..width = 350
                  ],
                )
              ],
            ),
          )),
        )
      ],
    );
