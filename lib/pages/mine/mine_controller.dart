import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_app/common/config/const.dart';
import 'package:getx_app/common/db/index.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/global.dart';

class MineController extends GetxController{

  var _isLogin = false.obs;

  bool get isLogin {
    return _isLogin.value;
  }

  void changeLogin(bool b){
    this._isLogin.value = b;
  }


  User getUser() {
    return Global.userInfo;
  }

  StreamSubscription<CommonEvent> _subscription;

  @override
  void onInit() {

    changeLogin(getUser() != null);

    _subscription = EventBusUtils.listen((event) {
      LogUtils.GGQ('event:${event.code}');
      if(event.code == EventCode.EVENT_LOGIN){
        changeLogin(getUser() != null);
        LogUtils.GGQ('islogin ->${isLogin}');
        LogUtils.GGQ('user ->${getUser()}');
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    if(_subscription != null){
      _subscription.cancel();
    }
    super.dispose();
  }

}