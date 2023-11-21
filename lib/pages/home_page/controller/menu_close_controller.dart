import 'package:get/get.dart';
class MenuCloseController extends GetxController {
 RxBool isTrue = false.obs;
  void toggleValue() {
    isTrue.toggle();
  }
}