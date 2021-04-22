
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';


class HomeController extends GetxController{
  var _currentIndex = 0.obs;

  int get currentIndex{
    return _currentIndex.value;
  }

  void selectedItem(int index) {
    this._currentIndex.value = index;
  }



  @override
  void onInit() {
    LogUtils.GGQ('onInit');
    super.onInit();
  }

  @override
  void onReady() {
    onBaiduLocation();
    LogUtils.GGQ('onReady');
    super.onReady();
  }


  var _hasLocation = false.obs;

  bool get hasLocation => _hasLocation.value;

  void changeHasLocation(bool b){
    this._hasLocation.value = b;
  }


  void onBaiduLocation(){
  // 设置监听当前位置，更新位置
    var listener = getLocate();
    //开启定位
    startLocation();
    listener().listen((Map<String, Object> result) {
      String latitude = result['latitude'].toString();
      String longitude = result['longitude'].toString();
      String address = result['address'];
      if(!latitude.isBlank && !longitude.isBlank && !address.isBlank){
        LogUtils.GGQ('-----定位---');
        LogUtils.GGQ('-----纬度--->${latitude}');
        LogUtils.GGQ('-----经度--->${longitude}');
        LogUtils.GGQ('-----位置--->${address}');
        stopLocation();
      }
    });
  }
//轨迹
}