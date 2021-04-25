import 'package:getx_app/common/utils/distance.dart';
import 'package:getx_app/common/widget/baidu/index.dart';

class CarTrackUtil{

  static Future<List<List<BMFCoordinate>>> splitPoint4MoveDistance(List<BMFCoordinate> actualLatLngList,int moveDistance) async{
    List<List<BMFCoordinate>> moveLatLngList =[];
    List<BMFCoordinate> my = [];
    my.add(actualLatLngList[0]);
    moveLatLngList.add(my);
    for(int i = 1; i < actualLatLngList.length; i++){
      double dis = await DistanceUtil.getDistance(actualLatLngList[i - 1], actualLatLngList[i]);
      int distance = dis.toInt();
      if (distance <= moveDistance) {
        my.clear();
        my.add(actualLatLngList[i]);
        moveLatLngList.add(my);
      }else{
        int count = (distance/moveDistance - ((distance % moveDistance == 0)? 1 : 0)).toInt();
        BMFCoordinate subLatLng = minus(actualLatLngList[i],actualLatLngList[i - 1]);
        BMFCoordinate divLatLng = div(subLatLng,count);
        List<BMFCoordinate> _list = [];
        for (int j = 0; j <= count; j++) {
          BMFCoordinate s1 = times(divLatLng,j + 1);
          BMFCoordinate ll = plus(actualLatLngList[i - 1], s1);
          _list.add(ll);
        }
        _list.add(actualLatLngList[i]);
        moveLatLngList.add(_list);
      }
    }
    return moveLatLngList;
  }

  static BMFCoordinate plus(BMFCoordinate c1,BMFCoordinate c2){
    return BMFCoordinate(c1.latitude + c2.latitude,c1.longitude + c2.longitude);
  }

  static BMFCoordinate minus(BMFCoordinate c1,BMFCoordinate c2){
    return BMFCoordinate(c1.latitude - c2.latitude,c1.longitude = c2.longitude);
  }

  static BMFCoordinate times(BMFCoordinate c,int times){
    return BMFCoordinate(c.latitude * times,c.longitude * times);
  }

  static BMFCoordinate div(BMFCoordinate c,int div){
      return BMFCoordinate(c.latitude / div,c.longitude /div);
  }



}