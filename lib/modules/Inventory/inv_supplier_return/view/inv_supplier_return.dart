import '../../../../core/config/const.dart';
import '../controller/inv_supplier_return_controller.dart';

class InvSupplierReturn extends StatelessWidget implements MyInterface {
  const InvSupplierReturn({super.key});
  @override
  void disposeController() {
    mdisposeController<InvSupplierReturnController>();
  }

  @override
  Widget build(BuildContext context) {
    final InvSupplierReturnController c =
        Get.put(InvSupplierReturnController());
    c.context = context;
    return Obx(()=>CommonBodyWithToolBar(c, [],c.list_tool,(v){}));
  }
}
