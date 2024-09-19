
import '../../../../core/config/const.dart';
import '../controller/inv_pr_approval_controller.dart';

class InvPRApproval extends StatelessWidget {
  const InvPRApproval({super.key});
  void disposeController() {
    try {
      Get.delete<InvPRApprovalController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvPRApprovalController controller =
        Get.put(InvPRApprovalController());
    controller.context = context;
    return Obx(() => CommonBody3(controller, [
          Expanded(
            child: controller.selectedData.value.id != null
                ? _appPart(controller)
                : Column(
                    children: [
                      _header(controller),
                      4.heightBox,
                      _tablePart(controller)
                    ],
                  ),
          )
        ]));
  }
}

Widget _appPart(InvPRApprovalController controller) => Stack(
      children: [
        CustomGroupBox(
            padingvertical: 0,
            groupHeaderText: 'P.R For Approval',
            child: Column(
              children: [
                8.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomGroupBox(
                          padingvertical: 4,
                          groupHeaderText: 'PR. Details',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomTextHeaderWithCaptinAndValue(
                                    textColor: appColorMint,
                                    caption: 'P.R. No',
                                    text: controller.selectedData.value.prNo ??
                                        '',
                                  ),
                                  12.widthBox,
                                  CustomTextHeaderWithCaptinAndValue(
                                    textColor: appColorMint,
                                    caption: 'Created by',
                                    text: controller
                                            .selectedData.value.createdBy ??
                                        '',
                                  ),
                                  12.widthBox,
                                  CustomTextHeaderWithCaptinAndValue(
                                    textColor: appColorMint,
                                    caption: 'P.R. Date',
                                    text:
                                        controller.selectedData.value.prDate ??
                                            '',
                                  ),
                                  12.widthBox,
                                  (controller.selectedData.value.remarks ??
                                              '') ==
                                          ''
                                      ? const SizedBox()
                                      : CustomTextHeaderWithCaptinAndValue(
                                          textColor: appColorMint,
                                          caption: 'Note',
                                          text: controller
                                                  .selectedData.value.remarks ??
                                              '',
                                        ),
                                ],
                              ),
                            ),
                          )),
                    )),
                  ],
                ),
                4.heightBox,
                Expanded(
                  child: Stack(
                    children: [
                      CustomGroupBox(
                          padingvertical: 0,
                          groupHeaderText: 'Item List For Approval',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTableGenerator(colWidtList: const [
                              30,
                              80,
                              20,
                              50,
                              50,
                              50,
                              50,
                              20,
                              20
                            ], childrenHeader: [
                              CustomTableColumnHeaderBlack(
                                  'Code', Alignment.center),
                              CustomTableColumnHeaderBlack('Name'),
                              CustomTableColumnHeaderBlack('Unit'),
                              CustomTableColumnHeaderBlack('Generic'),
                              CustomTableColumnHeaderBlack('Grpup'),
                              CustomTableColumnHeaderBlack('Sub Group'),
                              CustomTableColumnHeaderBlack('Remarks'),
                              CustomTableColumnHeaderBlack(
                                  'PR. Qty', Alignment.center),
                              CustomTableColumnHeaderBlack(
                                  'App. Qty', Alignment.centerRight),
                            ], childrenTableRowList: [
                              ...controller.list_item_details.map((f) =>
                                  TableRow(
                                      decoration: BoxDecoration(
                                          color: appGray50.withOpacity(0.1)),
                                      children: [
                                        CustomTableCellx(
                                          text: f.code!,
                                          alignment: Alignment.center,
                                        ),
                                        CustomTableCellx(
                                          text: f.name!,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CustomTableCellx(text: f.unit!),
                                        CustomTableCellx(text: f.genaric!),
                                        CustomTableCellx(text: f.group!),
                                        CustomTableCellx(text: f.subGroup!),
                                        CustomTableCellx(text: f.remarks!),
                                        CustomTableCellx(
                                          text: f.prQty!,
                                          alignment: Alignment.center,
                                          fontColor: appColorMint,
                                        ),
                                        // CustomTableCellx(text: f.!),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.fill,
                                            child: CustomTextBox(
                                              caption: '',
                                              controller: f.appQty!,
                                              textInputType:
                                                  TextInputType.number,
                                              maxlength: 15,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w600,
                                              // fillColor: appColorPista,isFilled: true,
                                            ))
                                      ])),
                            ]),
                          )),
                      Positioned(
                          bottom: 6,
                          right: 12,
                          child: Row(
                            children: [
                              CustomTextBox(
                                  caption: 'Note',
                                  width: 300,
                                  maxlength: 150,
                                  controller: controller.txt_note),
                              8.widthBox,
                              CustomButton(Icons.save, 'Approve', () {
                                controller.prApprove_cancel(false);
                              }),
                              12.widthBox,
                              CustomButton(Icons.delete, 'Cance', () {
                                controller.prApprove_cancel(true);
                              }, Colors.red, Colors.red, kBgColorG)
                            ],
                          ))
                    ],
                  ),
                ),
                8.heightBox,
              ],
            )),
        Positioned(
            top: 6,
            right: 8,
            child: CustomUndoButtonRounded(
              onTap: () {
                controller.setUndoSelectData();
              },
              bgColor: Colors.transparent,
              iconSize: 22,
            ))
      ],
    );

