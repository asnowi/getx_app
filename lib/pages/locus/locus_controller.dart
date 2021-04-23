import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/model/locus_entity.dart';
import 'package:getx_app/common/utils/car_helper.dart';
import 'package:getx_app/common/utils/delayed_util.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';
import 'package:getx_app/common/widget/dialog/loading_dialog.dart';
import 'package:getx_app/main.dart';

class LocusController extends GetxController{

  BMFMapController mapController;
  BMFMapOptions mapOptions;

  CarHelper _carHelper;

  var _hasLoad = false;
  bool get hasLoad => _hasLoad;
  void changeHasLoad(bool b){
    this._hasLoad = b;
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
     loadData();
     LogUtils.GGQ('onReady');
    super.onReady();
  }


  void loadData(){
    LoadingDialog.show();
    DelayedUtil.delayed(() async{
      try{
        String locus = AssetsProvider.loadJson('locus');
        String json = await DefaultAssetBundle.of(navigatorKey.currentState.overlay.context).loadString(locus);
        LocusEntity entity = locusEntityFromJson(json);
        LogUtils.GGQ('entity-->${entity.code}');
        List<DataBean> dataList = entity.data;
        if(!dataList.isBlank){
          List<BMFCoordinate> pointList = dataList.map((e) => BMFCoordinate(double.parse(e.lat), double.parse(e.lng))).toList();
          /// 颜色
          List<Color> colors = [Colors.blue];
          List<int> indexs = [0];
          List<String> textures = [AssetsProvider.imagePath('line_road')];

          BMFPolyline polyline = BMFPolyline(
            coordinates: pointList,
            indexs: indexs,
            // colors: colors,
            textures: textures,
            width: 10,
            dottedLine: false
          );
          /// 添加polyline
          mapController.addPolyline(polyline);
          //添加开始和结束标记 marker
          BMFMarker startMarker = BMFMarker(
              position: pointList.first,
              title: '开始',
              identifier: 'startMarker',
              icon: AssetsProvider.imagePath('gcoding_start'));

          BMFMarker carMarker = BMFMarker(
              position: pointList.first,
              title: '小车',
              identifier: 'carMarker',
              icon: AssetsProvider.imagePath('marker_car'));


          //添加开始和结束标记 marker
          BMFMarker endMarker = BMFMarker(
              position: pointList.last,
              title: '结束',
              identifier: 'endMarker',
              icon: AssetsProvider.imagePath('gcoding_end'));


          //添加开始和结束标记 marker
          // BMFMarker pointMarker = BMFMarker(
          //     position: pointList.last,
          //     title: '点',
          //     identifier: 'pointMarker',
          //     icon: AssetsProvider.imagePath('ic_gcoding'));


          /// 添加Marker
          List<BMFMarker> markers = [startMarker,endMarker,carMarker];
          // List<BMFMarker> markers = [];
          // pointList.asMap().forEach((index, value) {
          //   if(index == 0){
          //     markers.add(BMFMarker(
          //         position: value,
          //         title: '开始',
          //         identifier: 'startMarker',
          //         icon: AssetsProvider.imagePath('gcoding_start')));
          //   }else if(index == pointList.length - 1){
          //     markers.add(BMFMarker(
          //         position: value,
          //         title: '结束',
          //         identifier: 'endMarker',
          //         icon: AssetsProvider.imagePath('gcoding_end')));
          //   }else{
          //     markers.add(BMFMarker(
          //         position: value,
          //         title: '点',
          //         identifier: 'pointMarker',
          //         icon: AssetsProvider.imagePath('ic_gcoding')));
          //   }
          // });




          mapController.addMarkers(markers);
          mapController.setCenterCoordinate(pointList.first, true);
          mapController.setZoomTo(18);

          update(['updateMap']);


          // _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
          //   _index++;
          //   if(_index < pointList.length){
          //     carMarker.updatePosition(pointList[_index]);
          //   } else{
          //     _timer.cancel();
          //   }
          // });


          _carHelper = CarHelper(mapController, pointList, carMarker);
          
        }
      }catch(e){
        LogUtils.GGQ('error -> ${e}');
      }

      LoadingDialog.dismiss();
    });
  }


  void onCarPlay(){
    if(_carHelper != null){
      _carHelper.onStart();
    }
  }

  void onRefresh(){
    if(_carHelper != null){
      _carHelper.onFinish();
      _carHelper.onStart();
    }
  }




}