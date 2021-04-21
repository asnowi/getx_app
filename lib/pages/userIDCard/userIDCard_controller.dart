import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
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

  final int TYPE_IDCARD_A = 1;
  final int TYPE_IDCARD_B = 2;
  final int TYPE_CAMERA = 1;
  final int TYPE_GALLERY = 2;

  void showBottomDialog(BuildContext context,int type){
    showModalBottomSheet(
        context: context, 
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          alignment: Alignment.bottomCenter,
          height: 186.h,
          child: Column(
            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop('ok');
                  // openByType(context,type);
                  // type 1 正面  2 反面
                  // 拍照
                  openByType(context,type,TYPE_CAMERA);

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
                  openByType(context,type,TYPE_GALLERY);
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
              Padding(padding: EdgeInsets.symmetric(vertical: 4.h)),
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

  String _idCardA = '';
  String get idCardA => _idCardA;
  void setIDCardA(String path){
    this._idCardA = path;
    update(['idCardA']);
  }

  String _idCardB = '';
  String get idCardB => _idCardB;
  void setIDCardB(String path){
    this._idCardB = path;
    update(['idCardB']);
  }

  void openByType(BuildContext context,int type1,int type2){
    LogUtils.GGQ('正反面=>${type1}');
    LogUtils.GGQ('相机相册=>${type2}');

    if(type2 == TYPE_CAMERA){ //相机
      try{
        getImageByCamera(type1);
      }catch(e){
        LogUtils.GGQ('--->>>>>ImageByCamera error -');
      }
    }else if(type2 == TYPE_GALLERY){ //相册
      try{
        getImageByGallery(type1);
      }catch(e){
        LogUtils.GGQ('--->>>>>ImageByGallery error -');
      }
    }
  }


  Future getImageByCamera(int type) async {
    final List<Media> result = await ImagesPicker.openCamera(
      pickType: PickType.image,
    );
    if(result.isBlank){
      LogUtils.GGQ('--->>>>>拍照失败');
      Get.snackbar('', '拍照失败');
    }else{
      final data = result.last;
      LogUtils.GGQ('--->>>>>拍照:${ data.path}');
      if(!data.isBlank && !data.path.isBlank){
        if(type == TYPE_IDCARD_A){
          this.setIDCardA(data.path);
        }else if(type == TYPE_IDCARD_B){
          this.setIDCardB(data.path);
        }
      }
    }
  }

  Future<void> getImageByGallery(int type) async {
    final List<Media> result = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
    if(result.isBlank){
      LogUtils.GGQ('--->>>>>相册失败');
      Get.snackbar('', '选择相册失败');
    }else{
      final data = result.last;
      LogUtils.GGQ('--->>>>>相册:${ data.path}');
      if(!data.isBlank && !data.path.isBlank){
        if(type == TYPE_IDCARD_A){
          this.setIDCardA(data.path);
        }else if(type == TYPE_IDCARD_B){
          this.setIDCardB(data.path);
        }
      }
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


  void onNext(){
    if(idCardA.isEmpty){
      Get.snackbar('', '请上传身份证正面照片');
      return;
    }
    if(idCardB.isEmpty){
      Get.snackbar('', '请上传身份证反面照片');
      return;
    }

    Get.toNamed(AppRoutes.ownerInfo);
  }

}