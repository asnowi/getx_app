import 'package:get/get.dart';
import 'package:getx_app/common/utils/index.dart';

class CodeController extends GetxController{


  String _subTitle = '验证码已发送至 ';
  
  String get subTitle {
    return _subTitle;
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
}