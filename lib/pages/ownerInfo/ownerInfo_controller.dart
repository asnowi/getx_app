import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
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

  List<String> _genderList = ['男','女'];


  ///性别选择器
  void showChooseGenderDialog(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          //56
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.3.sh),
            child: ListView.separated(
              itemCount: _genderList == null ? 0 : _genderList.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                );
              },
            ),
          );
        });
  }

  /// 日期选择器
  void showChooseDateDialog(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          //56
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.3.sh),
            child: ListView.separated(
              itemCount: _genderList == null ? 0 : _genderList.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                );
              },
            ),
          );
        });
  }


  void onNext(){
    Get.toNamed(AppRoutes.ebikeInfo);
  }

}