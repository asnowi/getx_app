
import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/dialog/loading_dialog.dart';

class CodeController extends GetxController{

  final TextEditingController controller = TextEditingController();

  String _subTitle = '验证码已发送至 ';
  
  String get subTitle {
    return _subTitle;
  }

  String _timeCount = '10\t';
  void changeTimeCount(String s) {
    this._timeCount = s;
    update(['timer']);
  }

  String get timeCount {
    return _timeCount;
  }

  TimerUtil _timer;

  Color _sendColor = Colors.grey;
  void changeSendColor(Color c){
    this._sendColor = c;
    this.changeAllow(true);
  }

  Color get sendColor {
    return _sendColor;
  }


  String _phone = '';

  String get phone => _phone;

  var _isAllow = true;
  bool get isAllow => _isAllow;
  void changeAllow(bool b){
    this._isAllow = b;
  }





  @override
  void onInit() {
    _timer = TimerUtil(mInterval: Duration.millisecondsPerSecond,mTotalTime: 10000);
    _timer.setOnTimerTickCallback((millisUntilFinished) {
      final tick = (millisUntilFinished/1000).toInt();
      LogUtils.GGQ('tick->${tick}');
      if(tick <= 0){
        this.changeTimeCount('10\t');
        this.changeSendColor(Colors.blue);
        this._timer.cancel();
      }else{
        this.changeTimeCount('${tick}\t');
      }
    });
    super.onInit();
  }
  
  @override
  void onReady() {
    final map = Get.arguments;
    final phone = map['phone'];
    if(phone != null){
      this.changeAllow(true);
      this._phone = phone;
      // _subTitle = '${_subTitle + phone}';
      _subTitle += FormatUtils.formatPhone(phone);
      update(['subTitle']);
      this.sendCodeByPhone(_phone);
    }
    super.onReady();
  }

  void sendCodeByPhone(String phone) {
    if(phone.isBlank){
      Get.snackbar('', '未获取到手机号码！');
      return;
    }
    //发起 http 请求
    //成功后,开启倒计时
    if(_timer.isActive()){
      Get.snackbar('', '操作频繁，请稍候再试！');
    }else{
      bool isSuccess = true;
      LoadingDialog.show();
      this.changeAllow(false);
      DelayedUtil.delayed(() {
        if(isSuccess){
          _timer.mTotalTime = 10000;
          _timer.startCountDown();
          Get.snackbar('', '发送短信->${phone}');
        }
        LoadingDialog.dismiss();
      },milliseconds: 3000);
    }
  }

  void onSubmitted(String input,String phone){
    if(input.isBlank){
      Get.snackbar('', '您输入的验证码有误！');
      return;
    }

    // 提交验证码,如果正确则关闭当前页
    bool isSuccess = true;
    LoadingDialog.show();
    DelayedUtil.delayed(() {
      LoadingDialog.dismiss();
      if(isSuccess){
        Get.toNamed(AppRoutes.resetPwd,arguments: {'phone': phone});
      }
    });
  }

  @override
  void onClose() {
    if(_timer != null){
      _timer.cancel();
    }
    super.onClose();
  }
}