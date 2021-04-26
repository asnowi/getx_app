import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/db/index.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart' show BMFMapSDK, BMF_COORD_TYPE;

class Global{
  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static bool hasHome = false;

  /// 是否 ios
  static bool isIOS = Platform.isIOS;
  /// 是否 android
  static bool isAndroid = Platform.isAndroid;

  static DBUtil dbUtil;

  static User userInfo;

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始
    await StorageUtil.init();

    // 第一次打开应用
    hasHome = StorageUtil().getBool(SaveInfoKey.HAS_HOME);

    // hive
    await DBUtil.install();
    dbUtil = await DBUtil.getInstance();
    userInfo = dbUtil.getCurrentUser();
    //  android 状态栏为透明的沉浸
    if (isAndroid) {
        SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark
        );
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }


    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskColor = Colors.black
      ..backgroundColor = Colors.black
      ..indicatorColor = Colors.white
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..textColor = Colors.white
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..indicatorSize = 32
      ..radius = 8
      ..fontSize = 12
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      )
      ..indicatorWidget = Container(
        color: Colors.black,
        width: 42,
        height: 42,
        child: Lottie.asset(AssetsProvider.lottiePath('loading')),
      )
      ..dismissOnTap = false;


    if (isAndroid) {
      // BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
      LogUtils.GGQ('--百度地图->>>>android<<<---');
    }else if (isIOS) {
      //BMFMapSDK.setApiKeyAndCoordType('替换为百度ios-AK', BMF_COORD_TYPE.BD09LL);
      //LocationFlutterPlugin.setApiKey("替换为百度ios-AK");
      LogUtils.GGQ('--百度地图->>>>ios<<<---');
    }

  }


}