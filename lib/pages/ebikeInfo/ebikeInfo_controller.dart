import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';

class EbikeInfoController extends GetxController{

  static const int FLEX_TITLE = 3;
  static const int FLEX_CONTENT = 5;

  final ScrollController controller = ScrollController();

  final TextEditingController deviceNoController = TextEditingController();
  final TextEditingController ebikeNoController = TextEditingController();
  final TextEditingController frameNoController = TextEditingController();
  final TextEditingController engineNoController = TextEditingController();
  final TextEditingController buyPriceController = TextEditingController();


  final EdgeInsets itemPadding = EdgeInsets.symmetric(vertical: 8);


  var _isBasicExpanded = true;
  bool get isBasicExpanded => _isBasicExpanded;

  void changeBasicExpanded(bool b){
    this._isBasicExpanded = b;
    update(['expand']);
  }

  var _isBuyExpanded = true;
  bool get isBuyExpanded => _isBuyExpanded;

  void changeBuyExpanded(bool b){
    this._isBuyExpanded = b;
    update(['expand']);
  }

  var _isSafeExpanded = true;
  bool get isSafeExpanded => _isSafeExpanded;

  void changeSafeExpanded(bool b){
    this._isSafeExpanded = b;
    update(['expand']);
  }


  ExpansionPanelCallback expansionCallback(int panelIndex, bool isExpanded){
    LogUtils.GGQ('panelIndex ->${panelIndex} --isExpanded-> ${isExpanded}');
    switch(panelIndex){
      case 0:
        changeBasicExpanded(!isExpanded);
        break;
      case 1:
        changeBuyExpanded(!isExpanded);
        break;
      case 2:
        changeSafeExpanded(!isExpanded);
        break;
    }
  }


  void onNext(){

  }
}