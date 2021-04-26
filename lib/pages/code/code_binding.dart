import 'package:get/get.dart';
import 'package:getx_app/pages/code/code_controller.dart';

class CodeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CodeController>(() => CodeController());
  }

}