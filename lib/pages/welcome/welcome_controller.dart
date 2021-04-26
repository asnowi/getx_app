import 'package:get/get.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/global.dart';

class WelcomeController extends GetxController{


  @override
  void onInit() {
    StorageUtil().setBool(SaveInfoKey.HAS_HOME, true);
    Global.hasHome = true;
    super.onInit();
  }

  void launchHome(){
    Get.offAndToNamed(AppRoutes.home);
  }
}