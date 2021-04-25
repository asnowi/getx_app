
import 'package:flutter_baidu_mapapi_utils/src/utils/bmf_utils_calculate.dart';
import 'package:getx_app/common/widget/baidu/index.dart';

class DistanceUtil{

  static Future<double> getDistance(BMFCoordinate startCoord,BMFCoordinate endCoord) async{
    return await BMFCalculateUtils.getLocationDistance(startCoord, endCoord);

  }
}