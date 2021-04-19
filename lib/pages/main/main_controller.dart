import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainController extends GetxController{

  final RefreshController refreshController = RefreshController();

//  允许下拉
  final bool enablePullDown = true;
//  允许上拉加载
  final bool enablePullUp = false;

  double _tipOpacity = 1.0;
  double get tipOpacity {
    return _tipOpacity;
  }

  void changeTipOpacity(){
    _tipOpacity = _tipOpacity <= 0.0 ? 1.0 : 0.0;
    update(['tip']);
  }

  void onEnd(){
    if(tipOpacity <= 0.0){

    }
  }


}