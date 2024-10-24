 
import 'package:pdf/widgets.dart';

 
import 'package:web_2/core/config/const.dart';
 

mixin MixInController {
  late BuildContext context = Get.context!;
  late data_api2 api = data_api2();
  late CustomAwesomeDialog dialog = CustomAwesomeDialog(context: context);
  late CustomBusyLoader loader = CustomBusyLoader(context: context);
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  late Font font;
 var list_tools=<CustomTool>[].obs;
  
  // var statusList = <ModelStatus>[].obs;
}

mixin MixinMethod {
  void disposeController();
}
