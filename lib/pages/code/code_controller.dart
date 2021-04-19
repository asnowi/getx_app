
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';

class CodeController extends GetxController{

  final TextEditingController controller = TextEditingController();

  String _subTitle = '验证码已发送至 ';
  
  String get subTitle {
    return _subTitle;
  }

  String _timeCount = '60\t';
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


  @override
  void onInit() {
    _timer = TimerUtil(mInterval: Duration.millisecondsPerSecond,mTotalTime: 60000);
    _timer.setOnTimerTickCallback((millisUntilFinished) {
      final tick = (millisUntilFinished/1000).toInt();
      LogUtils.GGQ('tick->${tick}');
      if(tick <= 0){
        this.changeTimeCount('60\t');
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
      // _subTitle = '${_subTitle + phone}';
      _subTitle += FormatUtils.formatPhone(phone);
      update(['subTitle']);
    }
    super.onReady();
  }

  void inputSubmitted(value) {
    if(!_timer.isActive()){
      _timer.mTotalTime = 60000;
      _timer.startCountDown();
      //发送短信
      Get.snackbar('', '发送短信->${value}');
    }
  }

  @override
  void onClose() {
    if(_timer != null){
      _timer.cancel();
    }
    super.onClose();
  }
}