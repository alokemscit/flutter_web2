import '../../../../core/config/const.dart';
import '../controller/inv_nagative_adjust_controller.dart';

class InvNagativeAdjust extends StatelessWidget implements MyInterface {
  const InvNagativeAdjust({super.key});

  @override
  Widget build(BuildContext context) {
    final InvNagativeAdjustController c =
        Get.put(InvNagativeAdjustController());
    c.context = context;
    return Obx(()=>CommonBodyWithToolBar1(c, [], (v){}));
  }

  @override
  void disposeController() {
    mdisposeController<InvNagativeAdjustController>();
  }
}
