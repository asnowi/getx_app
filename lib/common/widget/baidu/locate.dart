import 'dart:async';

import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';

StreamSubscription<Map<String, Object>> _locationListener;

LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

getLocate() {
  /// 动态申请定位权限
  _locationPlugin.requestPermission();

  /// 设置ios端ak, android端ak可以直接在清单文件中配置
  // LocationFlutterPlugin.setApiKey("百度地图开放平台申请的ios端ak");

  return _locationPlugin.onResultCallback;
}

void dispose() {
  if (null != _locationListener) {
    _locationListener.cancel(); // 停止定位
  }
}

/// 设置android端和ios端定位参数
void _setLocOption() {
  /// android 端设置定位参数
  BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
  androidOption.setCoorType("BD09LL"); // 设置返回的位置坐标系类型
  androidOption.setIsNeedAltitude(false); // 设置是否需要返回海拔高度信息
  androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
  androidOption.setIsNeedLocationPoiList(false); // 设置是否需要返回周边poi信息
  androidOption.setIsNeedNewVersionRgc(false); // 设置是否需要返回最新版本rgc信息
  androidOption.setIsNeedLocationDescribe(false); // 设置是否需要返回位置描述
  androidOption.setOpenGps(true); // 设置是否需要使用gps
  androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
  // androidOption.setScanspan(1500); // 设置发起定位请求时间间隔
  androidOption.setScanspan(6000); // 设置发起定位请求时间间隔

  Map androidMap = androidOption.getMap();

  /// ios 端设置定位参数
  BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
  iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
  iosOption.setBMKLocationCoordinateType(
      "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
  iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
  iosOption.setLocationTimeout(10); // 设置位置获取超时时间
  iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
  iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
  iosOption.setDistanceFilter(100); // 设置定位最小更新距离
  iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
  iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

  Map iosMap = iosOption.getMap();

  _locationPlugin.prepareLoc(androidMap, iosMap);
}

// 启动定位
void startLocation() {
  if (null != _locationPlugin) {
    _setLocOption();
    _locationPlugin.startLocation();
  }
}

/// 停止定位
void stopLocation() {
  if (null != _locationPlugin) {
    _locationPlugin.stopLocation();
  }
}