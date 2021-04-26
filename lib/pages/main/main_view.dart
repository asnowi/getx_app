import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/refresh/refresh.dart';
import 'package:getx_app/pages/main/main_controller.dart';

class MainView extends GetView<MainController> {

  @override
  MainController get controller => Get.put(MainController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white ,
        elevation: 0.0,
        title: Text('平安电车',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: Refresh(
          controller: controller.refreshController,
          enablePullDown: controller.enablePullDown,
          enablePullUp: controller.enablePullUp,
          onRefresh: _onRefresh,
          content: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent(){
    return ListView.builder(itemBuilder: (BuildContext context, int index) => _buildItem(context,index),itemCount: 5);
  }

  Widget _buildItem(BuildContext context, int index){
    if(index == 0){
      return GetBuilder<MainController>(
          id: 'tip',
          builder: (_) => AnimatedOpacity(
            opacity: controller.tipOpacity,
            duration: Duration(milliseconds: 500),
            child: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          ///主轴的对齐方式
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error,color: Colors.redAccent,size: 18,),
            Padding(padding: EdgeInsets.only(right: 6)),
            Expanded(child: Text('您有新的报警信息需要查看',style: TextStyle(fontSize: 14,color: Colors.redAccent),),flex: 1,),
            Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.redAccent,),
          ],
        ),
      ),
            onEnd: controller.onEnd,
          )
      );
    }

    if(index == 1){
      return _buildItemChild(index,Icons.pedal_bike,'车辆登记','信息录入，定位器安装');
    }

    if(index == 2){
      return _buildItemChild(index,Icons.filter,'登记记录','历史定位器安装记录');
    }

    if(index == 3){
      return _buildItemChild(index,Icons.select_all,'车辆查找','按设备号/车牌号查询');
    }

    if(index == 4){
      return _buildItemChild(index,Icons.home_work,'便民服务','周边服务站管理');
    }

    return Container();
  }



  void _onRefresh() {
    DelayedUtil.delayed(() {
      if(controller.refreshController.isRefresh){
        controller.refreshController.refreshToIdle();
      }
    });
  }


  Widget _buildItemChild(int index,IconData icon,String title,String subTitle){
    return InkWell(
      child: Container(
        height: 92.h,
        margin: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          ///主轴的对齐方式
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(right: 8)),
            Icon(icon,size: 32,color: Colors.blue,),
            Padding(padding: EdgeInsets.only(right: 20)),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
                Text(subTitle,style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),),
              ],
            ),flex: 1,),
            Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.blue,),
          ],
        ),
      ),
      onTap: (){
        switch (index){
          case 1:
              Get.toNamed(AppRoutes.userIDCard);
            break;
          case 2:

            break;
          case 3:

            break;
          case 4:

            break;
          default:{
            LogUtils.GGQ('未匹配到->>${index}');
          }
        }
      },
    );
  }

}

