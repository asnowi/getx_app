import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/delayed_util.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';
import 'package:getx_app/common/widget/dialog/loading_dialog.dart';
import 'package:getx_app/common/model/locus_entity.dart' as LocusEntity;

class LocusController extends GetxController{

  BMFMapController mapController;
  BMFMapOptions mapOptions;

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


        String json = AssetsProvider.loadJson('locus');
        // String data = await DefaultAssetBundle.of(context).loadString(json);




   //     LocusEntity entity = locusEntityFromJson(json);
     //   LogUtils.GGQ('entity ->${entity.code}');
      }catch(e){
        LogUtils.GGQ('error -> ${e}');
      }




      LoadingDialog.dismiss();
    },milliseconds: 5000);
  }
}