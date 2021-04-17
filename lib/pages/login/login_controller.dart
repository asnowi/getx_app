import 'package:get/get.dart';

class LoginController extends GetxController{

  var _isPhoneDel = false.obs;

  bool get isPhoneDel {
    return _isPhoneDel.value;
  }

  void changePhoneDel(bool b){
    this._isPhoneDel.value = b;
  }


  var _hasEye = false.obs;
  bool get hasEye {
    return _hasEye.value;
  }

  void changeEye(bool b){
    this._hasEye.value = b;
    if(this._hasEye.value && this._hasEye.value){
      this._hasLogin.value = true;
    }else{
      this._hasLogin.value = false;
    }
  }

  var _eyeAction = false.obs;

  bool get eyeAction {
    return _eyeAction.value;
  }

  void onEyeAction(){
    this._eyeAction.value = !this._eyeAction.value;
  }



  var _hasLogin = false.obs;

  bool get hasLogin{
    return _hasLogin.value;
  }

  void changeLogin(bool b){
    this._hasLogin.value = b;
  }

}