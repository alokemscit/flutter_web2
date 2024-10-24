import '../../../../core/config/const.dart';
import '../controller/hr_duty_roster_controller.dart';

class HrDutyRoster extends StatelessWidget {
  const HrDutyRoster({super.key});

   
  void disposeController() {
    mdisposeController<HrDutyRosterController>();
  }

  @override
  Widget build(BuildContext context) {
    final HrDutyRosterController controller = Get.put(HrDutyRosterController())..context=context;
    
    return Obx(()=>CommonBodyWithToolBar(controller, [],[
      CustomTool(menu: ToolMenuSet.file),
      CustomTool(menu: ToolMenuSet.save),
      CustomTool(menu: ToolMenuSet.close)
    ]));
  }
}
