import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:images_picker/images_picker.dart';
import 'package:path_provider/path_provider.dart';

class UserIDCardController extends GetxController{

  final ScrollController controller = ScrollController();

  // Future<void> applyPermissions(BuildContext context) async{
  //   if(await Permission.camera.request().isGranted) {
  //       LogUtils.GGQ('相机权限允许');
  //       showBottomDialog(context,1);
  //   }else{
  //     LogUtils.GGQ('相机权限未通过');
  //     PermissionDialog.show(context);
  //   }
  // }

  void applyImagePicker(BuildContext context,int type){
    showBottomDialog(context,type);
  }


  void showBottomDialog(BuildContext context,int type){
    showModalBottomSheet(
        context: context, 
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          alignment: Alignment.bottomCenter,
          height: 200.h,
          child: Column(
            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop('ok');
                  openByType(context,1);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('拍照',style: TextStyle(color: Colors.blue,fontSize: 12.sp),),
                  width: 0.88.sw,
                  height: 35.h,
                ),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12.w))
                    ),
                    backgroundColor: Colors.white
                ),
              ),
              Divider(height: .1.h,thickness: .1.h,color: Colors.transparent,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop('ok');
                  openByType(context,2);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('相册',style: TextStyle(color: Colors.blue,fontSize: 12.sp),),
                  width: 0.88.sw,
                  height: 35.h,
                ),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.w))
                    ),
                    backgroundColor: Colors.white
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop('cancel');
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('取消',style: TextStyle(color: Colors.blue,fontSize: 12.sp),),
                  width: 0.88.sw,
                  height: 35.h,
                ),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.w))
                    ),
                    backgroundColor: Colors.white
                ),
              ),
            ],
          ),
        )
    );
  }

  /// ImagePicker 引擎实例
  // final _picker = ImagePicker();

  void openByType(BuildContext context,type){
    LogUtils.GGQ('type=>${type}');
    if(type == 1) {
      getImageByCamer();
    }else if(type == 2){
      getImageByGallery();
    }
  }


  Future getImageByCamer() async {
    final List<Media> result = await ImagesPicker.openCamera(
      pickType: PickType.image,
    );
    if(result.isBlank){
      LogUtils.GGQ('--->>>>>拍照失败');
    }else{
      final data = result.last;
      LogUtils.GGQ('--->>>>>拍照:${ data.path}');
    }
  }

  Future getImageByGallery() async {
    final List<Media> result = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
    if(result.isBlank){
      LogUtils.GGQ('--->>>>>相册失败');
    }else{
      final data = result.last;
      LogUtils.GGQ('--->>>>>相册:${ data.path}');
    }
  }


  Future<String> compassImage(File imageFile) async{
    //压缩对象
    CompressObject compressObject = CompressObject(
      imageFile:imageFile, //image
      path: await getApplicationDocumentsDirectory().then((value) => value.path), //compress to path
      quality: 85,//first compress quality, default 80
      step: 9,//compress quality step, The bigger the fast, Smaller is more accurate, default 6
      mode: CompressMode.LARGE2SMALL,//default AUTO
    );
    return await Luban.compressImage(compressObject);
  }



}