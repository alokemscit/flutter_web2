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
    c.showDialogMethod = () => _showDialog(c);

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

void _showDialog(InvSoreRequisitionController c) => CustomDialog2(
    c.context,
    "Caption",
    Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 800,
            height: 600,
            child: Column(
              children: [
                CustomGroupBox(
                  child: Obx(() => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CustomDropDown2(
                              labeltext: 'Store Type',
                              id: c.cmb_store_dialog_typeID.value,
                              list: c.list_store_type,
                              onTap: (v) {
                                c.cmb_store_dialog_typeID.value = v!;
                                c.user_store_dialog();
                              },
                              width: 150,
                            ),
                            8.widthBox,
                            CustomDropDown2(
                              labeltext: 'Store Name',
                              id: c.cmb_dialog_storeID.value,
                              list: c.list_users_store_dialog.toList(),
                              onTap: (v) {
                                c.cmb_dialog_storeID.value = v!;
                              },
                              width: 160,
                            ),
                            8.widthBox,
                            Row(
                              children: [
                                CustomDatePickerDropDown(
                                  date_controller: c.txt_fdate,
                                  isBackDate: true,
                                  isFutureDateDisplay: true,
                                  isShowCurrentDate: true,
                                ),
                                8.widthBox,
                                CustomDatePickerDropDown(
                                  date_controller: c.txt_tdate,
                                  isBackDate: true,
                                  isFutureDateDisplay: true,
                                  isShowCurrentDate: true,
                                ),
                                8.widthBox,
                                CustomButtonIconText(
                                  text: 'Show',
                                  icon: Icons.search,
                                  onTap: () {
                                    c.view_req_master();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ),
                Expanded(
                    child: Obx(() => CustomTableGenerator(
                            colWidtList: const [
                              20,
                              30,
                              40,
                              50,
                              30,
                              15
                            ],
                            childrenHeader: [
                              CustomTableColumnHeaderBlack('Req, No'),
                              CustomTableColumnHeaderBlack('Req, Date'),
                              CustomTableColumnHeaderBlack('Store Type'),
                              CustomTableColumnHeaderBlack('Store Name'),
                              CustomTableColumnHeaderBlack('Status'),
                              CustomTableColumnHeaderBlack(
                                  '*', Alignment.center),
                            ],
                            childrenTableRowList: c.list_req_master
                                .map((f) => TableRow(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        children: [
                                          CustomTableCellx(text: f.reqNo ?? ''),
                                          CustomTableCellx(
                                              text: f.reqDate ?? ''),
                                          CustomTableCellx(
                                              text: f.storeTypeName ?? ''),
                                          CustomTableCellx(
                                              text: f.storeName ?? ''),
                                          CustomTableCellx(
                                              text: f.currentStatus ?? ''),
                                          CustomTableEditCell(() {
                                            c.reportView(f.reqId.toString());
                                          }, Icons.print_rounded, 16,
                                              appBlueMidLight)
                                        ]))
                                .toList())))
              ],
            ),
          ),
        )
      ],
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
                    CustomDropDown2(
                        width: 302,
                        id: c.cmb_storeID.value,
                        list: c.list_users_store.toList(),
                        onTap: (v) {
                          c.cmb_storeID.value = v!;
                        })
                  ],
                ),
                8.heightBox,
                Row(
                  children: [
                    const CustomTextHeader(text: 'Req/ Date  : '),
                    4.widthBox,
                    CustomDatePickerDropDown(
                      date_controller: c.txt_date,
                      width: 120,
                      isFutureDateDisplay: true,
                      isShowCurrentDate: true,
                    ),
                    12.widthBox,
                    const CustomTextHeader(text: 'Priority  : '),
                    4.widthBox,
                    CustomDropDown2(
                        id: c.cmb_priorityID.value,
                        list: c.list_priority.toList(),
                        width: 150,
                        onTap: (v) {
                          c.cmb_priorityID.value = v!;
                        }),
                    12.widthBox,
                    CustomTextBox(
                      controller: c.txt_remarks,
                      width: 350,
                      caption: 'Remarks',
                      maxlength: 150,
                    ),
                  ],
                )
              ],
            ),
          )),
        )
      ],
    );
