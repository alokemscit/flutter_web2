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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, right: 4),
                    child: Icon(
                      c.scaffoldKey.currentState!.isEndDrawerOpen
                          ? Icons.close_outlined
                          : Icons.menu,
                      color: appColorGrayDark,
                      size: 22,
                    ),
                  )));

  Widget _fin_voucher_widget_right_menu(
    FinVoucherEntryController c,
  ) =>
      SizedBox(
        width: 200,
        child: CustomGroupBox(
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
                                })),
                      ],
                    ),
                  ))
              .toList(),
        )),
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
                            c.context.width < 1200
                                ? 10.heightBox
                                : const SizedBox(),
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
                ],
              ),
            ),
            // Right menu adjustment based on screen size
            c.context.width < 1200
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
}
