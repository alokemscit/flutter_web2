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
}
