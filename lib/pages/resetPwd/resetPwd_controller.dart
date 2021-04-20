import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';

class ResetPwdController extends GetxController{

  final TextEditingController inputController = TextEditingController();

  bool _eyeAction = false;
  bool get eyeAction {
    return _eyeAction;
  }

  void changeEyeAction(bool b){
    this._eyeAction = b;
    update(['input']);
  }


  bool _hasEye = false;
  bool get hasEye {
    return this._hasEye;
  }

  void changeHasEye(bool b){
    this._hasEye = b;
    update(['input']);
  }

  String _phone = '';
  String get phone {
    return _phone;
  }

  @override
  void onInit() {
    LogUtils.GGQ('---onInit -');
    super.onInit();
  }

  @override
  void onReady() {
   final map = Get.arguments;
   final phone = map['phone'];
   if(phone != null){
     this._phone = phone;
     LogUtils.GGQ('---Phone ->>${phone}');
   }
    super.onReady();
  }


  void onSubmit(){
    if(phone.isEmpty){
      Get.snackbar('', '手机号错误！');
      return;
    }

    if(inputController.text.isEmpty){
      Get.snackbar('', '请输入新密码！');
      return;
    }

    if(inputController.text.length < 8 || inputController.text.length > 20){
      Get.snackbar('', '请输入8至20个字符！');
      return;
    }

    //完成
    Get.back();
  }

}