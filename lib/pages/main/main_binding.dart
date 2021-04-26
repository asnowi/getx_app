import 'package:get/get.dart';
import 'package:getx_app/pages/main/main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }

}