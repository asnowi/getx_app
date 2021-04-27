import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/router/app_pages.dart';
import 'package:getx_app/common/utils/index.dart';
import 'package:getx_app/common/widget/picker/index.dart';
import 'package:getx_app/common/widget/scan/index.dart';

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


  ExpansionPanelCallback expandCallback(int panelIndex, bool isExpanded){
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


  void scanner(BuildContext context) async{
      // Get.toNamed(AppRoutes.scanner);
   final data = await Get.toNamed(AppRoutes.scanner);
    if(data != null){
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 300);
      }
      LogUtils.GGQ('data-->${data}');
      deviceNoController.text = data;
      update(['deviceNo']);
    }
  }



  List<String> _brandList = ['新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛','新日','爱玛',];

  String _brandValue;

  String get brandValue => _brandValue;
  void setBrandValue(String val){
    this._brandValue = val;
    update(['brand']);
  }

  void showChooseBrandDialog(BuildContext context){
    Pickers.showSinglePicker(context, data: _brandList, pickerStyle: PickerDefaultStyle(title: '选择品牌'),
        onChanged: (dynamic data){}, onConfirm: (dynamic data){
          LogUtils.GGQ('确定->${data}');
          setBrandValue(data);
        });
  }


  String _dateValue;
  String get dateValue => _dateValue;
  void setDateValue(String val){
    this._dateValue = val;
    update(['buyTime']);
  }


  /// 日期选择器
  void showChooseBuyDateDialog(BuildContext context) {
    Pickers.showDatePicker(
      context,
      // 模式，详见下方
      mode: DateMode.YMD,
      maxDate: PDuration.now(),
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