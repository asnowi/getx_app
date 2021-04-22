import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';

class BDMapController extends GetxController{

  BMFMapController mapController;
  BMFMapOptions mapOptions;

  var _hasLoad = false;
  bool get hasLoad => _hasLoad;
  void changeHasLoad(bool b){
    this._hasLoad = b;
  }


  @override
  void onInit() {
    onBaiduLocation();
    super.onInit();
  }


  @override
  void onReady() {
    mapOptions = BMFMapOptions(
        //center: BMFCoordinate(41.932551, 123.410423),
        zoomLevel: 12,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
    if(mapOptions != null){
      changeHasLoad(true);
      update(['updateMap']);
    }
    LogUtils.GGQ('onReady');
    super.onReady();
  }

  bool _isFirst = false;
  BMFCoordinate _coordinate;

  void onBaiduLocation(){
    // 设置监听当前位置，更新位置
    var listener = getLocate();
    listener().listen((Map<String, Object> result) {
      double latitude = result['latitude'];
      double longitude = result['longitude'];
      String address = result['address'];
      if(!latitude.isBlank && !longitude.isBlank && !address.isBlank){
        LogUtils.GGQ('-----定位---');
        LogUtils.GGQ('-----纬度--->${latitude}');
        LogUtils.GGQ('-----经度--->${longitude}');
        LogUtils.GGQ('-----位置--->${address}');
        // 动态跟新我的位置
        if(mapController != null){
          LogUtils.GGQ('动态更新我的位置');
          _coordinate = BMFCoordinate(latitude, longitude);
          mapController.updateLocationData(BMFUserLocation(
            location: BMFLocation(
                coordinate: _coordinate,
                altitude: 0,
                horizontalAccuracy: 5,
                verticalAccuracy: -1.0,
                speed: -1.0,
                course: -1.0),
          ));
          if(!_isFirst){
            _isFirst = true;
            mapController.setCenterCoordinate(BMFCoordinate(latitude, longitude), true);
            mapController.setZoomTo(18);
          }
          update(['updateMap']);
        }
      }
    });
  }

  void locUserCenter(){
    if(_coordinate != null){
      mapController.setCenterCoordinate(_coordinate, true);
      mapController.setZoomTo(18);
    }
  }

  @override
  void dispose() {
    stopLocation();
    super.dispose();
  }
}