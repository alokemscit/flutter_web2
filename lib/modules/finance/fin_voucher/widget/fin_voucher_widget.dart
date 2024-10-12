import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/finance/fin_voucher/controller/fin_voucher_entry_controller.dart';

class FinVoucherWidget {
  Widget _fin_drawer_menu_posioned(FinVoucherEntryController c) =>
      c.context.width >= 1200
          ? const SizedBox()
          : Positioned(
              right: 0,
              top: 8,
              child: InkWell(
                  onTap: () {
                    !c.scaffoldKey.currentState!.isEndDrawerOpen
                        ? c.scaffoldKey.currentState!.openEndDrawer()
                        : c.scaffoldKey.currentState!.closeEndDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2, right: 4),
                    child: Icon(
                      Icons.menu,
                      color: appColorGrayDark,
                      size: 22,
                    ),
                  )));

  Widget _fin_voucher_widget_right_menu(
    FinVoucherEntryController c,
  ) =>
      SizedBox(
        width: 200,
        child: Stack(
          children: [
            CustomGroupBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: c.list_voucher_type
                  .map((f) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomButtonAnimated(
                                    icon: Icons.safety_check,
                                    caption: f.name!,
                                    onClick: () {
                                      if (c.scaffoldKey.currentState!
                                          .isEndDrawerOpen) {
                                        c.scaffoldKey.currentState!
                                            .closeEndDrawer();
                                      }
                                      c.selectedVoucherType.value = f;
                                      c.setNew();
                                    })),
                          ],
                        ),
                      ))
                  .toList(),
            )),
            c.context.width > 1199
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: () {
                        c.isShowRightMenuBar.value = false;
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 8, top: 8, bottom: 8, right: 0),
                        child: Icon(
                          Icons.arrow_right,
                          color: appColorGrayDark,
                          size: 36,
                        ),
                      ),
                    ))
                : const SizedBox(),
          ],
        ),
      );

  Widget finVoucherWidget(FinVoucherEntryController c, List<Widget> children) =>
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Scaffold(
                    key: c.scaffoldKey,
                    body: LayoutBuilder(builder: (context, constraints) {
                      // Use the mounted property to ensure safety
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (c.scaffoldKey.currentState!.isEndDrawerOpen) {
                          c.scaffoldKey.currentState!.closeEndDrawer();
                        }
                      });

                      return CustomGroupBox(
                        child: Column(
                          children: [
                            c.context.width < 1200 ? 10.heightBox : 2.heightBox,
                            _topPart(c),
                            ...children
                          ],
                        ),
                      );
                    }),
                    endDrawer: Drawer(
                      child: _fin_voucher_widget_right_menu(
                        c,
                      ),
                    ),
                  ),
                  _fin_drawer_menu_posioned(c),
                  (c.context.width > 1198 && !c.isShowRightMenuBar.value)
                      ?  Positioned(
                          right: 2,
                          top: 4,
                          child: InkWell(
                              onTap: () {
                                c.isShowRightMenuBar.value = true;
                              },
                              child: const Icon(Icons.menu)))
                      : const SizedBox()
                ],
              ),
            ),
            // Right menu adjustment based on screen size
            (c.context.width < 1200 || !c.isShowRightMenuBar.value)
                ? const SizedBox()
                : Row(
                    children: [
                      4.widthBox,
                      _fin_voucher_widget_right_menu(
                        c,
                      )
                    ],
                  ),
          ],
        ),
      );

  Widget _topPart(FinVoucherEntryController c) => Row(
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
                      CustomTextHeaderWithCaptinAndChild(
                        caption: 'Voucher Type :',
                        minChildWidth: 130,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            c.selectedVoucherType.value.name ?? '',
                            style: customTextStyle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      12.widthBox,
                      CustomTextHeaderWithCaptinAndChild(
                        caption: 'Voucher Date :',
                        child: CustomDatePickerDropDown(
                          label: '',
                          date_controller: c.txt_voucher_date,
                          isBackDate: true,
                          isShowCurrentDate: true,
                          width: 130,
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  Row(
                    children: [
                      CustomTextHeaderWithCaptinAndChild(
                        caption: 'Narration        :',
                        child: CustomTextBox(
                          controller: c.txt_voucher_narration,
                          width: 371,
                          maxLine: 2,
                          textInputType: TextInputType.multiline,
                          height: 48,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
          ),
        ],
      );


      void voucher_showDialog(FinVoucherEntryController controller) => CustomDialog(
    controller.context,
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        'Voucher List',
        style: customTextStyle.copyWith(color: appColorMint),
      ),
    ),
    Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 800,
            height: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomGroupBox(
                        child: _dialodContentTop(
                            controller,
                            MyWidget().DropDown
                              ..width = 250
                              ..id = controller.cmb_vs_v_typeID.value
                              ..list = controller.list_voucher_type
                              ..onTap = (v) {
                                controller.cmb_vs_v_typeID.value = v!;
                              },
                            MyWidget().DatePicker
                              ..width = 120
                              ..date_controller = controller.txt_vs_fdate
                              ..label = 'From Date'
                              ..isBackDate = true
                              ..isShowCurrentDate = true,
                            MyWidget().DatePicker
                              ..width = 120
                              ..date_controller = controller.txt_vs_tdate
                              ..label = 'To Date'
                              ..isBackDate = true
                              ..isShowCurrentDate = true,
                            MyWidget().IconButton
                              ..icon = Icons.search
                              ..text = 'Show'
                              ..onTap = () {
                                controller.show_voucher_with_date_range();
                              }),
                      ),
                    ),
                  ],
                ),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyWidget().SearchBox
                      ..width = 250
                      ..controller = controller.txt_vs_search
                      ..onChange = (v) {

                      },
                  ],
                ),
                8.heightBox,
                Expanded(
                    child: Obx(() =>
                     CustomTableGenerator(colWidtList: const [
                          30,
                          30,
                          30,
                          30,
                          50,
                          20
                        ], childrenHeader: [
                          MyWidget().TableColumnHeader..text = 'Voucher No',
                          MyWidget().TableColumnHeader..text = 'Voucher Date',
                          MyWidget().TableColumnHeader..text = 'Voucher Type',
                          MyWidget().TableColumnHeader..text = 'Voucher Amount'..alignment=Alignment.centerRight,
                          MyWidget().TableColumnHeader..text = 'Status'..alignment=Alignment.center,
                          MyWidget().TableColumnHeader
                            ..text = '*'
                            ..alignment = Alignment.center,
                        ], childrenTableRowList: [
                           ...controller.list_voucher_with_date_range.map((f)=>TableRow(children: [
                            CustomTableCellx(text: f.vno??''),
                            CustomTableCellx(text: f.vdate??''),
                            CustomTableCellx(text: f.vtName??''),
                            CustomTableCellx(text: (f.amt??0).toStringAsFixed(2),alignment: Alignment.centerRight,),
                            CustomTableCellx(text: f.status==1?'Approval Pending':f.status==2?'Approved':'Canceled'),
                            CustomTableEditCell((){},Icons.print,14,appColorBlue)

                           ]))

                        ]))
                        )
              ],
            ),
          ),
        ),
      ],
    ),
    () {},
    true,
    false);
Widget _dialodContentTop(FinVoucherEntryController controller, Widget dropdowb,
        Widget dateF, Widget dateT, Widget button) =>
    controller.context.width < 650
        ? Column(
            children: [
              Row(
                children: [
                  Expanded(child: dropdowb),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  Expanded(child: dateF),
                  8.widthBox,
                  Expanded(child: dateT),
                ],
              ),
              8.widthBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [button],
              )
            ],
          )
        : Row(
            children: [
              dropdowb,
              8.widthBox,
              dateF,
              8.widthBox,
              dateT,
              12.widthBox,
              button
            ],
          );
}
