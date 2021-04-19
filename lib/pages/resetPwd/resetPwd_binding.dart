import 'package:get/get.dart';
import 'package:getx_app/pages/resetPwd/resetPwd_controller.dart';

class ResetPwdBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ResetPwdController>(() => ResetPwdController());
  }
}