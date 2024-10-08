import '../../../../core/config/const.dart';
import '../controller/fin_voucher_entry_controller.dart';
import '../widget/fin_voucher_widget.dart';

class FinVoucherEntry extends StatelessWidget implements MyInterface {
  const FinVoucherEntry({super.key});

  @override
  void disposeController() {
    mdisposeController<FinVoucherEntryController>();
  }

  @override
  Widget build(BuildContext context) {
    final FinVoucherEntryController c = Get.put(FinVoucherEntryController());
    c.context = context;

    return Obx(() => CommonBodyWithToolBar(
            c, [FinVoucherWidget().finVoucherWidget(c, [
              
              _topPart(c),
            ])], c.list_tool, (v) {
          c.toolevent(v);
        }));
  }
}

Widget _topPart(FinVoucherEntryController c) => Row(
  children: [
    Expanded(
      child: CustomGroupBox(
              child: Row(
            children: [
              //CustomTextHeader(text: 'Voucher Type : '),
              CustomTextHeaderWithCaptinAndValue(caption: 'Voucher Type ', text: c.selectedVoucherType.value.name??'')
            ],
          )),
    ),
  ],
);
