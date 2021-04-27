import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/config/config.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';
import 'package:getx_app/pages/locus/locus_controller.dart';

class LocusView extends GetView<LocusController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white ,
        elevation: 0.0,
        title: Text('轨迹查询',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
        leading: IconButton(
          splashRadius: Config.backRadius,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.grey,
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            _buildMap(),
            _buildController(),
          ],
        ),
      )
    );
  }

  Widget _buildMap(){
    LogUtils.GGQ('_buildMap');
    return GetBuilder<LocusController>(
      id: 'updateMap',
      builder: (_) => controller.hasLoad? BMFMapWidget(
          onBMFMapCreated: (c){
            controller.mapController = c;
            // 定位自己
            controller.mapController?.showUserLocation(true);
          },
          mapOptions: controller.mapOptions
      ): CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),);
  }

  Widget _buildController(){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: Icon(Iconfont.carPlay,color: Colors.blue,), onPressed: (){
              Get.snackbar('', '播放');
              controller.onCarPlay();
          }),
          IconButton(icon: Icon(Iconfont.carFresh,color: Colors.blue,), onPressed: (){
            Get.snackbar('', '重复');
            controller.onRefresh();
          }),
          // IconButton(icon: Icon(Iconfont.carUp,color: Colors.blue,), onPressed: (){
          //   Get.snackbar('', '加速');
          // }),
        ],
      ),
    );
  }

}