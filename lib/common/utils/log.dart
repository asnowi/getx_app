import 'package:getx_app/global.dart';

class LogUtils{

  static void GGQ(Object msg) {
    if(!Global.isRelease && msg != null){
      StringBuffer sb = new StringBuffer();
      sb.write('GGQ->:');
      sb.write(msg);
      print(sb.toString());
    }
  }
}