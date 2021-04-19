
import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';

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
  }

  Color get sendColor {
    return _sendColor;
  }


  String _phone = '';

  StreamSubscription<CommonEvent> _subscription;

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
    //监听页面并关闭
    _subscription = EventBusUtils.listen((event) {
      LogUtils.GGQ('event:${event.code}');
      if(event.code == EventCode.EVENT_BACK_LOGIN){
        LogUtils.GGQ('验证码页面返回');
        Get.back();
      }
    });
    super.onInit();
  }
  
  @override
  void onReady() {
    final map = Get.arguments;
    final phone = map['phone'];
    if(phone != null){
      this._phone = phone;
      // _subTitle = '${_subTitle + phone}';
      _subTitle += FormatUtils.formatPhone(phone);
      update(['subTitle']);
    }
    super.onReady();
  }

  void inputSubmitted(value) {
    if(!_timer.isActive()){
      _timer.mTotalTime = 10000;
      _timer.startCountDown();
      //发送短信
      Get.snackbar('', '发送短信->${value}');
      //成功后跳转页面
      if(!_phone.isBlank){
        _timer.cancel();
        LogUtils.GGQ('--->>>${_phone}');
        Get.toNamed(AppRoutes.resetPwd,arguments: {'phone':_phone});
      }else{
        Get.snackbar('', '未获取到手机号，请返回重试！');
      }
    }
  }

  @override
  void onClose() {
    if(_timer != null){
      _timer.cancel();
    }
    if(_subscription != null){
      LogUtils.GGQ('验证码页面 event 关闭');
      _subscription.cancel();
    }
    super.onClose();
  }
}