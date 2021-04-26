import 'package:get/get.dart';
import 'package:getx_app/pages/welcome/welcome_controller.dart';

class WelcomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }

}