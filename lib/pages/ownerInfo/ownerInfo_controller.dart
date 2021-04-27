import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/picker/index.dart';

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

  ExpansionPanelCallback expandCallback(int panelIndex, bool isExpanded){
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

  String _genderValue;

  String get genderValue => _genderValue;
  void setGenderValue(String val){
    this._genderValue = val;
    update(['gender']);
  }


  @override
  void onReady() {
    // this.setGenderValue(_genderList[0]);
    // this.setDateValue('1990-10-09');
    super.onReady();
  }

  ///性别选择器
  void showChooseGenderDialog(BuildContext context) {
    Pickers.showSinglePicker(context, data: _genderList,selectData: _genderValue, pickerStyle: PickerDefaultStyle(title: '选择性别'),
    onChanged: (dynamic data){}, onConfirm: (dynamic data){
      LogUtils.GGQ('确定->${data}');
      setGenderValue(data);
    });
  }


  String _dateValue;
  String get dateValue => _dateValue;
  void setDateValue(String val){
    this._dateValue = val;
    update(['birthday']);
  }

  /// 日期选择器
  void showChooseDateDialog(BuildContext context) {
    Pickers.showDatePicker(
      context,
      // 模式，详见下方
      mode: DateMode.YMD,
      // maxDate: PDuration.now(),
      pickerStyle: PickerDefaultStyle(title: '选择日期'),
      onConfirm: (PDuration data) {
        //PDuration{year: 2021, month: 4, day: 27, hour: 0, minute: 0, second: 0}
        _dateValue = '${data.year}年${data.month}月${data.day}日';
        DateTime utcTime = DateTime.utc(data.year,data.month,data.day);
        //时间戳  1619481600000
        int timestamp = utcTime.millisecondsSinceEpoch;
        LogUtils.GGQ('确定->${dateValue}');
        LogUtils.GGQ('确定->${timestamp}');
        setDateValue(_dateValue);
      },
      onChanged: (PDuration data){},
    );
  }


  void onNext(){
    Get.toNamed(AppRoutes.ebikeInfo);
  }

}


/// 默认样式
class PickerDefaultStyle extends PickerStyle {
  PickerDefaultStyle({String title}) {
    this.headDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)));
    if (title != null && title != '') {
      this.title = Center(child: Text(
          title, style: TextStyle(color: Colors.black, fontSize: 14)));
    }
  }
}