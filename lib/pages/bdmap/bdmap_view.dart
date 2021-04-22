import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/baidu/index.dart';
import 'package:getx_app/pages/bdmap/bdmap_controller.dart';

class BDMapView extends GetView<BDMapController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconfont.backOut,size: 18,
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 120.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              mini: true,
              heroTag: "locateMyself",
              child: Tooltip(
                message: "定位到自己",
                child: Icon(
                  Icons.my_location_sharp,
                  size: 18,
                ),
              ),
              elevation: 5, //阴影
              onPressed: () {
                controller.locUserCenter();
              },
            ),
          ],
        ),
      ),
    );
  }


    Widget _buildMap(){
      LogUtils.GGQ('_buildMap');
      return GetBuilder<BDMapController>(
          id: 'updateMap',
          builder: (_) => controller.hasLoad? BMFMapWidget(
          onBMFMapCreated: (c){
            controller.mapController = c;
            // 定位自己
            controller.mapController?.showUserLocation(true);
            // 开始定位
           startLocation();
          },
          mapOptions: controller.mapOptions
      ): CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),);
    }

}
