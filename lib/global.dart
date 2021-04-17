import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getx_app/common/db/index.dart';

class Global{
  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

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
  }


}