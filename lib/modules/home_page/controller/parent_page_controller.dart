
import 'package:web_2/core/config/config.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/admin/module_page/model/model_module.dart';
import 'package:web_2/modules/authentication/login_page2.dart';

import '../../../core/config/notifers/auth_provider.dart';

class ParentPageController extends GetxController with MixInController {
  ParentPageController(BuildContext context) {
    context = context;
  }

  void logOut() async {
    await AuthProvider().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage2()),
    );
    Get.deleteAll();
  }

  var module_list = <ModuleMenuList>[].obs;
  //Rx<Company> company = Company(id: '', name: '', logo: '').obs;

  var empId = ''.obs;
  var empName = ''.obs;
  var empDesig = ''.obs;
  var img_string = ''.obs;
  //var com_list = <Company>[].obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    module_list.addAll(await get_module_list());
    user.value = await getUserInfo();
    if (user.value.uid == null) {
      dialog = CustomAwesomeDialog(context: context);
      dialog
        ..dialogType = DialogType.error
        ..message = "You have to re-login"
        ..show()
        ..onTap = () {
          AuthProvider().logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage2()),
          );
        };
      isLoading.value = false;
    }
    // print((user.value.comID));
    // com_list.addAll((get_company_list())
    //     .where((element) => element.id == user.value.comID));
    // company.value = com_list.first;
    // empId.value = user.value.eMPID!;
    // empName.value = user.value.eMPNAME!;
    // empDesig.value = user.value.dSGNAME!;
    // img_string.value = user.value.iMAGE!;
    isLoading.value = false;
  }
}
