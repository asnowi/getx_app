import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/ownerInfo/ownerInfo_controller.dart';

class OwnerInfoView extends GetView<OwnerInfoController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white ,
        elevation: 0.0,
        title: Text('车主信息填写',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
        leading: IconButton(
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
        color: Colors.white,
        child: SingleChildScrollView(
          controller: controller.controller,
          child: Column(
            children: [
                Text('sssss'),
            ],
          ),
        ),
      ),
    );
  }
}