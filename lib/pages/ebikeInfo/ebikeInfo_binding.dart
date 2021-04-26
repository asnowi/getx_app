import 'package:get/get.dart';
import 'package:getx_app/pages/ebikeInfo/ebikeInfo_controller.dart';

class EbikeInfoBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<EbikeInfoController>(() => EbikeInfoController());
  }

}