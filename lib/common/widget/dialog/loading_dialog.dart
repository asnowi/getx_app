import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingDialog{

  static show(){
    if(!EasyLoading.isShow){
      EasyLoading.show(status: 'loading...');
    }
  }

  static dismiss(){
    if(EasyLoading.isShow){
      EasyLoading.dismiss();
    }
  }

}