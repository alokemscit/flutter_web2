import '../../../../core/config/const.dart';
import '../controller/inv_positive_adjust_controller.dart';

class InvPositiveAdjustment extends StatelessWidget implements MyInterface {
  const InvPositiveAdjustment({super.key});
  @override
  Widget build(BuildContext context) {
    final InvPositiveAdjustmentController c =
        Get.put(InvPositiveAdjustmentController());
    c.context = context;
    return Obx(()=>CommonBodyWithToolBar1(c, [], (v){}));
  }

  @override
  void disposeController() {
    mdisposeController<InvPositiveAdjustmentController>();
  }
}
