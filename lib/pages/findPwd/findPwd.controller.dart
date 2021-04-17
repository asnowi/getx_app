import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPwdController extends GetxController{

  final TextEditingController phoneController = TextEditingController(text: '');


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
      phoneController.text = '';
    }else{
      this._phone.value = s;
      this._isShowDel.value = true;
      phoneController.text = s;
    }
  }


  @override
  void onReady() {
    final map = Get.arguments;
    final phone = map['phone'];
    this.setPhone(phone);
    super.onReady();
  }


}