import 'dart:async';
import 'dart:ui';

import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';

// import 'package:flutter_baidu_mapapi_map/src/map/bmf_projection.dart';
// import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_method_id.dart' show BMFProjectionMethodId;

class CarHelper {

  final BMFMapController controller;
  final List<BMFCoordinate> pointList;
  final BMFMarker car;
  Timer _timer;
  final int moveDistance = 3;

  final Size size = Get.size;



  CarHelper(this.controller, this.pointList, this.car):super();

  int _index = 0;
  Duration timeInterval = Duration(milliseconds: 100);




  List<BMFMarker> markerList = [];
  void onStart(){
    if(markerList.isNotEmpty){
      controller.removeMarkers(markerList);
      markerList.clear();
    }
    _index = 0;
    _timer = Timer.periodic(timeInterval , (timer){
      _index++;
      if(_index < pointList.length){
        car.updatePosition(pointList[_index]);
        //生成marker
        BMFMarker gcodingMarker = BMFMarker(
            enabled: true,
            position: pointList[_index],
            title: '打点',
            identifier: 'gcodingMarker',
            icon: AssetsProvider.imagePath('ic_gcoding'),
        );
        controller.addMarker(gcodingMarker);
        markerList.add(gcodingMarker);
        //防碰壁
        onMoveUpScreen(pointList[_index]);
      }else{
        onFinish();
      }
    });


  }

  void onFinish(){
    if(_timer != null && _timer.isActive){
      _timer.cancel();
    }
  }




  void onMoveUpScreen(BMFCoordinate c)async{
    //判断当前点里四周的距离
    //如果
   controller.setCenterCoordinate(pointList[_index], true);
    // 更新地图Options方式更新中心点。 设置方法为：
   controller.updateMapOptions(BMFMapOptions(center:pointList[_index]));
    LogUtils.GGQ('onMoveUpScreen->>>${c.latitude} -- ${c.longitude}');


    BMFMapStatus status = await controller.getMapStatus();
    BMFCoordinateBounds bounds = await controller.getVisibleMapBounds();
    BMFPoint point = status.targetScreenPt;


    // x 纬度  y 经度
    LogUtils.GGQ("point-x:${point.x} -- y:${point.y}");
    LogUtils.GGQ("bounds-东北:${bounds.northeast.latitude} -- ${bounds.northeast.longitude}");
    LogUtils.GGQ("bounds-西南:${bounds.southwest.latitude} -- ${bounds.southwest.longitude}");
    // if(point.x <= size.width/3 || point.x >= size.width * 0.9 || point.y <= size.height/3 || point.y >= size.height * 0.9){
    //   controller.setCenterCoordinate(pointList[_index], true);
    //   LogUtils.GGQ("中心");
    // }

    // BMFProjection.convertCoordinateToScreenPoin

    // BMFPoint p = await controller.getBMFProjection().convertCoordinateToScreenPoint(c);
    //kScreenPointFromCoordinateMethod
    // BMFProjection projection =

    // LogUtils.GGQ("p-x:${p.x} -- y:${p.y}");


  }


}