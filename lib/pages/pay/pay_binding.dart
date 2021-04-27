import 'package:get/get.dart';
import 'package:getx_app/pages/pay/pay_controller.dart';

class PayBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PayController>(() => PayController());
  }

}