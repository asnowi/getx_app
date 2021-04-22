import 'package:get/get.dart';
import 'package:getx_app/pages/locus/locus_controller.dart';

class LocusBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LocusController>(() => LocusController());
  }

}