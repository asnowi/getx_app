import 'package:get/get.dart';
import 'package:getx_app/pages/ownerInfo/ownerInfo_controller.dart';

class OwnerInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OwnerInfoController>(() => OwnerInfoController());
  }
}