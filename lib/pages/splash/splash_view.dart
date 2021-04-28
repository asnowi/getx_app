import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/global.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    applyPermissions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.blue,
          child: Image.asset(AssetsProvider.imagePath('pic_splash',type: 'jpg'),fit: BoxFit.fill)
      ),
    );
  }


  Future<void> applyPermissions(BuildContext context) async{
    LogUtils.GGQ('开始权限申请');
    if(await Permission.storage.request().isGranted && await Permission.location.request().isGranted){
      //判断 是欢迎页还是 首页
      if(Global.hasHome){
        Get.offAndToNamed(AppRoutes.home);
      }else{
        Get.offAndToNamed(AppRoutes.welcome);
      }
    }else{
      //未通过,
      // 退出
      popApp();
    }
  }

  static Future<void> popApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}


