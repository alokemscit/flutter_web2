import '../../../../core/config/const.dart';
import '../../shared/inv_shared_widget.dart';
import '../controller/inv_store_req_approval_controller.dart';

class InvStoreRequisition extends StatelessWidget implements MyInterface {
  const InvStoreRequisition({super.key});

  get childrenHeader => null;

  @override
  Widget build(BuildContext context) {
    final InvStoreRequisitionController c =
        Get.put(InvStoreRequisitionController());
    c.context = context;
    c.showDialogMethod = () => _showDialog(c);
    return Obx(() => CommonBodyWithToolBar1(c, [
          c.SelectedRequisition.value.reqId == null
              ? _topPart(c)
              : const SizedBox(),
          c.SelectedRequisition.value.reqId == null
              ? _tableMaster(c)
              : const SizedBox(),
          c.SelectedRequisition.value.reqId != null
              ? _appPanel(c)
              : const SizedBox(),
        ], (v) {
          c.toolEvent(v!);
        }));
  }

  void _showDialog(InvStoreRequisitionController c) => CustomDialog2(
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
                                            CustomTableCellx(
                                                text: f.reqNo ?? ''),
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

  Widget _appPanel(InvStoreRequisitionController c) => Expanded(
        child: Stack(
          children: [
            CustomGroupBox(
                child: Column(
              children: [
                4.heightBox,
                Row(
                  children: [
                    Expanded(
                      child: CustomGroupBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CustomTextHeaderWithCaptinAndChild(
                                  caption: 'Req. No',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      c.SelectedRequisition.value.reqNo ?? '',
                                      style: customTextStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                  )),
                              8.widthBox,
                              CustomTextHeaderWithCaptinAndChild(
                                  caption: 'Req. Date',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      c.SelectedRequisition.value.reqDate ?? '',
                                      style: customTextStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                  )),
                              8.widthBox,
                              CustomTextHeaderWithCaptinAndChild(
                                  caption: 'Priority',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      c.SelectedRequisition.value.priority ??
                                          '',
                                      style: customTextStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CustomGroupBox(
                      child: CustomTableGenerator(
                          colWidtList: const [
                        30,
                        60,
                        40,
                        30,
                        20,
                        20
                      ],
                          childrenHeader: [
                        CustomTableColumnHeaderBlack('Code'),
                        CustomTableColumnHeaderBlack('Item Name'),
                        CustomTableColumnHeaderBlack('Type', Alignment.center),
                        CustomTableColumnHeaderBlack('Unit', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'Req. Qty', Alignment.center),
                        CustomTableColumnHeaderBlack(
                            'App. Qty', Alignment.center),
                      ],
                          childrenTableRowList: c.list_temp
                              .map((f) => TableRow(
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.white70.withOpacity(0.5)),
                                      children: [
                                        CustomTableCellx(text: f.code ?? ''),
                                        CustomTableCellx(
                                          text: f.name ?? '',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CustomTableCellx(
                                          text: f.type ?? '',
                                          alignment: Alignment.center,
                                        ),
                                        CustomTableCellx(
                                          text: f.unit ?? '',
                                          alignment: Alignment.center,
                                        ),
                                        CustomTableCellx(
                                          text: f.req_qty ?? '',
                                          alignment: Alignment.center,
                                        ),
                                        InvEditText(f.qty!, f.focusNode!, 15,
                                            () {
                                          c.textChange(f);
                                        }, () {
                                          c.next_line_qty(f);
                                        }),
                                      ]))
                              .toList())),
                )
              ],
            )),
            Positioned(
                top: 6,
                right: 4,
                child: CustomRoundedButton(
                    iconColor: appBlueHighDeep,
                    icon: Icons.undo,
                    bgColor: Colors.transparent,
                    iconSize: 18,
                    onTap: () {
                      c.undo();
                    })),
          ],
        ),
      );

  Widget _tableMaster(InvStoreRequisitionController c) => Expanded(
        child: CustomGroupBox(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    child: CustomTextBox(
                  controller: c.txt_search,
                  width: 350,
                  maxlength: 50,
                )),
              ],
            ),
            8.heightBox,
            Expanded(
                child: CustomTableGenerator(
                    colWidtList: const [
                  30,
                  20,
                  40,
                  50,
                  30,
                  15
                ],
                    childrenHeader: [
                  CustomTableColumnHeaderBlack("Req. No"),
                  CustomTableColumnHeaderBlack("Req. Date"),
                  CustomTableColumnHeaderBlack("From Store"),
                  CustomTableColumnHeaderBlack("Remarks"),
                  CustomTableColumnHeaderBlack("Priority"),
                  CustomTableColumnHeaderBlack("*", Alignment.center),
                ],
                    childrenTableRowList: c.list_req_master_temp
                        .map((f) => TableRow(
                                decoration: BoxDecoration(
                                    color: c.SelectedRequisition.value.reqId ==
                                            f.reqId
                                        ? appColorRowSelected
                                        : Colors.white),
                                children: [
                                  CustomTableCellx(text: f.reqNo ?? ''),
                                  CustomTableCellx(text: f.reqDate ?? ''),
                                  CustomTableCellx(text: f.storeName ?? ''),
                                  CustomTableCellx(text: f.remarks ?? ''),
                                  CustomTableCellx(text: f.priority ?? ''),
                                  CustomTableEditCell(() {
                                    c.editForApproval(f);
                                  }, Icons.approval_rounded, 16, appColorBlue)
                                ]))
                        .toList()))
          ],
        )),
      );

  Widget _topPart(InvStoreRequisitionController c) => Row(
        children: [
          Expanded(
            child: CustomGroupBox(
                child: Row(
              children: [
                CustomDropDown2(
                    width: 250,
                    id: c.cmb_store_typeID.value,
                    list: c.list_store_type,
                    onTap: (v) {
                      c.cmb_store_typeID.value = v!;
                      c.loadRequisition();
                    })
              ],
            )),
          )
        ],
      );

  @override
  void disposeController() {
    mdisposeController<InvStoreRequisitionController>();
  }
}