_tablePart(InvPRApprovalController controller) => Expanded(
    child: CustomGroupBox(
        groupHeaderText: 'P.R. List',
        child: CustomTableGenerator(colWidtList: const [
          40,
          30,
          40,
          50,
          30,
          80,
          20
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('P.R. No'),
          CustomTableColumnHeaderBlack('Priority'),
          CustomTableColumnHeaderBlack('P.R. Date'),
          CustomTableColumnHeaderBlack('Created By'),
          CustomTableColumnHeaderBlack('Created date'),
          CustomTableColumnHeaderBlack('Remarks'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: [
          ...controller.list_pr_for_app_temp.map((f) => TableRow(
                  decoration: BoxDecoration(
                      color: controller.onHoverID.value == f.id!.toString()
                          ? appColorPista
                          : Colors.white),
                  children: [
                    CustomTableCellx(
                      text: f.prNo!,
                      onExit: () {
                        controller.onHoverID.value = '';
                      },
                      onHover: () {
                        controller.onHoverID.value = f.id!.toString();
                      },
                      onTap: () {
                        controller.setPR(f);
                      },
                    ),
                    CustomTableCellx(text: f.priorityName!),
                    //  CustomTableColumnCellBody(f.prNo!),
                    CustomTableColumnCellBody(f.prDate!),
                    CustomTableColumnCellBody(f.createdBy!),
                    CustomTableColumnCellBody(f.createdDate!),
                    CustomTableColumnCellBody(f.remarks!),
                    CustomTableEditCell(() {
                      controller.setPR(f);
                    }, Icons.settings, 14)
                  ]))
        ])));
_header(InvPRApprovalController controller) => Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              CustomGroupBox(
                  padingvertical: 0,
                  groupHeaderText: '',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomDropDown2(
                              width: 180,
                              id: controller.cmb_store_typeID.value,
                              list: controller.list_storeTypeList,
                              onTap: (v) {
                                controller.cmb_store_typeID.value = v!;
                              }),
                          12.widthBox,
                          CustomDatePickerDropDown(
                            date_controller: controller.txt_fdate,
                            isBackDate: true,
                          ),
                          12.widthBox,
                          CustomDatePickerDropDown(
                              date_controller: controller.txt_tdate,
                              isBackDate: true),
                          12.widthBox,
                          CustomButton(Icons.search, 'Show', () {
                            controller.show();
                          }),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: 0,
                  bottom: 0,
                  right: 6,
                  child: Tooltip(
                    message: 'Approve/Cancel History',
                    child: InkWell(
                      onTap: () {
                        _dialogBox(controller);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.history,
                          color: appColorBlue,
                          size: 24,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    );

_dialogBox(InvPRApprovalController controller) => CustomDialog(
    controller.context,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        'Previous Approve/Cancel History',
        style: customTextStyle.copyWith(color: appColorMint, fontSize: 12),
      ),
    ),
    Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 1000,
            height: 600,
            child: CustomGroupBox(
                padingvertical: 0,
                groupHeaderText: '',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      CustomGroupBox(
                        padingvertical: 0,
                        groupHeaderText: '',
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Flexible(
                                child: CustomDropDown2(
                                    width: 180,
                                    id: controller
                                        .cmb_store_typeID_history.value,
                                    list: controller.list_storeTypeList,
                                    onTap: (v) {
                                      controller
                                          .cmb_store_typeID_history.value = v!;
                                    }),
                              ),
                              8.widthBox,
                              CustomDatePickerDropDown(
                                date_controller: controller.txt_fdate_history,
                                isBackDate: true,
                              ),
                              8.widthBox,
                              CustomDatePickerDropDown(
                                  date_controller: controller.txt_tdate_history,
                                  isBackDate: true),
                              8.widthBox,
                              CustomButton(Icons.search, 'Show', () {
                                controller.showHistory();
                              }),
                            ],
                          ),
                        ),
                      ),
                      8.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                              child: CustomSearchBox(
                                  caption: 'Search',
                                  width: 350,
                                  controller: controller.txt_search,
                                  onChange: (v) {}))
                        ],
                      ),
                      4.heightBox,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Obx(() =>
                              CustomTableGenerator(colWidtList: const [
                                20,
                                20,
                                40,
                                40,
                                15
                              ], childrenHeader: [
                                CustomTableColumnHeaderBlack('PR.No'),
                                CustomTableColumnHeaderBlack('PR. Date'),
                                CustomTableColumnHeaderBlack('Remarks'),
                                CustomTableColumnHeaderBlack('Status'),
                                CustomTableColumnHeaderBlack(
                                    '*', Alignment.center),
                              ], childrenTableRowList: [
                                ...controller.list_PR_Prv_temp.map((f) =>
                                    TableRow(children: [
                                      CustomTableCellx(text: f.prNo!),
                                      CustomTableCellx(text: f.prDate!),
                                      CustomTableCellx(text: f.remarks!),
                                      //CustomTableCellx(text: f.prNo!),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  f.appBy != ''
                                                      ? 'Approved by${f.appBy!}, App Date: ${f.appDate!}'
                                                      : f.cancelBy != ''
                                                          ? 'Canceled by${f.cancelBy!}, Canceled Date: ${f.cancelDate!}'
                                                          : "Not Approved",
                                                  style:
                                                      customTextStyle.copyWith(
                                                          fontSize: 10.5,
                                                          color: f.appBy != ''
                                                              ? appColorBlue
                                                              : f.cancelBy != ''
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .black,
                                                          fontFamily:
                                                              appFontLato,fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          )),
                                      CustomTableEditCell(() {
                                        controller.showPrvReport(f.id!);
                                      }, Icons.print, 14)
                                    ]))
                              ])),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ],
    ),
    () {},
    false,
    false);
