import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/assets.dart';
import 'package:getx_app/pages/userIDCard/userIDCard_controller.dart';
import 'package:getx_app/common/utils/index.dart';

class UserIDCardView extends GetView<UserIDCardController>{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white ,
          elevation: 0.0,
          title: Text('车主身份证上传',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
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
                _buildTop(),
                _buildIDCardA(context),
                _buildIDCardB(context),
                _buildDivider(),
                _buildExample(),
                _buildNext()
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildTop(){
    return Container(
      padding: EdgeInsets.only(top: 30,bottom: 10),
      child: Text('请您上传车主身份证照片',style: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),),
    );
  }

  Widget _buildIDCardA(BuildContext context){
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 0.62.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('身份证正面',style: TextStyle(
                fontSize: 14,
                color: Colors.grey
            ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            AspectRatio(aspectRatio: 16.0/9.0,child: Container(
              child: Image.asset(AssetsProvider.imagePath('id_main'),fit: BoxFit.cover,),
            ),)
          ],
        ),
      ),
      onTap: (){
        //Get.snackbar('', '身份证正面');
        controller.applyImagePicker(context,1);
      },
    );
  }

  Widget _buildIDCardB(BuildContext context){
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 0.62.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('身份证反面',style: TextStyle(
                fontSize: 14,
                color: Colors.grey
            ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            AspectRatio(aspectRatio: 16.0/9.0,child: Container(
              child: Image.asset(AssetsProvider.imagePath('id_sub'),fit: BoxFit.cover,),
            ),)
          ],
        ),
      ),
      onTap: (){
        //Get.snackbar('', '身份证反面');
        controller.applyImagePicker(context,2);
      },
    );
  }

  Widget _buildDivider(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      child: Row(
        children: [
          Expanded(child: Divider(height: .5,thickness: .5,endIndent:16,color: Colors.grey[300],),flex: 1,),
          Text('拍摄示例',style: TextStyle(fontSize: 12,color: Colors.grey),),
          Expanded(child: Divider(height: .5,thickness: .5,indent:16,color: Colors.grey[300],),flex: 1,),
        ],
      ),
    );
  }

  Widget _buildExample(){
    return Container(
      child: Row(
        children: [
          Expanded(child: _buildExampleItem(1),),
          Expanded(child: _buildExampleItem(2),),
          Expanded(child: _buildExampleItem(3),),
          Expanded(child: _buildExampleItem(4),),
        ],
      ),
    );
  }

  Widget _buildExampleItem(int index){
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 18),child: AspectRatio(aspectRatio: 16.0/9.0,child: Image.asset(getExampleItemImg(index),),),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(getExampleItemIcon(index),width: 10,height: 10,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
            Text('标准拍摄',style: TextStyle(fontSize: 10,color: Colors.black54),)
          ],
        ),
      ],
    );
  }

  Widget _buildNext(){
    return Container(
      margin: EdgeInsets.only(top: 30,bottom: 20),
      width: 0.62.sw,
      height: 44.h,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            side: BorderSide(width: 1, color: Colors.grey[200]),
          ),
          onPressed: (){
            Get.snackbar('', '请上传身份证');
          },
          child: Text('下一步',style: TextStyle(color: Colors.black54,fontSize: 14),)
      ),
    );
  }


  String getExampleItemImg(int index){
    if(index == 1){
      return AssetsProvider.imagePath('id_r1');
    }
    if(index == 1){
      return AssetsProvider.imagePath('id_e1');
    }
    if(index == 1){
      return AssetsProvider.imagePath('id_e2');
    }
    return AssetsProvider.imagePath('id_e3');
  }

  String getExampleItemIcon(int index){
    if(index == 1){
      return AssetsProvider.imagePath('ic_right');
    }
    return AssetsProvider.imagePath('ic_wrong');
  }

}