import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';

class OwnerInfoController extends GetxController{

  static const int FLEX_TITLE = 3;
  static const int FLEX_CONTENT = 5;

  final ScrollController controller = ScrollController();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();

  final EdgeInsets itemPadding = EdgeInsets.symmetric(vertical: 8);


  var _isBasicExpanded = true;
  bool get isBasicExpanded => _isBasicExpanded;

  void changeBasicExpanded(bool b){
    this._isBasicExpanded = b;
    update(['expand']);
  }

  var _isContactExpanded = true;
  bool get isContactExpanded => _isContactExpanded;

  void changeContactExpanded(bool b){
    this._isContactExpanded = b;
    update(['expand']);
  }

  ExpansionPanelCallback expansionCallback(int panelIndex, bool isExpanded){
    LogUtils.GGQ('panelIndex ->${panelIndex} --isExpanded-> ${isExpanded}');
    switch(panelIndex){
      case 0:
        changeBasicExpanded(!isExpanded);
        break;
      case 1:
        changeContactExpanded(!isExpanded);
        break;
    }
  }

  void onNext(){

  }

}