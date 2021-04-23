import 'package:flutter/cupertino.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:getx_app/common/widget/baidu/index.dart';

class CarHelper {

  final BMFMapController controller;
  final List<BMFCoordinate> pointList;
  final BMFMarker car;

  CarHelper(this.controller, this.pointList, this.car):super();


  List<BMFCoordinate> booList = [];

  int index = 0;

  void onMove(){
    car.position = pointList[index+1];
  }


  void onStar(){

  }

  void onFinish(){

  }



}