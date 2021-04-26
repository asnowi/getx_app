import 'package:get/get.dart';
import 'package:getx_app/pages/mine/mine_controller.dart';

class MineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MineController>(() => MineController());
  }

}