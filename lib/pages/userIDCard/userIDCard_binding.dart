import 'package:get/get.dart';
import 'package:getx_app/pages/userIDCard/userIDCard_controller.dart';

class UserIDCardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserIDCardController>(() => UserIDCardController());
  }
}