import 'dart:async';

import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:getx_app/common/widget/baidu/index.dart';

class CarHelper {

  final BMFMapController controller;
  final List<BMFCoordinate> pointList;
  final BMFMarker car;
  Timer _timer;




  CarHelper(this.controller, this.pointList, this.car):super();


  List<BMFCoordinate> booList = [];

  int _index = 0;

  Duration timeInterval = Duration(milliseconds: 50);



  void onStart(){
    _index = 0;
    _timer = Timer.periodic(timeInterval , (timer){
      _index++;
      if(_index < pointList.length){
        car.updatePosition(pointList[_index]);
        //防碰壁
        beCan(pointList[_index]);
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



  void beCan(BMFCoordinate point){
    //判断当前点里四周的距离
    //如果
    controller.setCenterCoordinate(pointList[_index], true);

  }


}