import 'package:get/get.dart';
import 'package:getx_app/pages/bdmap/bdmap_controller.dart';

class BDMapBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BDMapController>(() => BDMapController());
  }

}