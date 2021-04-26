import 'package:get/get.dart';
import 'package:getx_app/pages/findPwd/findPwd.controller.dart';

class FindPwdBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FindPwdController>(() => FindPwdController());
  }

}