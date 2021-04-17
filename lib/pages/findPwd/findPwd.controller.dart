import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';

class FindPwdController extends GetxController{


  final TextEditingController phoneController = TextEditingController();

  final _phone = ''.obs;

  final _isShowDel = false.obs;

  bool get isShowDel {
    return _isShowDel.value;
  }

  String get phone {
    return _phone.value;
  }

  void setPhone(String s){
    if(s.isBlank){
      this._isShowDel.value = false;
    }else{
      this._phone.value = s;
      this._isShowDel.value = true;
    }
  }


  @override
  void onReady() {
    final map = Get.arguments;
    final phone = map['phone'];
    this.setPhone(phone);
    if(phone != null){
      phoneController.text = phone;
    }
    super.onReady();
  }


  void toCodePage(){
    if(phoneController.text.isBlank){
      Get.snackbar('', '请输入手机号');
      return;
    }

    if(!RegexUtils.isPhone(phoneController.text)){
      Get.snackbar('', '您输入的手机号格式不正确');
      return;
    }
    Get.toNamed(AppRoutes.code,arguments: {'phone': phoneController.text});
  }

}